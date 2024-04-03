{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles.kios = {
      isDefault = true;
      name = "kios";
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        vimium
        bitwarden
        sponsorblock
        return-youtube-dislikes
        to-deepl
        darkreader
        firefox-color
        stylus
        inkah
        consent-o-matic
        enhancer-for-youtube
        augmented-steam
        # bypass-paywalls-clean
        reddit-enhancement-suite
        user-agent-string-switcher
        control-panel-for-twitter
      ];

      search = {
        default = "Brave";
        force = true;
        engines = {
          "Brave" = {
            urls = [
              {
                template = "https://search.brave.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconUpdateURL = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/favicon.c09fe1a1.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@b" "@brave"];
          };

          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nixpkgs"];
          };

          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nixopts"];
          };

          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nixwiki"];
          };

          "Genius" = {
            urls = [{template = "https://genius.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://genius.com/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@gen"];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
      };
    };
  };
}
