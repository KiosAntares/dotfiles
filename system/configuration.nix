{
  config,
  pkgs,
  inputs,
  home-manager,
  ...
}: let
  aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
in {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-substituters = ["https://ai.cachix.org" "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      ffmpeg_5-full = super.ffmpeg_5-full.overrideAttrs (old: {
        postFixup = ''
          addOpenGLRunpath ${placeholder "lib"}/lib/libavcodec.so
          addOpenGLRunpath ${placeholder "lib"}/lib/libavutil.so
        '';
      });
    })

    (self: super: {
      discord-canary = super.discord-canary.override {withOpenASAR = true;};
      # discord = super.discord.override { withOpenASAR = true; };
    })
  ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
    ./cachix.nix
    aagl-gtk-on-nix.module
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = [
      "noatime"
      "ssd"
      "discard"
      "space_cache=v2"
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  fileSystems."/mnt/2TB_SG" = {
    device = "/dev/disk/by-label/2TB_SG";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
      "nofail"
    ];
  };
  fileSystems."/mnt/External" = {
    device = "/dev/disk/by-uuid/6CF62BCCF62B94FC";
    fsType = "ntfs-3g";
    options = [
      "noatime"
      "big_writes"
    ];
  };

  fileSystems."/mnt/1TB_SG" = {
    device = "/dev/disk/by-label/1TB_SG";
    fsType = "ntfs-3g";
    options = [
      "noatime"
      "big_writes"
    ];
  };

  fileSystems."/mnt/sssd" = {
    device = "/dev/disk/by-label/sssd";
    fsType = "btrfs";
    options = ["ssd_spread" "noatime" "discard"];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
    ];
  };
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="26ce", ATTRS{idProduct}=="01a2", ATTR{authorized}="0"
  '';

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.theme = "/opt/catppuccin-mocha-grub-theme/theme.txt";
  boot.loader.grub.extraEntries = ''
    menuentry "Windows 11" --class windows --class os $menuentry_id_option 'osprober-efi-BC5D-6FA0' {
    insmod part_gpt
    insmod fat
    search --set=root --fs-uuid 4C9C-C85E
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';

  networking.hostName = "main"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.interfaces.enp5s0.wakeOnLan.enable = true;
  zramSwap = {
    enable = true;
  };

  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IE.UTF-8";


  systemd.services = {
    systemd-udev-settle.enable = false;
    NetworkManager-wait-online.enable = false;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.screenSection = ''
    Option "Coolbits" "28"
  '';

  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      polybarFull
      rofi
      kitty
      xclip
    ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    ghex
    rygel
    polari
    vinagre
    lightsoff
    aisleriot
    swell-foop
    gnome-maps
    gnome-notes
    gnome-chess
    gnome-boxes
    quadrapassel
    gnome-taquin
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
  # services.xserver.xkb.options = "caps:swapescape,altwin:swap_alt_win";

  programs.nano.enable = false;

  # TODO: re enable
  services.xserver.digimend.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = ["gtk"];
      };
    };
  };
  services.flatpak.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  security.rtkit.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.systembus-notify.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.fish.enable = true;
  programs.fish.promptInit = "${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source";
  users.defaultUserShell = pkgs.fish;
  users.users.kios = {
    isNormalUser = true;
    extraGroups = ["wheel" "scanner" "lp" "video"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      appimage-run
      deluge
      easyeffects
      rime-data
      librime
      mono
      pavucontrol
      lutris
      yadm
    ];
  };

  programs.honkers-railway-launcher.enable = true;
  programs.anime-game-launcher.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    # enableNvidiaPatches = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["CascadiaCode" "Tinos" "VictorMono"];})
      corefonts
      # babelstone-han
      source-han-sans
    ];

    fontDir.enable = true;
  };

  programs.steam = {
    enable = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = ["wheel"];
        keepEnv = true;
        persist = true;
      }
      {
        users = ["root"];
        keepEnv = true;
        noPass = true;
      }
    ];
  };

  users.users.jellyfin.extraGroups = ["video"];

  qt.platformTheme = "gtk3";

  environment.variables = {
    # WLR_NO_HARDWARE_CURSOR = "1";
    # NIXOS_OZONE_WL = "1";
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
    GLFW_IM_MODULE = "ibus";
  };

  environment.sessionVariables = rec {
    WLR_NO_HARWARE_CURSOR = "1";
  };

    services.dbus.enable = true;
  # List packages installed in system profile. To search, run:
  environment.defaultPackages = with pkgs; [
    dotnet-sdk
    msbuild
    ffmpeg_5-full
    p7zip
    xorg.xkill
    vkBasalt
    wine
  ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    grub2
    lsd
    bat
    htop
    killall
    blueman
    ghc
    iperf
    clang
    clang-tools
    man-pages
    man-pages-posix
    pamixer
    (python3.withPackages (py: [py.requests py.pytz py.ffmpeg-python]))
    git
    unzip
    unrar
    usbutils
    calc
    zip
    mediainfo
    lsof
    rsync
    rustc
    cargo
    fzf
    ripgrep
    fd
    progress
    xdotool
    qt6.qtwayland
    # xdg-desktop-portal-hyprland
    zig
  ];

  documentation.dev.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  environment.variables.EDITOR = "nvim";

  programs.fish.shellAliases = {
    ls = "lsd";
    up = "cd ..";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.jellyfin.enable = true;

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  services.mpd = {
    enable = true;
    user = "kios";
    dbFile = "/home/kios/.config/mpd/mpd.db";
    dataDir = "/home/kios/.config/mpd";
    playlistDirectory = "/home/kios/.config/mpd/playlists";
    musicDirectory = "/mnt/2TB_SG/Media/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
      name "Pipewire"
      }
    '';
  };

  # services.x2goserver.enable = true;
  networking.firewall.enable = false;

  location = {
    provider = "manual";
    longitude = 12.0;
    latitude = 45.0;
  };

  services.redshift = {
    enable = true;
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
