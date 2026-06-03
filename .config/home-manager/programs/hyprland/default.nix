{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # configType = "hyprlang";

    plugins = [];
    settings = {
      "mod" = "MOD4";

      monitor = [
        "DP-2,2560x1440@75,1920x0,1"
        # "HDMI-A-1,1920x1080@60,0x360,1"
        "HDMI-A-1,1920x1080@60,0x0,1"
      ];

      debug = {
        disable_logs = false;
      };

      exec = [
        # "flameshot"
        "waybar &"
        "awww-daemon"
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

      cursor = {
          # no_hardware_cursor = true;
          # allow_dumb_copy = true;
      };

      general = {
        # sensitivity = 1.00;
        # no_cursor_warps = "0";

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

      # animations = {
      #   enabled = 1;
      #   animation = [
      #     "windows,1,5,overshot,slide"
      #     "workspaces,1,6,overshot"
      #   ];
      # };

      # dwindle = {
      #   pseudotile = 0;
      # };

      bind = [
        "MOD4,Return,exec,kitty" 
        "MOD4 SHIFT,Q,killactive,"
        "MOD4,D,exec,rofi -show run"
        "MOD4,F,fullscreen,"
        "MOD4 SHIFT,Space,togglefloating" 
        "MOD4,F2,exec,zen"
        "MOD4,F3,exec,Telegram"
        "MOD4,F5,exec,vesktop"
        "MOD4,F8,exec,steam"
        "MOD4,X,exec,wlogout"
        "MOD4 SHIFT,S,exec,grimblast copy area"
        ",XF86MonBrightnessUp,exec,brightnessctl s +5"
        ",XF86MonBrightnessDown,exec,brightnessctl s 5-"

        "MOD4,1,workspace,1"
        "MOD4,2,workspace,2"
        "MOD4,3,workspace,3"
        "MOD4,4,workspace,4"
        "MOD4,5,workspace,5"
        "MOD4,6,workspace,6"
        "MOD4,7,workspace,7"
        "MOD4,8,workspace,8"
        "MOD4,9,workspace,9"
        "MOD4,0,workspace,10"

        "MOD4 SHIFT,1,movetoworkspacesilent,1"
        "MOD4 SHIFT,2,movetoworkspacesilent,2"
        "MOD4 SHIFT,3,movetoworkspacesilent,3"
        "MOD4 SHIFT,4,movetoworkspacesilent,4"
        "MOD4 SHIFT,5,movetoworkspacesilent,5"
        "MOD4 SHIFT,6,movetoworkspacesilent,6"
        "MOD4 SHIFT,7,movetoworkspacesilent,7"
        "MOD4 SHIFT,8,movetoworkspacesilent,8"
        "MOD4 SHIFT,9,movetoworkspacesilent,9"
        "MOD4 SHIFT,0,movetoworkspacesilent,10"

        "MOD4,h,movefocus,l"
        "MOD4,l,movefocus,r"
        "MOD4,k,movefocus,u"
        "MOD4,j,movefocus,d"
        "MOD4 SHIFT,h,movewindow,l"
        "MOD4 SHIFT,l,movewindow,r"
        "MOD4 SHIFT,k,movewindow,u"
        "MOD4 SHIFT,j,movewindow,d"
        "MOD4 CONTROL,h,workspace,-1"
        "MOD4 CONTROL,l,workspace,+1"
        "MOD4 CONTROL,k,focusmonitor,l"
        "MOD4 CONTROL,j,focusmonitor,r"
        # "MOD4 ALT,h,splitratio,-0.1"
        # "MOD4 ALT,l,splitratio,+0.1"
      ];

      bindm = [
        "MOD4,mouse:272,movewindow"
        "MOD4,mouse:273,resizewindow"
      ];

      env = [
        # "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        # "GBM_BACKEND,nvidia-drm"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # "WLR_NO_HARDWARE_CURSORS,1"
        "NIXOS_OZONE_WL,1"
        "QT_QPA_PLATFORM,xcb"
      ];

      windowrule = [
        # "float,Rofi"
      ];

      # bezier = [
      #   "slow,0,0.85,0.3,1"
      #   "overshot,0.7,0.6,0.1,1.1"
      # ];
    };
    systemd.enable = true;
    xwayland.enable = true;
  };
}
