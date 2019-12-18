{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Something to open spreadsheet & word documents.
    libreoffice
    # Office communication.
    slack
  ];
}
