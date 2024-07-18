{ inputs, config, ... }:
{
  imports = [ inputs.nix-topology.nixosModules.topology ];

  topology = {
    id = "my-network";
    self.name = config.networking.hostName;
  };
}
