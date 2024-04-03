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
      tree-sitter
      nodePackages.pyright
      ccls

      # installs different langauge servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
    ];
    plugins = with pkgs.vimPlugins; [
      # you can use plugins from the pkgs
      vim-which-key
      nvim-cmp
      cmp-vsnip
      vim-vsnip
      telescope-nvim
      nvim-tree-lua
      impatient-nvim
      vim-svelte
      neorg
      ale
      zig-vim

      {
          plugin = neorg;
          # config = ''
          #   lua << END
          #   require('neorg').setup {
          #       load = {
          #           ["core.defaults"] = {}
          #       }
          #   }
          #     END
          # '';
      }

      # or you can use our function to directly fetch plugins from git
      (plugin "neovim/nvim-lspconfig")
      (plugin "hrsh7th/cmp-nvim-lsp")
      (plugin "hrsh7th/vim-vsnip-integ")

      (plugin "mrcjkb/telescope-manix")

      # syntax highlighting
      (plugin "nvim-treesitter/nvim-treesitter")

      # (plugin "scrooloose/nerdtree")
      (plugin "lyuts/vim-rtags")
      (plugin "mbbill/undotree")
      (plugin "ctrlpvim/ctrlp.vim")
      (plugin "skammer/vim-css-color")
      (plugin "chrisbra/csv.vim")
      (plugin "sheerun/vim-polyglot")
      (plugin "simrat39/symbols-outline.nvim")
      (plugin "tpope/vim-surround")
      (plugin "tpope/vim-fugitive")
      (plugin "tpope/vim-commentary")
      (plugin "godlygeek/tabular")
      (plugin "tpope/vim-dadbod")
      (plugin "dag/vim-fish")
      (plugin "lervag/vimtex")
      (plugin "ryanoasis/vim-devicons")
      (plugin "kyazdani42/nvim-web-devicons")
      (plugin "romgrk/barbar.nvim")
      (plugin "nvim-lualine/lualine.nvim")
      (plugin "ap/vim-css-color")

      (plugin "catppuccin/nvim")
    ];

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents /home/kios/.config/nvim/autocmds.vim)
      (lib.strings.fileContents /home/kios/.config/nvim/settings.vim)
      (lib.strings.fileContents /home/kios/.config/nvim/commands.vim)
      (lib.strings.fileContents /home/kios/.config/nvim/settings.vim)
      (lib.strings.fileContents /home/kios/.config/nvim/mappings.vim)
      (lib.strings.fileContents /home/kios/.config/nvim/servers.vim)
    ];
  };
}
