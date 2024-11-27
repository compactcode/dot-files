{inputs, ...}: {
  modules = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeManagerModules.stylix
    inputs.self.homeModules.cli-core
    inputs.self.homeModules.cli-development
    inputs.self.homeModules.nixvim
    {
      home = {
        homeDirectory = "/Users/shanon";
        stateVersion = "24.05";
        username = "shanon";
      };
    }
  ];
  system = "aarch64-darwin";
}
