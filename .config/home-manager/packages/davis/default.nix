{
  stdenv,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "davis";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "SimonPersson";
    repo = pname;
    rev = version;
    sha256 = "Xw4X9n0PCuigZhBA6so8pVI26pLRGeGjtR0l7uHw1vA=";
  };

  cargoSha256 = "sha256-gpxcJbl2FrWjsPUi/BBZ/uyoVxmbBlXT7KYbESpI1+I=";
}
