{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}
