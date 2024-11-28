{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "firefox"
      "1password"
      "kitty"
    ];
  };
}
