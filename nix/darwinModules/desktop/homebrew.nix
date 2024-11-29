{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "1password"
      "raycast"
    ];
  };
}
