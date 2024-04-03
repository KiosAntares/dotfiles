{
  config,
  pkgs,
  lib,
  ...
}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };

    script = ''
      kill --all ".polybar-wrappe"

      if type "xrandr"; then
          for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
              MONITOR=$m polybar -c "/home/kios/.config/polybar/config.ini" --reload main &
          done
      else
          polybar --reload main &
      fi
    '';

    config = {
      "colors" = {
        background = "#131020";
        foreground = "#d9e0ee";
        gradient-0 = "#1e1d2f";
        gradient-1 = "\${colors.background}";
        gradient-3 = "#302d41";
        accent = "#f5c2e7";
        title = "\${colors.accent}";
        urgent-foreground = "#b5e8e0";
        urgent-background = "#e8a2af";
        visible-foreground = "\${colors.foreground}";
        visible-background = "\${colors.gradient-1}";
        focused-foreground = "\${colors.foreground}";
        focused-background = "\${colors.gradient-1}";
        focused-underline = "\${colors.accent}";
        unfocused-foreground = "\${colors.foreground}";
        unfocused-background = "\${colors.gradient-1}";
      };
      "bar/main" = {
        font-0 = "CaskaydiaCove Nerd Font:pixelsize=12;2.25";
        monitor = "\${env:MONITOR:}";
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
        fixed-center = "true";
        width = "100%";
        height = 25;
        background = "\${colors.background}";
        foreground = "\${colors.foreground}";
        radius = 0;
        line-size = 2;
        padding-left = 1;
        padding-right = 1;
        module-margin = 0;
        tray-position = "right";
        modules-left = "i3 title";
        modules-center = "mydate";
        modules-right = "pipewire-simple memory cpu power";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format = "<label>";
        label = "RAM %percentage_used:2%%";
        label-padding = 1;
        format-background = "\${colors.gradient-2}";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format = "<label>";
        label = "CPU %percentage:2%%";
        label-padding = 1;
        format-background = "\${colors.gradient-1}";
      };
      "module/pipewire-simple" = {
        type = "custom/script";
        exec = "/home/kios/.config/nixpkgs/programs/polybar/pipewire-simple.sh";
        interval = 1;
        click-right = "exec pavucontrol &";
        click-left = "/home/kios/.config/nixpkgs/programs/polybar/pipewire-simple.sh --mute &";
        scroll-up = "/home/kios/.config/nixpkgs/programs/polybar/pipewire-simple.sh --up &";
        scroll-down = "/home/kios/.config/nixpkgs/programs/polybar/pipewire-simple.sh --down &";
      };
      "module/i3" = {
        type = "internal/i3";
        strip-wsnumbers = true;
        index-sort = true;
        pin-workspaces = true;
        format = "<label-state> <label-mode>";

        label-focused = "%index%";
        label-focused-foreground = "\${colors.focused-foreground}";
        label-focused-background = "\${colors.focused-background}";
        label-focused-underline = "\${colors.focused-underline}";
        label-focused-padding = 1;
        label-focused-border-size = 2;

        label-unfocused = "%index%";
        label-unfocused-padding = 1;

        label-visible = "%index%";
        label-visible-underline = "\${colors.visible-underline}";
        label-visible-foreground = "\${colors.focused-foreground}";
        label-visible-background = "\${colors.focused-background}";
        label-visible-padding = 1;

        label-urgent = "%index%";
        label-urgent-foreground = "\${colors.urgent-foreground}";
        label-urgent-background = "\${colors.urgent-background}";
        label-urgent-padding = 1;
      };
      "module/mydate" = {
        type = "custom/script";
        exec = "~/Scripts/pytime Europe/Rome";
        interval = 1;
      };
      "module/title" = {
        type = "internal/xwindow";
        format-foreground = "\${colors.title}";
        format-padding = 1;
        label-maxlen = 50;
      };
      "module/power" = {
        type = "custom/menu";
        expand-right = true;

        label-open = "  ";
        label-close = "   ";
        label-separator = "|";
        format-spacing = 1;

        menu-0-0 = "  ";
        menu-0-0-exec = "menu-open-1";
        menu-0-1 = "  ";
        menu-0-1-exec = "menu-open-2";

        menu-1-0 = "   ";
        menu-1-0-exec = "reboot";

        menu-2-0 = "    ";
        menu-2-0-exec = "shutdown now";
      };
    };
  };
}
