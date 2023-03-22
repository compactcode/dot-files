{ pkgs, lib, ... }:

{
  home = {
    sessionVariables = {
      # nvim as the default editor
      EDITOR = "nvim";
      # replace ssh with the system gpg agent
      SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
      # nvim as the default editor
      VISUAL = "nvim";
    };
    stateVersion = "22.11";
  };

  gtk = {
    enable = true;
    # match gtk3 apps to the sytem theme
    theme.name = "Adwaita-dark";
  };

  programs = {
    # environment loading
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [ "--reverse" "--height 40%" ];
    };

    # git ui
    lazygit.enable = true;

    # version control
    git = {
      enable = true;
      # use delta for nice diff output
      delta.enable = true;
      ignores = [ ".direnv" "node_modules" ];
      signing = {
        signByDefault = true;
        key = "BF2AD40D0652EF0B";
      };
      userName = "Shanon McQuay";
      userEmail = "hi@shan.dog";
    };

    # text editing
    neovim = {
      enable = true;

      extraPackages = with pkgs; [
        nixfmt # formatting
        nodejs # copilot
      ];

      # disable language integrations
      withRuby = false;
      withNodeJs = false;
      withPython3 = false;
    };

    kitty = {
      enable = true;
      settings = {
        # get title bars to match gnome styling
        linux_display_server = "x11";
      };
      theme = "Nord";
    };

    # gpg based password manager
    password-store = {
      enable = true;

      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };

    # shell prompt
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # smart cd with jumping
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # shell
    zsh = {
      enable = true;

      shellAliases = {
        b = "${pkgs.bat}/bin/bat";
        be = "bundle exec";
        ber = "bundle exec rspec";
        berc = "bundle exec rails console";
        bers = "bundle exec rails server";
        bi = "bundle install";
        bu = "bundle update";
        g = "${pkgs.git}/bin/git";
        ga = "${pkgs.git}/bin/git add";
        gars = "${pkgs.git}/bin/git add . && git reset --hard";
        gc = "${pkgs.git}/bin/git commit";
        gca = "${pkgs.git}/bin/git commit --amend";
        gcm = "${pkgs.git}/bin/git commit -m";
        gco = "${pkgs.git}/bin/git checkout";
        gcp = "${pkgs.git}/bin/git cherry-pick";
        gd = "${pkgs.git}/bin/git diff";
        gdc = "${pkgs.git}/bin/git diff --cached";
        glg = "${pkgs.git}/bin/git log --stat";
        glr = "${pkgs.git}/bin/git pull --rebase";
        grh = "${pkgs.git}/bin/git reset HEAD";
        grm = "${pkgs.git}/bin/git rm";
        gs = "${pkgs.git}/bin/git status";
        j = "z";
        l = "${pkgs.exa}/bin/exa -la --icons --no-permissions --no-user";
        la = "${pkgs.exa}/bin/exa -la";
        lg = "${pkgs.lazygit}/bin/lazygit";
        ll = "${pkgs.exa}/bin/exa -la --icons";
        lt = "${pkgs.exa}/bin/exa -l --tree";
        md = "mkdir -p";
        o = "xdg-open";
        v = "nvim";
      };

      prezto = {
        enable = true;

        pmodules = [
          "completion" # auto completion
          "directory" # auto pushd/popd
          "editor" # emacs key bindings
          "history" # history setup
        ];
      };
    };
  };
}
