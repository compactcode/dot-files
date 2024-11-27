{inputs, ...}: {
  system = "aarch64-darwin";
  modules = [
    inputs.self.darwinModules.desktop
    {
      home-manager.users.shanon = {
        home.stateVersion = "24.05";
      };

      networking = {
        computerName = "alchemist";
        hostName = "alchemist";
      };

      system.stateVersion = "24.05";
    }
  ];
}
