{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Something to open spreadsheet & word documents.
    libreoffice
    # Text communication.
    slack
    # Voice communication.
    discord
    # Video communication.
    zoom-us
  ];
}
