# This is a topology module, so use it in your global topology, or under `topology = {};` in any participating NixOS node
{
  # Connect node1.lan -> node2.wan
  nodes.node1.interfaces.lan.physicalConnections = [
    {
      node = "node2";
      interface = "wan";
    }
  ];
  # Add home network
  networks.home = {
    name = "Home Network";
    cidrv4 = "192.168.1.1/24";
  };
  # Tell nix-topology that myhost.lan1 is part of this network.
  # The network will automatically propagate via the interface's connections.
  nodes.myhost.interfaces.lan1.network = "home";
}
