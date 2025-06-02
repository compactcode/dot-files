{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "1password" # password manager
      "raycast" # launcher
      "rubymine" # code editor
    ];
  };
}
