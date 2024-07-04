{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        # source = "nixos_small";
      };
      modules = [
        "os"
        "kernel"
        "uptime"
        "packages"
        "break"
        "cpu"
        "memory"
        "gpu"
        "display"
        "break"
        "wm"
        "theme"
        "terminal"
        "terminalfont"
        "terminalscheme"
      ];
    };
  };
}
