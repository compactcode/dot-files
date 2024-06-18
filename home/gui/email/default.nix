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

        himalaya.enable = true;
        mbsync.enable = true;
      };
    };
  };

  programs.himalaya.enable = true;
}
