{
  # file manager
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # open options per mime type
      open.rules = [
        {
          mime = "application/pdf";
          use = ["xdg"];
        }
        {
          mime = "application/zip";
          use = ["ouch"];
        }
        {
          mime = "image/*";
          use = ["xdg"];
        }
        {
          mime = "text/html";
          use = ["xdg" "edit"];
        }
        {
          mime = "video/*";
          use = ["xdg"];
        }
        {
          mime = "*";
          use = ["edit"];
        }
      ];

      opener = {
        # use xdg configuration
        xdg = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open";
          }
        ];
        # use ouch to extract archive
        ouch = [
          {
            run = ''ouch decompress "$@"'';
            desc = "Extract";
          }
        ];
      };
    };
  };

  # automatic styling
  stylix = {
    targets = {
      yazi.enable = true;
    };
  };
}
