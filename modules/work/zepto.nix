{...}: {
  networking = {
    extraHosts = ''
      127.0.0.1 api.split.test
      127.0.0.1 go.split.test
    '';
  };
}
