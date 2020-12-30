{ pkgs, ... }:

let
  settings = import ../../../settings.nix;
  theme = import ../../themes/base_16_current.nix;

in {
  home.packages = with pkgs; [
    alacritty
  ];

  xdg.configFile."alacritty/alacritty.yml".text = ''
    env:
      TERM: xterm-256color

    window:
      dynamic_title: true
      padding:
        x: 10
        y: 10

    key_bindings:
      - { key: Paste,    action: Paste }
      - { key: Copy,     action: Copy  }
      - { key: C,        action: Copy,             mods: Super }
      - { key: V,        action: Paste,            mods: Super }
      - { key: Equals,   action: IncreaseFontSize, mods: Super }
      - { key: Subtract, action: DecreaseFontSize, mods: Super }

    font:
      bold:
        family: '${settings.font.monoFamily}'
      bold_italitc:
        family: '${settings.font.monoFamily}'
      italic:
        family: '${settings.font.monoFamily}'
      normal:
        family: '${settings.font.monoFamily}'

      size: ${settings.font.defaultSize.points}

    scrolling:
      history: 5000
      multiplier: 3

    colors:
      primary:
        background: '0x${theme.base00}'
        foreground: '0x${theme.base04}'

      cursor:
        text:   '0x${theme.base00}'
        cursor: '0x${theme.base04}'

      normal:
        black:   '0x${theme.base01}'
        red:     '0x${theme.base0B}'
        green:   '0x${theme.base0E}'
        yellow:  '0x${theme.base0D}'
        blue:    '0x${theme.base09}'
        magenta: '0x${theme.base0F}'
        cyan:    '0x${theme.base08}'
        white:   '0x${theme.base05}'

      bright:
        black:   '0x${theme.base03}'
        red:     '0x${theme.base0B}'
        green:   '0x${theme.base0E}'
        yellow:  '0x${theme.base0D}'
        blue:    '0x${theme.base09}'
        magenta: '0x${theme.base0F}'
        cyan:    '0x${theme.base07}'
        white:   '0x${theme.base06}'
  '';
}
