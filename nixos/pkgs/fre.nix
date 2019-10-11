{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage {
  name = "fre";

  src = fetchFromGitHub {
    owner = "ccheek21";
    repo = "fre";
    rev =  "32c8e729a43a654e355b19f73b1900b9857076bf";
    sha256 = "1xc32q4b400aqsshydnj7cn3jn3fp3v9glb7qkc6nvc4wjn3m1fm";
  };

  cargoSha256 = "0n0ss3ak92gy9ld51kr80wzskkmg25agfi44jjdgcnfsfdn1kkxw";
}
