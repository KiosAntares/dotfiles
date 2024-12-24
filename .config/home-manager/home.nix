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


  nixpkgs.overlays = [
      (import ./packages)
      inputs.nur.overlays.default
  ];

  fonts.fontconfig = {
    enable = true;
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    #theme = {
    #  package = pkgs.catppuccin-gtk;
    #  name = "Catppuccin-Frappe-Standard-Blue-Dark";
    # };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    zathura.enable = true;
    rofi.enable = true;
    mpv.enable = true;
    kitty.enable = true;
    gtk.enable = true;
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
    ./programs/polybar/default.nix
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
  ];

  # home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    # Development
    alejandra

    # Wayland utilities
    swww
    grimblast
    foot
    gamescope
    wlogout

    # Theming and aesthetic
    catppuccin-gtk
    papirus-icon-theme
    breeze-gtk
    mangohud
    lxappearance
    gotop

    # X utilities
    flameshot
    feh
    nitrogen
    tigervnc

    #Important
    tdesktop
    mpv

    # General software
    jdk
    jellyfin-media-player
    davis
    lyrics-in-terminal
    libreoffice-qt
    vesktop
    inputs.nyaa.packages.x86_64-linux.default
    speedtest-cli

    # CG
    krita
    inkscape

    # Gaming and compatibility
    heroic
    legendary-gl
    bottles
    wine-staging
    (pkgs.prismlauncher.override {
      # withWaylandGLFW=true;
    })
    ferium # cli mod manager
    # osu-lazer

    # Emulation
    # ryujinx
    pcsx2
    # rpcs3
    dolphin-emu
  ];
}
