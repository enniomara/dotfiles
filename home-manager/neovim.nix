{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          astro
          bash
          comment
          css
          diff
          dockerfile
          git_rebase
          go
          gomod
          graphql
          html
          javascript
          jq
          json
          jsonc
          latex
          lua
          make
          markdown
          nix
          python
          regex
          ruby
          tsx
          typescript
          terraform
          yaml
        ]
      ))

      # do not attempt to manage treesitter parsers through nix. Lazy.nvim
      # takes ownership of packpath, so nix's configuration method does not
      # work, as it puts the parsers in the packpath
      # https://github.com/folke/lazy.nvim/issues/402
      # https://github.com/folke/lazy.nvim/issues/516
      pkgs.vimPlugins.lazy-nvim
    ];
    extraPackages = with pkgs; [
      # python
      black
      isort
      python311Packages.flake8
      nodePackages.pyright

      rnix-lsp
      clojure-lsp

      gopls

      lua-language-server

      # ts/html/css etc
      prettierd
      nodePackages.prettier
      vscode-langservers-extracted # eslint
      nodePackages.typescript-language-server

      # rust
      rust-analyzer
    ];
  };
}
