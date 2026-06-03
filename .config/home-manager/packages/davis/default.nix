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

  cargoHash = "sha256-6VpPnRHcpBGen+cOnkG2CCkZQkUH96wu/0oxJPRYm2Q=";
  
  postFixUp = ''
      wrapProgram $out/bin/davis \ --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.imagemagick ]}
  '';
}
