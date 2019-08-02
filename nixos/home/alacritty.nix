{ pkgs, ... }:

let theme = import ./themes/base_16_nord.nix;

in {
  home.packages = with pkgs; [
    alacritty
  ];

  xdg.configFile."alacritty/alacritty.yml".text = ''
    env:
      TERM: xterm-256color

    window:
      padding:
        x: 10
        y: 10

    key_bindings:
      - { key: Paste, action: Paste }
      - { key: Copy,  action: Copy  }

      # OSX Hangups.
      - { key: C,     action: Copy,             mods: Super }
      - { key: V,     action: Paste,            mods: Super }
      - { key: K,     action: ClearHistory,     mods: Super }
      - { key: Add,   action: IncreaseFontSize, mods: Super }
      - { key: Minus, action: DecreaseFontSize, mods: Super }

    scrolling:
      history: 5000
      multiplier: 3
      faux_multiplier: 3
      auto_scroll: false

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
