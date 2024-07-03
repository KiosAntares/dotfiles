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
    # withPython3 = true;
    withNodeJs = true;

    # read in the vim config from filesystem
    # this enables syntaxhighlighting when editing those
    # install needed binaries here
    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      luajit
      tree-sitter
      pyright
      ccls
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

    extraLuaConfig = builtins.readFile ./config.lua;

    plugins = with pkgs.vimPlugins; [
      # you can use plugins from the pkgs

      # UI/UX
      lualine-nvim # Fast status line
      catppuccin-nvim # Color theme
      {
        # Tabs
        plugin = barbar-nvim;
        type = "lua";
        config = ''require("barbar").setup()'';
      }
      {
        # Fzf and utilities
        plugin = telescope-nvim;
        type = "lua";
        config = ''require("telescope").setup()'';
      }
      telescope-manix
      undotree
      tabular # Tabularize/align
      vim-which-key # In-editor help for keybinds
      {
        # File explorer
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''require("nvim-tree").setup()'';
      }
      symbols-outline-nvim # Tree view of symbols
      ale # Async linting and error checking
      {
        # LSP-based surround of elements
        plugin = nvim-surround;
        type = "lua";
        config = ''require("nvim-surround").setup({})'';
      }

      # Syntax highlighting and language support
      {
        plugin = nvim-treesitter.withPlugins (p:
          with p; [
            # AllGrammars
            tree-sitter-norg
            tree-sitter-norg-meta
          ]);
        # plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require("nvim-treesitter.configs").setup {
              auto_install = false,
              -- ensure_installed = { 'norg' },
              highlight = {
                  enable = true,
              },
              -- parser_install_dir = "/home/kios/parsers-temp"
            }
        '';
      }
      vim-polyglot # Multi language highlighting
      zig-vim
      vim-svelte
      vim-css-color
      csv-vim
      vim-fish
      vimtex
      vim-devicons
      nvim-web-devicons
      {
        plugin = image-nvim;
        type = "lua";
        config = ''require("image").setup({})'';
      }

      # Org like tool
      nui-nvim
      plenary-nvim
      nvim-nio
      {
        plugin = neorg;
        type = "lua";
        config = builtins.readFile ./plugins/neorg.lua;
      }
      neorg-telescope
      nvim-treesitter.builtGrammars.tree-sitter-norg
      # nvim-treesitter.builtGrammars.tree-sitter-norg-meta

      # Autocomplete
      luasnip
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/lspconfig.lua;
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/cmp.lua;
      }

      {
        plugin = cmp-nvim-lsp;
        type = "lua";
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
        type = "lua";
        config = builtins.readFile ./plugins/neodev.lua;
      }

      (plugin "lyuts/vim-rtags")
    ];

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./vimFiles/settings.vim)
      (lib.strings.fileContents ./vimFiles/commands.vim)
      (lib.strings.fileContents ./vimFiles/mappings.vim)
    ];
  };
}
