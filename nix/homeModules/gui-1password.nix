{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  options = {
    sshKey = lib.mkOption {
      type = lib.types.str;
      default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPCP4SqkSwxkX9dkk36idNz7wCtXfa84hwkkflJVuDF";
    };
  };

  config = {
    # allow signing commits with our ssh key
    home.file.".ssh/allowed_signers".text = "* ${config.sshKey}";

    programs = {
      # 1password wrapper for cli authentication
      _1password-shell-plugins = {
        enable = true;
        plugins = with pkgs; [gh];
      };

      # version control
      git = {
        extraConfig = {
          # sign commits
          commit.gpgsign = true;
          # sign commits with ssh instead of gpg
          gpg = {
            ssh = {
              allowedSignersFile = "~/.ssh/allowed_signers";
              program = lib.mkMerge [
                (lib.mkIf pkgs.stdenv.isLinux "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}")
                (lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign")
              ];
            };
            format = "ssh";
          };
          # sign commits witn our ssh key
          user.signingkey = config.sshKey;
        };
      };

      # ssh client
      ssh = {
        enable = true;
        # use 1password as ssh agent
        extraConfig = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.isLinux ''
            IdentityAgent "~/.1password/agent.sock"
          '')
          (lib.mkIf pkgs.stdenv.isDarwin ''
            IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
          '')
        ];
      };
    };
  };
}
