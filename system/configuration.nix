{
  config,
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # nix.settings.trusted-substituters = ["https://ai.cachix.org" "https://hyprland.cachix.org" ];
  #nix.settings.trusted-public-keys = [
  #  "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
  #  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  # ];

  nix.settings.secret-key-files = "/root/cache-priv-key.pem";
  nix.settings.auto-optimise-store = true;
  nix.settings.download-buffer-size = 524288000;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };

  # hardware.fancontrol.enable = true;
  hardware.fancontrol.config = ''
    INTERVAL=10
FCTEMPS=hwmon0/device/pwm1=hwmon0/device/temp1_input
FCFANS=hwmon0/device/pwm1=hwmon0/device/fan1_input
MINTEMP=40
MAXTEMP=60
  '';

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      discord-canary = super.discord-canary.override {withOpenASAR = true;};
      # discord = super.discord.override { withOpenASAR = true; };
    })
    inputs.nur.overlays.default
    # inputs.comfyui-nix.overlays.default
  ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./cachix.nix
    inputs.aagl-gtk-on-nix.nixosModules.default
    # inputs.comfyui-nix.nixosModules.default
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

  # fileSystems."/mnt/External" = {
  #   device = "/dev/disk/by-uuid/6CF62BCCF62B94FC";
  #   fsType = "ntfs-3g";
  #   options = [
  #     "noatime"
  #     "big_writes"
  #   ];
  # };

  fileSystems."/mnt/1TB_SG" = {
    device = "/dev/disk/by-label/1TB_SG";
    fsType = "ntfs-3g";
    options = [
      "noatime"
      "big_writes"
    ];
  };

    fileSystems."/mnt/sssd" = {
    device = "/dev/disk/by-label/bssd";
    fsType = "ext4";
    options = ["noatime"];
  };
  

  fileSystems."/mnt/server" = {
    device = "192.168.1.200:/data/media";
    fsType = "nfs";
  };


  hardware.graphics= {
    enable = true;
    # package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
    # driSupport = true;
    extraPackages = with pkgs; [
    ];
    extraPackages32 = with pkgs; [
    ];
    enable32Bit = true;
  };

  hardware.amdgpu = {
  	opencl.enable = true;
	overdrive.enable = true;
	# zluda.enable = true;
  };

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   # package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  #   open = false;
  # };
  # services.xserver.videoDrivers = ["nvidia"];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="26ce", ATTRS{idProduct}=="01a2", ATTR{authorized}="0"
    # Joy-Con L (Bluetooth)
    KERNEL=="hidraw*", KERNELS=="*057e:2006*", MODE="0660", TAG+="uaccess"
    # Joy-Con R (Bluetooth)
    KERNEL=="hidraw*", KERNELS=="*057e:2007*", MODE="0660", TAG+="uaccess"
    # Joy-Con Charging Grip (USB)
    KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="200e", MODE="0660", TAG+="uaccess"
  '';

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # extraModulePackages = [config.hardware.nvidia.package ];
    # initrd.kernelModules = ["nvidia"];

  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.configurationLimit = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.theme = "${pkgs.catppuccin-grub}";
  boot.loader.grub.gfxmodeEfi = "1024x768";
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
      # dns = "none";
    };
    # nameservers = [ "127.0.0.1" "::1" ];
    interfaces.enp5s0.wakeOnLan.enable = true;
    extraHosts = ''
      192.168.1.200 serv
      192.168.1.200 serv.local
      192.168.1.53 laptop
      '';
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
    # package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      # polybarFull
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
  services.desktopManager.gnome = {
    enable = false;
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

  services.joycond = {
    enable = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };

  hardware.sane = {
    enable = false;
    # extraBackends = [ pkgs.hplipWithPlugin pkgs.epkowa pkgs.utsushi ];
    # drivers.scanSnap.enable = true;
  };

  # nixpkgs.config.sane.snapscanFirmware = pkgs.fetchurl {
  #   url = "https://media-cdn.ubuntu-de.org/wiki/attachments/52/46/Esfw41.bin"; #Epson Perfection 2480
  #   sha256 = "00cv25v4xlrgp3di9bdfd07pffh9jq2j0hncmjv3c65m8bqhjglq";
  # };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  #programs.appimage = {
  #  enable = true;
  #  binfmt = true;
  # };


  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  users.groups.libvirtd.members = ["kios"];
  virtualisation.spiceUSBRedirection.enable = true;

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
  # services.flatpak.enable = true;

  # Enable sound.
  hardware.bluetooth.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [48000 96000 192000];
        };
      };
    };
  };

  security.rtkit.enable = true;

  services.displayManager.gdm = {
    # enable = true;
    # wayland = true;
  };

  services.displayManager.ly= {
      enable = true;
      # settings.remember = true;
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
    extraGroups = ["wheel" "scanner" "lp" "video" "tty" "dialout" "seat"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      appimage-run
      deluge
      # easyeffects
      rime-data
      librime
      mono
      pavucontrol
      pwvucontrol
      # lutris
      (pkgs.lutris.override {
  # Intercept buildFHSEnv to modify target packages
  buildFHSEnv = args: pkgs.buildFHSEnv (args // {
    multiPkgs = envPkgs:
      let
        # Fetch original package list
        originalPkgs = args.multiPkgs envPkgs;

        # Disable tests for openldap
        customLdap = envPkgs.openldap.overrideAttrs (_: { doCheck = false; });
      in
      # Replace broken openldap with the custom one
      builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
  });
})
      vkd3d-proton
      yadm
    ];
  };

  # programs.honkers-railway-launcher.enable = true;
  # programs.anime-game-launcher.enable = true;
  # programs.sleepy-launcher.enable = true;

  programs.hyprland = {
     enable = true;
     xwayland.enable = true;
     # enableNvidiaPatches = true;
     # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
     # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
    protontricks.enable = true;
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
    ffmpeg-full
    p7zip
    xkill
    vkbasalt
    lsfg-vk
    # wine
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
    # xsane
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
    dig
    nh
    nix-output-monitor
    lsfg-vk-ui
    imagemagick
  ];

  services.udev.packages = [pkgs.via];

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
    # enable = true;
    group = "video";
    openFirewall = true;
  };
  # users.users.jellyfin.extraGroups = ["video"];

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };


  # services.comfyui = {
  #   enable = true;
  #   cuda = true;  # Enable NVIDIA GPU acceleration (recommended for most users)
  #   # cudaCapabilities = [ "8.9" ];  # Optional: optimize system CUDA packages for RTX 40xx
  #   #   Note: Pre-built PyTorch wheels already support all GPU architectures
  #   enableManager = true;  # Enable the built-in ComfyUI Manager
  #   port = 8188;
  #   listenAddress = "127.0.0.1";  # Use "0.0.0.0" for network access
  #   dataDir = "/mnt/sssd/AI/comfyui-data";
  #   openFirewall = false;
  #   extraArgs = [ "--lowvram" "--force-fp16" "--use-pytorch-cross-attention" ];
  #   # environment = { };
  # };

  # services.mpd = {
  #   enable = true;
  #   startWhenNeeded = true;
  #   user = "kios";
  #   dataDir = "/home/kios/.config/mpd";
  #   settings = {
  #   	db_file = "/home/kios/.config/mpd/mpd.db";
  #   	playlist_directory = "/home/kios/.config/mpd/playlists";
  #   	music_directory = "/mnt/server/Music";
  #       #musicDirectory = "/mnt/server/Media/Music";
  #     audio_output = [
  #       {
  #         type = "pipewire";
  #         name = "Pipewire";
  #       }
  #     ];
  #   };
  # };

  # services.x2goserver.enable = true;
  networking.firewall.enable = false;

  location = {
    provider = "manual";
    longitude = 12.0;
    latitude = 45.0;
  };

  #services.redshift = {
  #  enable = true;
  #};

  # programs.openvpn3.enable = true;

  services.tailscale.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
