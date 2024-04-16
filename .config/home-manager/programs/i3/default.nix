{
  config,
  pkgs,
  lib,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      bars = [];
      assigns = {
        "5" = [
            {class = "^discord$";}
            {class = "^vesktop$";}
        ];
        "7" = [
          {class = "^TelegramDesktop$";}
        ];
        "8" = [
          {class = "^steam$";}
        ];
        "9" = [
          {class = "^obs$";}
        ];
      };
      colors = {
        background = "#2B2C2B";
        focused = {
          background = "#556064";
          border = "#ff9bae";
          childBorder = "#ff9bae";
          indicator = "#fdf6e3";
          text = "#80fff9";
        };
        focusedInactive = {
          background = "#2f3d44";
          border = "#ff9bae";
          childBorder = "#ff9bae";
          indicator = "#454948";
          text = "#1abc9c";
        };
        unfocused = {
          background = "#2f3d44";
          border = "#404255";
          childBorder = "#404255";
          indicator = "#454948";
          text = "#1abc9c";
        };
        urgent = {
          background = "#fdf7e3";
          border = "#ff4c7b";
          childBorder = "#ff4c7b";
          indicator = "#268bd2";
          text = "#1abc9c";
        };
        placeholder = {
          background = "#0c0c0c";
          border = "#000000";
          childBorder = "#000000";
          indicator = "#000000";
          text = "#ffffff";
        };
      };

      floating = {
        modifier = "Mod4";
        criteria = [
          {title = "File Transfer*";}
          {class = "PavuControl";}
          {title = "Steam - Update News";}
        ];
      };

      focus = {
        followMouse = false;
        mouseWarping = false;
      };

      fonts = {
        names = ["CaskaydiaCove Nerd Font"];
        size = 0.0;
      };

      gaps = {
        inner = 14;
        outer = -2;
        top = 0;

        smartBorders = "off";
        smartGaps = false;
      };

      modifier = "Mod4";

      keybindings = let
        mod = config.xsession.windowManager.i3.config.modifier;
      in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec kitty";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec rofi -show run";
          "Mod1+Up" = "exec pactl set-sink-volume 1 +2%";
          "Mod1+Down" = "exec pactl set-sink-volume 1 -2%";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+Shift+v" = "split h";
          "${mod}+v" = "split v";
          "${mod}+q" = "split toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+Shift+t" = "layout default";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "show scratchpad";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+e" = "exec  \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'\"";
          "${mod}+F2" = "exec firefox";
          "${mod}+F3" = "exec telegram-desktop";
          "${mod}+F5" = "exec vesktop";
          "${mod}+F8" = "exec steam";
          "${mod}+Shift+s" = "exec flameshot gui";

          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";

          "${mod}+Ctrl+1" = "move container to workspace 1";
          "${mod}+Ctrl+2" = "move container to workspace 2";
          "${mod}+Ctrl+3" = "move container to workspace 3";
          "${mod}+Ctrl+4" = "move container to workspace 4";
          "${mod}+Ctrl+5" = "move container to workspace 5";
          "${mod}+Ctrl+6" = "move container to workspace 6";
          "${mod}+Ctrl+7" = "move container to workspace 7";
          "${mod}+Ctrl+8" = "move container to workspace 8";
          "${mod}+Ctrl+9" = "move container to workspace 9";

          "${mod}+Shift+1" = "move container to workspace 1; workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2; workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3; workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4; workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5; workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6; workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7; workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8; workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9; workspace 9";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
        };

      modes = {
        resize = {
          h = "resize shrink width 5 px or 5 ppt";
          j = "resize grow height 5 px or 5 ppt";
          k = "resize shrink height 5 px or 5 ppt";
          l = "resize grow width 5 px or 5 ppt";

          Left = "resize shrink width 5 px or 5 ppt";
          Down = "resize grow height 5 px or 5 ppt";
          Up = "resize shrink height 5 px or 5 ppt";
          Right = "resize grow width 5 px or 5 ppt";

          Escape = "mode default";
          Return = "mode default";
        };
      };

      startup = [
        {
          command = "nitrogen --restore";
          notification = false;
        }
        {
          command = "sh ~/.screenlayout/default.sh";
          notification = false;
        }
        {
          command = "sh ~/.config/i3/polybar.sh";
          notification = false;
        }
        {command = "flameshot";}
      ];

      terminal = "kitty";

      window = {
        border = 1;
        commands = [
          {
            command = "pixel 1";
            criteria = {};
          }
        ];
      };

      workspaceLayout = "default";
    };

    extraConfig = ''
      workspace_auto_back_and_forth yes
      default_border pixel 1
      default_floating_border pixel 1
    '';
  };
}
