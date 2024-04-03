{ config, pkgs, lib, ... }:
{
    programs.eww = {
        enable = true;
        package = pkgs.eww-wayland;
        configDir = "/home/kios/.config/home-manager/programs/eww";
    };

}
