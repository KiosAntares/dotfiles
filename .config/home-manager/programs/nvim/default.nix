{
  config,
  pkgs,
  lib,
  ...
}: let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = true;
    withNodeJs = true;

    # read in the vim config from filesystem
    # this enables syntaxhighlighting when editing those
    # install needed binaries here
    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      luajit
      tree-sitter
      pyright
      # ccls
      lua-language-server
      rust-analyzer
      imagemagick
    ];

    extraLuaPackages = luaps: [
      luaps.lua-utils-nvim
      luaps.pathlib-nvim
      luaps.magick
      luaps.luarocks
    ];

    initLua = builtins.readFile ./config.lua;

    plugins = with pkgs.vimPlugins; [
      # you can use plugins from the pkgs

      lualine-nvim
      catppuccin-nvim # Color theme
      {
        # Tabs
        plugin = barbar-nvim;
        config = ''require("barbar").setup()'';
      }
      nvim-web-devicons
      {
        # Fzf and utilities
        plugin = telescope-nvim;
        config = ''require("telescope").setup()'';
      }
      {
        # File explorer
        plugin = nvim-tree-lua;
        config = ''require("nvim-tree").setup()'';
      }
      symbols-outline-nvim
      {
        # LSP-based surround of elements
        plugin = nvim-surround;
        config = ''require("nvim-surround").setup({})'';
      }
        
      # Syntax highlighting and language support
      nvim-treesitter.withAllGrammars
      {
        plugin = image-nvim;
        config = ''require("image").setup({})'';
      }

      # Autocomplete
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ./plugins/lspconfig.lua;
      }

      {
        plugin = nvim-cmp;
        config = builtins.readFile ./plugins/cmp.lua;
      }

      {
        plugin = cmp-nvim-lsp;
        config = ''
            -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          -- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
          lspconfig.clangd.setup {
            capabilities = capabilities,
          }
          lspconfig.pyright.setup {
            capabilities = capabilities,
          }
          lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
          }
        '';
      }

      {
        plugin = neodev-nvim;
        config = builtins.readFile ./plugins/neodev.lua;
      }

      # (plugin "lyuts/vim-rtags")
    ];

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./vimFiles/settings.vim)
      (lib.strings.fileContents ./vimFiles/commands.vim)
      (lib.strings.fileContents ./vimFiles/mappings.vim)
    ];
  };
}
