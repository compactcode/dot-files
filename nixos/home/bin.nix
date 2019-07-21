{ pkgs, ... }:

{
  xdg.dataFile."bin/rg-sk-preview.sh" = {
    executable = true;
    source = ./bin/rg-sk-preview.sh;
  };
}
