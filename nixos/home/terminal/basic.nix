{ config, lib, pkgs, ... }:

let
  settings = import ../../settings.nix;

in {
  imports = [
    ./basic/fre.nix
    ./basic/neovim.nix
  ];

  home.packages = with pkgs; [
    aws-vault # secure aws credential handling.
    du-dust # du replacement.
    exa # ls replacement.
    fd # find replacement.
    file # file type detector.
    fre # frequency/recency tracker.
    gnupg # gpg tools.
    pass # gpg based password manager.
    ripgrep # grep replacement.
    tig # git viewer.
    unzip # opening zip archives.
    w3m # html viewer.
  ];

  accounts = {
    email = {
      maildirBasePath = "${config.xdg.dataHome}/mail";

      accounts = {
        personal = {
          primary = true;
          address = settings.user.email;
          realName = settings.user.name;
          userName = settings.user.email;
          passwordCommand = "pass ${settings.user.email}/token";

          imap = {
            host = "imap.fastmail.com";
          };

          smtp = {
            host = "smtp.fastmail.com";
          };

          mbsync = {
            enable = true;

            create = "both";
            expunge = "both";
          };

          msmtp = {
            enable = true;
          };

          notmuch = {
            enable = true;
          };
        };

        split = {
          address = "shanon@splitpayments.com.au";
          realName = settings.user.name;
          userName = "shanon@splitpayments.com.au";
          passwordCommand = "pass shanon@splitpayments.com.au/token";

          imap = {
            host = "imap.gmail.com";
          };

          smtp = {
            host = "smtp.gmail.com";
          };

          mbsync = {
            enable = true;

            create = "both";
            expunge = "both";

            patterns = ["*" "![Gmail]*"];

            extraConfig = {
              channel = {
                Sync = "All";
              };
            };
          };

          msmtp = {
            enable = true;
          };

          notmuch = {
            enable = true;
          };
        };

        legacy = {
          address = "shanonmcquay@gmail.com";
          realName = settings.user.name;
          userName = "shanonmcquay@gmail.com";
          passwordCommand = "pass shanonmcquay@gmail.com/token";

          imap = {
            host = "imap.gmail.com";
          };

          smtp = {
            host = "smtp.gmail.com";
          };

          mbsync = {
            enable = true;

            create = "both";
            expunge = "both";

            patterns = ["*" "![Gmail]*"];

            extraConfig = {
              channel = {
                Sync = "All";
              };
            };
          };

          msmtp = {
            enable = true;
          };

          notmuch = {
            enable = true;
          };
        };
      };
    };
  };

  programs = {
    alot = {
      enable = true;
    };

    # cat replacement.
    bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
    };

    # environment autoloading.
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableNixDirenvIntegration = true;
    };

    # fuzzy finding.
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [
        "--reverse"
        "--height 40%"
      ];
    };

    # version control.
    git = {
      enable = true;
      delta = {
        enable = true;
      };
      ignores = [
        ".direnv"
        ".envrc"
        "shell.nix"
      ];
      signing = {
        signByDefault = true;
        key = settings.user.gpg.signingKey;
      };
      userName = settings.user.name;
      userEmail = settings.user.email;
    };

    # process viewing.
    htop = {
      enable = true;
      fields = [
         "PID" "USER" "M_SIZE" "M_RESIDENT" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM"
      ];
      showProgramPath = false;
    };

    # file managing.
    lf = {
      enable = true;
    };

    # retrieve email.
    mbsync = {
      enable = true;
    };

    # send email.
    msmtp = {
      enable = true;
    };

    # index email.
    notmuch = {
      enable = true;

      extraConfig = {
        query.split = "to:shanon@splitpayments.com.au AND NOT tag:killed";
      };

      search = {
        excludeTags = [
          "killed"
          "spam"
        ];
      };
    };

    # bash prompt.
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # bash replacement.
    zsh = {
      enable = true;

      prezto = {
        enable = true;

        pmodules = [
          "archive"
          "directory"
          "completion"
          "editor"
          "environment"
          "history"
        ];
      };

      sessionVariables = {
        AWS_VAULT_BACKEND = "pass";
        BROWSER = "firefox";
        EDITOR = "vim";
      };

      shellAliases = {
        b    = "${pkgs.bat}/bin/bat";
        be   = "bundle exec";
        ber  = "bundle exec rspec";
        berc = "bundle exec rails console";
        bers = "bundle exec rails server";
        bi   = "bundle install";
        g    = "${pkgs.git}/bin/git";
        ga   = "${pkgs.git}/bin/git add";
        gars = "${pkgs.git}/bin/git add . && git reset --hard";
        gc   = "${pkgs.git}/bin/git commit";
        gca  = "${pkgs.git}/bin/git commit --amend";
        gcm  = "${pkgs.git}/bin/git commit -m";
        gco  = "${pkgs.git}/bin/git checkout";
        gcp  = "${pkgs.git}/bin/git cherry-pick";
        gd   = "${pkgs.git}/bin/git diff";
        gdc  = "${pkgs.git}/bin/git diff --cached";
        glg  = "${pkgs.git}/bin/git log --stat";
        glr  = "${pkgs.git}/bin/git pull --rebase";
        grh  = "${pkgs.git}/bin/git reset HEAD";
        grm  = "${pkgs.git}/bin/git rm";
        gs   = "${pkgs.git}/bin/git status";
        l    = "${pkgs.exa}/bin/exa -la";
        lt   = "${pkgs.exa}/bin/exa -l --tree";
        md   = "mkdir -p";
        o    = "xdg-open";
        v    = "vim";
      };
    };
  };

  services = {
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
