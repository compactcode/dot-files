{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage {
  name = "fre";

  src = fetchFromGitHub {
    owner = "ccheek21";
    repo = "fre";
    rev =  "32c8e729a43a654e355b19f73b1900b9857076bf";
    sha256 = "1xc32q4b400aqsshydnj7cn3jn3fp3v9glb7qkc6nvc4wjn3m1fm";
  };

  cargoSha256 = "1szbnlzpn43c7vshrn48mn09xhn1dmhl7k9jdhngiglmy0g43vjk";
}
