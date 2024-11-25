{inputs, ...}: {
  modules = [
    inputs.stylix.homeManagerModules.stylix
    inputs.self.homeModules.cli-core
    {
      home = {
        homeDirectory = "/home/shandogs";
        stateVersion = "24.05";
        username = "shandogs";
      };
    }
  ];
  system = "aarch64-darwin";
}
