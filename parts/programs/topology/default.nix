{ inputs, ... }:
{
  imports = [ inputs.nix-topology.flakeModule ];

  # nix build .#topology.x86_64-linux.config.output
  perSystem = _: {
    topology.modules = [
      ./output.nix
      {
        nodes.node1.interfaces.lan.physicalConnections = [
          {
            node = "node2";
            interface = "wan";
          }
        ];
      }
    ];
  };
}
