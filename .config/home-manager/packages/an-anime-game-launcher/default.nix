{
  pkgs ? import <nixpkgs> {},
  rustPlatform ? pkgs.rustPlatform,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "an-anime-game-launcher";
  version = "1.2.4";

  src = fetchFromGitHub {
    owner = "an-anime-team";
    repo = "an-anime-game-launcher-gtk";
    rev = version;
    hash = "sha256-3ZFGZvimcnVD+/YJD3s76thLMpjyy2FbzMI2wbDAdDc=";
    fetchSubmodules = true;
  };

  doCheck = false;
  nativeBuildInputs = with pkgs; [
    openssl
    pkg-config
  ];
  buildInputs = with pkgs; [
    openssl
    cargo-c
    pkg-config
  ];

  extraPackages = with pkgs; [
  ];

  cargoSha256 = "sha256-L6L1oyjkZtSDPlvIcZZBX0an74ZxxMwqhrmPxdFM4/w=";
}
