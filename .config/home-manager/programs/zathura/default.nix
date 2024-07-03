{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zathura = {
    enable = true;
    catppuccin.enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}
