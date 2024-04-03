{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      # ms-python.python
      bbenoist.nix
      esbenp.prettier-vscode
      svelte.svelte-vscode
      # ms-dotnettools.csharp
      # ms-vscode.cpptools
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode-remote.remote-ssh
      ms-vscode.hexeditor
      kamadorueda.alejandra
      vscodevim.vim
    ];

    mutableExtensionsDir = true;

    haskell = {
      # enable = true;
      # hie.enable = true;
    };

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.fontFamily" = "'CaskaydiaCove Nerd Font', 'monospace', monospace";
      "editor.fontLigatures" = "'calt', 'ss19'";
      "editor.rulers" = [80 120];

      "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
      "files.simpleDialog.enable" = true;

      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
      };
      "alejandra.program" = "alejandra";
    };
  };
}
