{inputs, ...}: {
  system = "aarch64-darwin";
  modules = [
    inputs.self.darwinModules.desktop
    {
      home-manager.users.shanon = {
        home.stateVersion = "24.05";
        sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqk2PNxkCN+aDkyff2MyVp0bJ+QJo52t094WfUP9rHA";
      };

      networking = {
        computerName = "alchemist";
        hostName = "alchemist";
      };

      system.stateVersion = 5;
    }
  ];
}
