{
  config,
  pkgs,
  lib,
  ...
}: {
    programs.mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [
            mpris
        ];
    config = {
      profile = "gpu-hq";
      # force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      # hwdec = "auto-copy";
      hwdec-codecs = "all";
      audio-display = "no";
    };
  };
}
