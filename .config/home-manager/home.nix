{
  config,
  pkgs,
  inputs,
  ...
}: let
in {
  home.username = "kios";
  home.homeDirectory = "/home/kios";
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enableWideVine = true;
    };
  };

  # nix.package = pkgs.nix;
  nix.settings = {
    # substituters = ["https://hyprland.cachix.org"];
    # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };


  nixpkgs.overlays = [
      (import ./packages)
      inputs.nur.overlays.default
  ];

  fonts.fontconfig = {
    enable = true;
  };

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  gtk = {
     enable = true;
     theme = {
         name = "Catppuccin-GTK-Pink-Dark-Compact";
         # package = pkgs.magnetic-catppuccin-gtk;
         package = pkgs.magnetic-catppuccin-gtk.override {
             accent = ["pink"];
             size = "compact";
             shade = "dark";
             # tweaks = [ "rimless" ];
             # variant = "mocha";
         };
     };
     gtk3 = {
         extraConfig.gtk-application-prefer-dark-theme = ''1'';
     };
     gtk4 = {
         theme = config.gtk.theme;
         extraConfig.gtk-application-prefer-dark-theme = ''1'';
     };

 };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    zathura.enable = true;
    rofi.enable = true;
    # mpv.enable = true;
    kitty.enable = true;
    # gtk.enable = true;
    bat.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  imports = [
    ./programs/nvim/default.nix
    ./programs/kitty/default.nix
    ./programs/dunst/default.nix
    ./programs/i3/default.nix
    # ./programs/polybar/default.nix
    ./programs/vscode/default.nix
    ./programs/obs/default.nix
    ./programs/mpv/default.nix
    ./programs/chromium/default.nix
    ./programs/zathura/default.nix
    ./programs/firefox/default.nix
    ./programs/waybar/default.nix
    ./programs/hyprland/default.nix
    ./programs/broot/default.nix
    ./programs/bat/default.nix
    ./programs/rofi/default.nix
    ./programs/fastfetch/default.nix
    ./programs/foot/default.nix
  ];

  # home.sessionVariables.NIXOS_OZONE_WL = "1";

  services.easyeffects = {
     enable = true;
  };

  home.packages = with pkgs; [
    # mine
    reminder

    # Testing
    inputs.zen-browser.packages.${pkgs.system}.default

    # Social
    vesktop
    telegram-desktop

    # Dev/Tools
    alejandra
    arduino-ide
    speedtest-cli
    gotop
    dawn

    # Theming and aesthetic
    catppuccin-gtk
    # papirus-icon-theme
    kdePackages.breeze-gtk
    lxappearance

    # X utilities
    flameshot
    feh
    nitrogen
    # tigervnc

    # Wayland utilities
    awww
    grimblast
    gamescope
    wlogout

    # Library
    jdk

    # Media 
    # jellyfin-media-player
    tsukimi
    jellyfin-mpv-shim
    playerctl
    davis
    lyrics-in-terminal
    # podliner

    # Office
    # libreoffice-qt
    onlyoffice-desktopeditors
    # inputs.nyaa.packages.x86_64-linux.default
    # quodlibet

    # 3D Modeling and printing
    freecad
    super-slicer

    # 2D Drawing
    krita
    inkscape
    darktable

    # Gaming and compatibility
    mangohud
    umu-launcher
    wine-staging
    (pkgs.prismlauncher.override {
      # withWaylandGLFW=true;
    })
    legendary-gl
    rare
    # ferium # cli mod manager
    # osu-lazer

    # Emulation
    # pcsx2
    # rpcs3
    # dolphin-emu
    # shadps4
    eden


    # Other Utilities
    # gpsprune
    qgis

    # Work
    remmina
  ];
}
