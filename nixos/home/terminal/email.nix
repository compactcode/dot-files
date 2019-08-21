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
    };
  };

  programs.mbsync = {
    enable = true;
  };

  xdg.configFile."neomutt/neomuttrc".text = ''
    set header_cache = "${config.xdg.cacheHome}/neomutt"
    set mbox_type=Maildir
    set folder="${config.xdg.dataHome}/mail/personal"

    set from="${settings.user.email}"
    set realname="${settings.user.name}"

    set spoolfile="+Inbox"
    set record="+Sent"
    set trash="+Trash"
    set postponed="+Drafts"
  '';
}
