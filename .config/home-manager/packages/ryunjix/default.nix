{
  pkgs ? import <nixpkgs> {},
  stdenv,
  fetchFromGitHub,
  buildDotnetPackage,
  dotnetPackages,
  pkg-config,
}:
buildDotnetPackage rec {
  pname = "ryunjix";
  version = "0.1.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "e3Ndas8n/VLEyOWgtEp7OkRvWiuZnpr9NDdXbe5Tu2o=";
  };

  cargoSha256 = "c7O+wAGBO/dM5Zpmp9yd1gwVaCA8qqMtvLKWMdh6stQ=";
}
