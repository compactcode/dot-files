{config, ...}: {
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
        };

        # sending
        msmtp.enable = true;

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
          patterns = [
            "INBOX"
            "[Gmail]/Sent Mail"
            "[Gmail]/Drafts"
          ];
        };

        # sending
        msmtp.enable = true;

        # indexing
        notmuch.enable = true;
      };
    };
  };

  programs = {
    alot = {
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
          notmuch tag +sent -unread -new -- tag:new from:hi@shan.dog

          notmuch tag +newsletter -- tag:new from:campaign.realestate.com.au
          notmuch tag +newsletter -- tag:new from:foundmyfitness.com
          notmuch tag +newsletter -- tag:new from:rainbowplantlife.com
          notmuch tag +newsletter -- tag:new from:rw@peterc.org
          notmuch tag +newsletter -- tag:new from:tldrnewsletter.com

          notmuch tag +shares -unread -- tag:new from:linkmarketservices.com.au
          notmuch tag +shares -unread -- tag:new from:openmarkets.com.au
          notmuch tag +shares -unread -- tag:new from:mailservice.computershare.com.au

          notmuch tag +bills -unread -- tag:new from:amaysim.com.au
          notmuch tag +bills -unread -- tag:new from:team.aussiebroadband.com.au
          notmuch tag +bills -unread -- tag:new from:do-not-reply@powershop.com.au
          notmuch tag +bills -unread -- tag:new from:admin.edithvalefcc@kingston.vic.gov.au

          notmuch tag +childcare -- tag:new from:educa.com.au
          notmuch tag +childcare -- tag:new from:geteduca.com.au
          notmuch tag +childcare -- tag:new from:admin.edithvalefcc@kingston.vic.gov.au

          notmuch tag +inbox -new -- tag:new
        '';
      };
    };
  };
}
