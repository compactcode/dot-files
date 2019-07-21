{ pkgs, ... }:

{
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

    # Nord Theme
    colors:
      primary:
        background: '0x2E3440'
        foreground: '0xD8DEE9'
      cursor:
        text: '0x2E3440'
        cursor: '0xD8DEE9'
      normal:
        black: '0x3B4252'
        red: '0xBF616A'
        green: '0xA3BE8C'
        yellow: '0xEBCB8B'
        blue: '0x81A1C1'
        magenta: '0xB48EAD'
        cyan: '0x88C0D0'
        white: '0xE5E9F0'
      bright:
        black: '0x4C566A'
        red: '0xBF616A'
        green: '0xA3BE8C'
        yellow: '0xEBCB8B'
        blue: '0x81A1C1'
        magenta: '0xB48EAD'
        cyan: '0x8FBCBB'
        white: '0xECEFF4'
  '';
}
