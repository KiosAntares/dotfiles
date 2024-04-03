{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = true;
      syntax_theme = "MochaDark";
      imports = ["verbs.hjson" "skins/catppuccin-mocha.hjson"];
    };
  };
}
