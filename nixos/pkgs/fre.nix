{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage {
  name = "fre";

  src = fetchFromGitHub {
    owner = "camdencheek";
    repo = "fre";
    rev =  "32c8e729a43a654e355b19f73b1900b9857076bf";
    sha256 = "1xc32q4b400aqsshydnj7cn3jn3fp3v9glb7qkc6nvc4wjn3m1fm";
  };

  cargoSha256 = "0rxhlj6da3krb667dr03ss0m3jricyk7vsl11p3yagj67c5jnd3p";
}
