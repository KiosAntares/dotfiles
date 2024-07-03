{
  config,
  pkgs,
  lib,
  ...
}: {

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [];
    settings = {
      "$mod" = "MOD4";

      monitor = [
        "DP4,2560x1440@75,1920x0,1"
        "HDMI-0,1920x1080@60,0x360,1"
      ];

      exec = [
        "flameshot"
        "waybar"
        "swww init"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        repeat_rate = "50";
        repeat_delay = "300";

        follow_mouse = "1";
        touchpad = {
          disable_while_typing = "0";
        };
    };

    cursors = {
        no_hardware_cursor = true;
    };

      general = {
        sensitivity = 1.00;
        no_cursor_warps = "0";

        gaps_in = 8;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "0xFFFFFFFF";
        "col.inactive_border" = "0x070707AE";
      };

      decoration = {
        rounding = 2;
        # blur = 1;
        # blur_size = 5;
        # blur_passes = 2;
      };

      animations = {
        enabled = 1;
        animation = [
          "windows,1,5,overshot,slide"
          "workspaces,1,6,overshot"
        ];
      };

      dwindle = {
        pseudotile = 0;
      };

      bind = [
        "$mod,Return,exec,kitty"
        "$mod SHIFT,Q,killactive,"
        "$mod,D,exec,rofi -show run"
        "$mod,F,fullscreen,"
        "$mod,F2,exec,firefox"
        "$mod,F3,exec,telegram-desktop"
        "$mod,F5,exec,discord"
        "$mod,F8,exec,steam"
        "$mod SHIFT,S,exec,grimblast copy area"
        ",XF86MonBrightnessUp,exec,brightnessctl s +5"
        ",XF86MonBrightnessDown,exec,brightnessctl s 5-"

        "$mod,1,workspace,1"
        "$mod,2,workspace,2"
        "$mod,3,workspace,3"
        "$mod,4,workspace,4"
        "$mod,5,workspace,5"
        "$mod,6,workspace,6"
        "$mod,7,workspace,7"
        "$mod,8,workspace,8"
        "$mod,9,workspace,9"
        "$mod,0,workspace,10"

        "$mod SHIFT,1,movetoworkspacesilent,1"
        "$mod SHIFT,2,movetoworkspacesilent,2"
        "$mod SHIFT,3,movetoworkspacesilent,3"
        "$mod SHIFT,4,movetoworkspacesilent,4"
        "$mod SHIFT,5,movetoworkspacesilent,5"
        "$mod SHIFT,6,movetoworkspacesilent,6"
        "$mod SHIFT,7,movetoworkspacesilent,7"
        "$mod SHIFT,8,movetoworkspacesilent,8"
        "$mod SHIFT,9,movetoworkspacesilent,9"
        "$mod SHIFT,0,movetoworkspacesilent,10"

        "$mod,h,movefocus,l"
        "$mod,l,movefocus,r"
        "$mod,k,movefocus,u"
        "$mod,j,movefocus,d"
        "$mod SHIFT,h,movewindow,l"
        "$mod SHIFT,l,movewindow,r"
        "$mod SHIFT,k,movewindow,u"
        "$mod SHIFT,j,movewindow,d"
        "$mod CONTROL,h,workspace,-1"
        "$mod CONTROL,l,workspace,+1"
        "$mod CONTROL,k,focusmonitor,l"
        "$mod CONTROL,j,focusmonitor,r"
        "$mod ALT,h,splitratio,-0.1"
        "$mod ALT,l,splitratio,+0.1"
      ];

      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # "WLR_NO_HARDWARE_CURSORS,1"
        "NIXOS_OZONE_WL,1"
        ];

      windowrule = [
        "float,Rofi"
      ];

      bezier = [
        "slow,0,0.85,0.3,1"
        "overshot,0.7,0.6,0.1,1.1"
      ];
    };
    systemd.enable = true;
    xwayland.enable = true;
  };
}
