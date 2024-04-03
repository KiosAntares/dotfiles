{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-nvfbc
      obs-vkcapture
      # obs-backgroundremoval
      obs-move-transition
      obs-pipewire-audio-capture
    ];
  };
}
