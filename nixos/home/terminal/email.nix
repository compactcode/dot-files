{ config, pkgs, ... }:

let
  settings = import ../../settings.nix;

in {
  home.packages = with pkgs; [
    neomutt
  ];

  accounts.email = {
    maildirBasePath = "${config.xdg.dataHome}/mail";

    accounts.personal = {
      primary  = true;
      realName = settings.user.name;
      address  = settings.user.email;

      imap = {
        host = "imap.fastmail.com";
      };

      smtp = {
        host = "smtp.fastmail.com";
      };

      userName = settings.user.email;
      passwordCommand = "pass ${settings.user.email}/token";

      mbsync = {
        enable = true;

        create = "both";
        expunge = "both";
      };

      msmtp = {
        enable = true;
      };
    };
  };

  # Retrieve email and store locally.
  programs.mbsync = {
    enable = true;
  };

  # Send email.
  programs.msmtp = {
    enable = true;
  };

  xdg.configFile."neomutt/neomuttrc".text = ''
    set header_cache = "${config.xdg.cacheHome}/neomutt"
    set mbox_type = Maildir
    set folder = "${config.xdg.dataHome}/mail/personal"

    set sendmail="${pkgs.msmtp}/bin/msmtp"

    set from = "${settings.user.email}"
    set realname = "${settings.user.name}"

    # Folder config.
    set spoolfile = "+Inbox"
    set record = "+Sent"
    set trash = "+Trash"
    set postponed = "+Drafts"

    # Index config.
    set index_format="%2C %zs %?X?A& ? %D %-15.15F %s (%-4.4c)"
    set date_format="%y/%m/%d %I:%M%p"
    set sort = 'reverse-date'

    # Sidebar config.
    mailboxes +Inbox +Sent +Drafts +Trash +Spam
    set sidebar_visible = yes
    set sidebar_format = '%B%?F? [%F]?%* %?N?%N/? %?S?%S?'
    set sidebar_width = 20
    set mail_check_stats

    # Key bindings.
    bind index,pager \CK sidebar-prev # Ctrl-Shift-K - Previous Mailbox
    bind index,pager \CJ sidebar-next # Ctrl-Shift-J - Next Mailbox
    bind index,pager \CO sidebar-open # Ctrl-Shift-O - Open Highlighted Mailbox

    # Index Theme.
    color index yellow default '.*'
    color index_author red default '.*'
    color index_number blue default
    color index_subject cyan default '.*'
    color index brightyellow black "~N"
    color index_author brightred black "~N"
    color index_subject brightcyan black "~N"

    # Sidebar Theme.
    color sidebar_highlight red default
    color sidebar_divider brightblack black
    color sidebar_flagged red black
    color sidebar_new green black

    # General Theme
    mono bold bold
    mono underline underline
    mono indicator reverse
    mono error bold

    color bold black default
    color error red default
    color indicator brightblack white
    color normal default default
    color status brightyellow black
    color underline black default
  '';
}
