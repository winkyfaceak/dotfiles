# credits go to @eclairevoyant on this one
{
  lib,
  modulesPath,
  ...
}: let
  inherit (builtins) fetchTree getAttr map;
  inherit (lib.attrsets) attrValues;

  modules = {
    # the name here is arbitrary, and is used as an identifier
    # what matters is the presence of owner, rev and module
    overleaf = {
      # https://github.com/NixOS/nixpkgs/pull/216889
      owner = "JulienMalka";
      rev = "e44089345357851746c320ab2348a7084918c934";
      module = "/services/web-apps/overleaf.nix";
    };
  };

  transcendModules =
    map ({
      owner,
      repo ? "nixpkgs",
      rev,
      module,
    }: {
      disabledModules = modulesPath + module;
      importedModules =
        (fetchTree {
          inherit owner repo rev;
          type = "github";
        })
        + "/nixos/modules/${module}";
    })
    (attrValues modules);
in {
  disabledModules = map (getAttr "disabledModules") transcendModules;
  imports = map (getAttr "importedModules") transcendModules;
}
