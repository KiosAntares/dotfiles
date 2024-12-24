{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      name = "CaskaydiaCove Nerd Font";
    };
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 10;
      shell = "fish";
      editor = "vim";
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
    # theme = "Catppuccin-Mocha";
  };
}
