{
  lib,
  pkgs,
  ...
}: let
  sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPCP4SqkSwxkX9dkk36idNz7wCtXfa84hwkkflJVuDF";
in {
  # allow signing commits with our ssh key
  home.file.".ssh/allowed_signers".text = "* ${sshKey}";

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
            program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          };
          format = "ssh";
        };
        # sign commits witn our ssh key
        user.signingkey = sshKey;
      };
    };

    # ssh client
    ssh = {
      enable = true;
      # use 1password as ssh agent
      extraConfig = ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}
