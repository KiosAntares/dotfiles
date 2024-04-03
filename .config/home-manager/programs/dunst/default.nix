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
        browser = "/usr/bin/env chromium";
        separator_color = "frame";
        frame_color = "#89B4FA";
      };
      iconTheme = {
        name = "Adwaita";
        size = "16x16";
      };
      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 5;
      };
      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 5;
      };
      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };
    };
  };
}
