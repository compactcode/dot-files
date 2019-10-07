{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  xdg.configFile."ranger/rc.conf".text = ''
    set show_hidden true

    set draw_borders both

    set use_preview_script true
    set preview_images true
    set preview_images_method w3m
    set w3m_offset 10
  '';

  # How to preview various mime types.
  xdg.configFile."ranger/scope.sh" = {
    executable = true;
      text = ''
      #!/bin/sh

      set -o noclobber -o noglob -o nounset -o pipefail

      FILE_PATH="$1"
      IMAGE_CACHE_PATH="$4"

      MIMETYPE="$( ${pkgs.file}/bin/file --dereference --brief --mime-type -- $FILE_PATH )"

      case "$MIMETYPE" in
          text/*)
              head -n 100 "$FILE_PATH"
              exit 2;;

          image/*)
              exit 7;;

          application/pdf)
              ${pkgs.poppler_utils}/bin/pdftoppm \
                      -scale-to-x 1920 \
                      -scale-to-y -1 \
                      -singlefile \
                      -jpeg -tiffcompression jpeg \
                      -- "$FILE_PATH" "${ "$\{IMAGE_CACHE_PATH%.*}" }" \
                 && exit 6 || exit 1;;

      esac

      exit 1
    '';
  };
}
