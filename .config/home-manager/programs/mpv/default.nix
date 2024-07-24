{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.mpv = {
    enable = true;
    catppuccin.enable = true;
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      # hwdec = "auto-copy";
      hwdec-codecs = "all";
    };
  };
}
