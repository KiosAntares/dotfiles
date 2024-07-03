{
  config,
  pkgs,
  lib,
  ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "CaskaydiaCove Nerd Font";
        markup = "yes";
        shrink = "yes";
        geometry = "400x10-20+40";
        alignment = "center";
        word_wrap = "yes";
        monitor = "1";
        padding = 10;
        horizontal_padding = 20;
        icon_position = "left";
        browser = "/usr/bin/env firefox";
        separator_color = "frame";
      };
      iconTheme = {
        name = "Adwaita";
        size = "16x16";
      };
  };
  };
}
