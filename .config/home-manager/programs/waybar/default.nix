{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 16;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["backlight" "custom/volumelabel" "pulseaudio/slider" "memory" "cpu" "tray"]; 

        "network" = {
          format-wifi = "{icon} {essid}";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
          format-icons = {
            wifi = ["󰤟" "󰤢" "󰤥" "󰤨"];
          };
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        "backlight" = {
          format = "{icon}";
          format-icons = [" " "󰃟 " "󰃠 "];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{icon}  {capacity}%";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{icon} {time}";
          format-icons = [" " " " " " " " " "];
        };

        "clock" = {
          format = "{:%A, %e %B %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "custom/volumelabel" = {
          format = "󰕾 ";
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 110;
          orientation = "horizontal";
        };

        "cpu" = {
            format = "CPU {usage:2}%";
            interval = 2;
        };
        
        "memory" = {
            format = "RAM {percentage:2}%";
            interval = 2;
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
