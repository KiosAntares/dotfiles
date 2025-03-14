{
  config,
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-substituters = ["https://ai.cachix.org" "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

  nix.settings.secret-key-files = "/root/cache-priv-key.pem";
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };

  nixpkgs.overlays = [
    (self: super: {
      discord-canary = super.discord-canary.override {withOpenASAR = true;};
      # discord = super.discord.override { withOpenASAR = true; };
    })
    inputs.nur.overlays.default
  ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./cachix.nix
    inputs.aagl-gtk-on-nix.nixosModules.default
  ];

  # services.clamav = {
  #  daemon.enable = false;
  #  updater.enable = true;
  # };

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

  # fileSystems."/mnt/2TB_SG" = {
  #   device = "/dev/disk/by-label/2TB_SG";
  #   fsType = "btrfs";
  #   options = [
  #     "compress=zstd"
  #     "noatime"
  #     "nofail"
  #   ];
  # };
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
    options = ["ssd_spread" "noatime" "discard" "space_cache=v2" "compress=zstd" ];
  };
  

  fileSystems."/mnt/server" = {
    device = "192.168.1.200:/data";
    fsType = "nfs";
  };


  hardware.graphics= {
    enable = true;
    # driSupport = true;
    extraPackages = with pkgs; [
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = false;
  };
  services.xserver.videoDrivers = ["nvidia"];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="26ce", ATTRS{idProduct}=="01a2", ATTR{authorized}="0"
  '';

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11_beta ];
    initrd.kernelModules = ["nvidia"];

  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.configurationLimit = 2;
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

  networking = {
    hostName = "main"; # Define your hostname.
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
    };
    interfaces.enp5s0.wakeOnLan.enable = true;
  };




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

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    cheese
    gnome-terminal
    ghex
    rygel
    epiphany
    geary
    evince
    totem
    gnome-music
    polari
    lightsoff
    aisleriot
    swell-foop
    gnome-maps
    gnome-notes
    gnome-chess
    gnome-boxes
    quadrapassel
    gnome-taquin
    gnome-characters
    tali
    iagno
    hitori
    atomix
  ];
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
  programs.kdeconnect.enable = true;

  # services.xserver.digimend.enable = true;
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

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

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   config = {
  #     common = {
  #       default = ["gtk"];
  #     };
  #   };
  # };
  services.flatpak.enable = true;

  # Enable sound.
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
      # easyeffects
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
  programs.sleepy-launcher.enable = true;

  programs.hyprland = {
     enable = true;
     package = inputs.hyprland.packages.${pkgs.system}.hyprland;
     xwayland.enable = true;
     # enableNvidiaPatches = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.tinos
      nerd-fonts.victor-mono
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
    dotnetCorePackages.sdk_9_0
    dotnetCorePackages.runtime_9_0
    # msbuild
    ffmpeg
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
    zig
    screen
    kdiskmark
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

  services.jellyfin = {
    enable = true;
    group = "video";
    openFirewall = true;
  };


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

  system.stateVersion = "25.05"; # Did you read the comment?
}
