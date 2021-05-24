{ pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
      (
        nerdfonts.override {
          fonts = [ "SourceCodePro"];
        }
      )
    ];

    fontconfig = {
      allowBitmaps = true;

      defaultFonts = {
        emoji = [
          "SauceCodePro Nerd Font Mono"
        ];
        monospace = [
          "Source Code Pro"
          "SauceCodePro Nerd Font Mono"
        ];
        sansSerif = [
          "Source Sans Pro"
          "SauceCodePro Nerd Font Mono"
        ];
        serif = [
          "Source Serif Pro"
          "SauceCodePro Nerd Font Mono"
        ];
      };

      useEmbeddedBitmaps = true;
    };

    fontDir = {
      enable = true;
    };
  };

  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  networking = {
    # Enable firewall.
    firewall = {
      enable = true;
    };

    # Detect and manage network connections.
    networkmanager = {
      enable = true;
    };
  };

  time.timeZone = "Australia/Melbourne";

  services = {
    # Enable support for gpg smart cards (yubikey).
    pcscd = {
      enable = true;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      shandogs = {
        isNormalUser = true;
        extraGroups = [
          "wheel"          # Allow sudo.
          "networkmanager" # Allow changing network settings.
        ];
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };
}
