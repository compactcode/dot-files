{inputs, ...}: {
  modules = [
    inputs.stylix.homeManagerModules.stylix
    inputs.self.homeModules.cli-core
    {
      home = {
        homeDirectory = "/home/shanon";
        stateVersion = "24.05";
        username = "shanon";
      };
    }
  ];
  system = "aarch64-darwin";
}
