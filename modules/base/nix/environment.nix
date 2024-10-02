{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (builtins) elem;
  inherit (lib.lists) optionals;
  inherit (lib.attrsets) filterAttrs mapAttrs';
in
{
  environment = {
    # git is required for flakes
    systemPackages = [ pkgs.git ];

    # something something backwards compatibility something something nix channels
    etc =
      let
        inherit (config.nix) registry;
        flakes =
          [
            "nixpkgs"
            "beapkgs"
            "home-manager"
          ]
          ++ optionals pkgs.stdenv.hostPlatform.isDarwin [
            "nix-darwin"
          ];
      in
      registry
      |> filterAttrs (name: _: elem name flakes)
      |> mapAttrs' (
        name: value: {
          name = "nix/path/${name}";
          value.source = value.flake;
        }
      );
  };
}
