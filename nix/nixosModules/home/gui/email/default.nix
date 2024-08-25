{
  config,
  lib,
  pkgs,
  ...
}: {
  accounts.email = {
    maildirBasePath = "${config.xdg.dataHome}/mail";

    accounts = {
      primary = {
        address = "hi@shan.dog";
        flavor = "fastmail.com";
        primary = true;
        realName = "Shanon McQuay";
        passwordCommand = "op read op://personal/fastmail/token";

        # fetching
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };

        # indexing
        notmuch.enable = true;
      };

      legacy = {
        address = "shanonmcquay@gmail.com";
        flavor = "gmail.com";
        realName = "Shanon McQuay";
        passwordCommand = "op read op://personal/google/token";

        # fetching
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
          patterns = [
            "INBOX"
            "[Gmail]/Sent Mail"
            "[Gmail]/Drafts"
          ];
        };

        # indexing
        notmuch.enable = true;
      };

      zepto = {
        address = "shanon@zepto.com.au";
        flavor = "gmail.com";
        realName = "Shanon McQuay";
        passwordCommand = "op read op://personal/google/token_zepto";

        # fetching
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
          patterns = [
            "INBOX"
            "[Gmail]/Sent Mail"
            "[Gmail]/Drafts"
          ];
        };

        # indexing
        notmuch.enable = true;
      };
    };
  };

  programs = {
    # notmuch tagging
    afew = {
      enable = true;
      extraConfig = ''
        [SpamFilter]

        [SentMailsFilter]
        sent_tag = sent
        [ArchiveSentMailsFilter]

        [KillThreadsFilter]

        [Filter.0]
        query = 'from:linkmarketservices.com.au OR from:openmarkets.com.au OR from:mailservice.computershare.com.au'
        tags = +shares; -unread

        [Filter.1]
        query = 'from:amaysim.com.au OR from:team.aussiebroadband.com.au'
        tags = +bills; -unread

        [InboxFilter]
      '';
    };

    # notmuch client
    alot = {
      enable = true;
    };

    # fetching
    mbsync = {
      enable = true;
    };

    # indexing
    notmuch = {
      enable = true;
      # add staging tag https://notmuchmail.org/initial_tagging/
      new.tags = ["new"];
      hooks = {
        # use afew to process staging tags
        postNew = "${lib.getExe pkgs.afew} --tag --new";
      };
    };
  };
}
