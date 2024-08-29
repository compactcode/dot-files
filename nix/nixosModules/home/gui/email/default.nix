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
        # ignore spam
        [SpamFilter]

        # ignore sent
        [SentMailsFilter]
        sent_tag = sent
        [ArchiveSentMailsFilter]

        # delete new messages on deleted threads
        [KillThreadsFilter]

        # tag threads
        [ListMailsFilter]

        # tag and archive share trades
        [Filter.0]
        query = 'from:linkmarketservices.com.au OR from:openmarkets.com.au OR from:mailservice.computershare.com.au'
        tags = +shares; -unread; -new

        # tag and archive bills
        [Filter.1]
        query = 'from:amaysim.com.au OR from:team.aussiebroadband.com.au'
        tags = +bills; -unread; -new

        # tag work
        [Filter.2]
        query = 'to:zepto.com.au OR to:zeptopayments.com OR to:splitpayments.com.au'
        tags = +zepto; -new

        # tag everything new tag inbox
        [InboxFilter]
      '';
    };

    # notmuch client
    alot = {
      enable = true;
      bindings = {
        thread = {
          b = "call hooks.open_in_browser(ui)";
        };
      };
      hooks = builtins.readFile ./alot/hooks.py;
      settings = {
        # default search on open
        initial_command = "search tag:inbox";
        # default to viewing html part
        prefer_plaintext = false;
      };
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
      # always ignore these tags
      search.excludeTags = [
        "killed"
        "spam"
      ];
    };
  };

  home.file.".mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -dump %s; nametemplate=%s.html; copiousoutput
    application/pdf; zathura '%s';
  '';
}
