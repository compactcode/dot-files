{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      # password manager
      "1password"
      # keyboard manager
      "keyboard-maestro"
      # launcher
      "raycast"
    ];
  };
}
