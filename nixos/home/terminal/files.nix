{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  # General config.
  # https://github.com/ranger/ranger/blob/master/ranger/config/rc.conf
  xdg.configFile."ranger/rc.conf".text = ''
    set show_hidden true

    set draw_borders both

    set use_preview_script true
    set preview_images true
    set preview_images_method w3m
    set w3m_offset 10
  '';

  # How to open various file types.
  # https://github.com/ranger/ranger/blob/master/ranger/config/rifle.conf
  xdg.configFile."ranger/rifle.conf".text = ''
    ext pdf, X, flag f = ${lib.getBin pkgs.zathura}/bin/zathura -- "$@"

    mime ^image, X, flag f = ${lib.getBin pkgs.pinta}/bin/pinta -- "$@"

    mime ^text = ${lib.getBin pkgs.neovim}/bin/nvim -- "$@"
  '';

  # How to preview various mime types.
  # https://github.com/ranger/ranger/blob/master/ranger/data/scope.sh
  xdg.configFile."ranger/scope.sh" = {
    executable = true;
      text = ''
      #!/bin/sh

      set -o noclobber -o noglob -o nounset -o pipefail

      FILE_PATH="$1"
      IMAGE_CACHE_PATH="$4"

      MIMETYPE="$( ${lib.getBin pkgs.file}/bin/file --dereference --brief --mime-type -- $FILE_PATH )"

      case "$MIMETYPE" in
          text/*)
              head -n 100 "$FILE_PATH"
              exit 2;;

          image/*)
              exit 7;;

          application/pdf)
              ${lib.getBin pkgs.poppler_utils}/bin/pdftoppm \
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
