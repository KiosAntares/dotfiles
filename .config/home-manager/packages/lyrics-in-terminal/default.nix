{
    lib,
    python3Packages,
    fetchFromGitHub
}:
python3Packages.buildPythonApplication rec {
    pname = "lyrics-in-terminal";
    version = "1.5.0";
    pyproject = true;

    src = fetchFromGitHub {
        owner = "Jugran";
        repo = pname;
        rev = version;
        sha256 = "61l4W7X66WHm1k/M/JM55dNj+mMh4R9ohKbByk9dIVA=";
    };

    dontUseCmakeConfigure = true;

    propagatedBuildInputs = [
        python3Packages.dbus-python
        python3Packages.mpd2
    ];

    preBuild = ''
        export HOME=$(mktemp -d)
        '';

    buildInputs = [
        python3Packages.setuptools
        python3Packages.dbus-python
        python3Packages.mpd2
    ];

    meta = with lib; {
        description = "Shows lyrics of songs from your favourite music player in terminal";
        homepage = "https://github.com/Jugran/lyrics-in-terminal";
        license = licenses.mit;
        mainProgram = "lyrics";
    };
}

