{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      gnupg
    ];
  };

  programs = {
    # Enable commit signing.
    git = {
      signing = {
        key = "BF2AD40D0652EF0B";
        signByDefault = true;
      };
    };

    # Enable a basic password manager.
    password-store = {
      enable = true;

      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };
  };

  services = {
    # Enable ssh using gpg.
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableScDaemon = true;
      sshKeys = [
        "D5340EDC116D6C8DFFE80518525712D7E2616FBB"
      ];
    };
  };
}
