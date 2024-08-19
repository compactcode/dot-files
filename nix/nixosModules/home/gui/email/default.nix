{config, ...}: {
  accounts.email = {
    maildirBasePath = "${config.xdg.dataHome}/.mail";

    accounts = {
      primary = {
        address = "hi@shan.dog";
        flavor = "fastmail.com";
        primary = true;
        realName = "Shanon McQuay";
        passwordCommand = "op read op://personal/fastmail/token";

        astroid = {
          enable = true;
        };

        # fetching
        mbsync = {
          enable = true;
          create = "maildir";
        };

        # sending
        msmtp.enable = true;

        # indexing
        notmuch.enable = true;
      };
    };
  };

  programs = {
    astroid = {
      enable = true;
    };

    msmtp = {
      enable = true;
    };

    mbsync = {
      enable = true;
    };

    notmuch = {
      enable = true;
      # add staging tag https://notmuchmail.org/initial_tagging/
      new.tags = ["new"];
      hooks = {
        # process new staging tags
        postNew = ''
          notmuch tag +inbox +unread -new -- tag:new
        '';
      };
    };
  };
}
