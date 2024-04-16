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

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  nixpkgs.overlays = [
    (import ./packages)
  ];

  fonts.fontconfig = {
    enable = true;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-Frappe-Standard-Blue-Dark";
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

    # Theming and aesthetic
    catppuccin-gtk
    papirus-icon-theme
    breeze-gtk
    mangohud
    neofetch
    lxappearance
    gotop

    # X utilities
    flameshot
    feh
    nitrogen

    #Important
    tdesktop
    mpv

    # General software
    jdk
    jellyfin-media-player
    davis
    libreoffice-qt
    # motrix
    ncmpcpp
    vesktop
    (pkgs.discord.override {
      withOpenASAR = true;
      # withVencord = true;
   })
    inputs.nyaa.packages.x86_64-linux.default

    # CG
    krita
    inkscape
    darktable

    # Gaming and compatibility
    heroic
    legendary-gl
    bottles
    wine-staging
    # lutris
    sunshine
    prismlauncher
    osu-lazer

    # Emulation
    ryujinx
    pcsx2
    # rpcs3
    dolphin-emu
  ];
}
