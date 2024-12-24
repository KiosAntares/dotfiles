{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    cycle = false;
    font = "CaskaydiaCove Nerd Font";
    terminal = "kitty";
    extraConfig = {
      show-icons = true;
    };
  };
}
