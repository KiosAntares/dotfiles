{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonApplication rec {
  pname = "lyrics-in-terminal";
  version = "1.8.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Jugran";
    repo = pname;
    rev = version;
    # sha256 = "61l4W7X66WHm1k/M/JM55dNj+mMh4R9ohKbByk9dIVA=";
    hash = "sha512-1gO2XC42UqAF8bXU5qJQYDPWHao8JGo1HB/Yos4TjNzHWC/A2pO5Mv2MWoNP3E7T+Vq9CCfEmpXOP0ZkibsArA=="; 
  };

  dontUseCmakeConfigure = true;

  propagatedBuildInputs = [
    python3Packages.dbus-python
    python3Packages.mpd2
    python3Packages.requests
  ];

  preBuild = ''
    export HOME=$(mktemp -d)
  '';

  buildInputs = [
    python3Packages.setuptools
    python3Packages.dbus-python
    python3Packages.mpd2
    python3Packages.requests
  ];

  meta = with lib; {
    description = "Shows lyrics of songs from your favourite music player in terminal";
    homepage = "https://github.com/Jugran/lyrics-in-terminal";
    license = licenses.mit;
    mainProgram = "lyrics";
  };
}
