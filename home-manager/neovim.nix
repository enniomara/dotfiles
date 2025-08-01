{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.nixpkgs-unstable.neovim-unwrapped;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins:
          with plugins; [
            astro
            bash
            comment
            css
            diff
            dockerfile
            elixir
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
            typst
            yaml
            xml
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
      pyright
      ruff

      # bash
      nodePackages.bash-language-server
      shellcheck # used by bashls
      shfmt # used by bashls

      # elixir
      elixir
      elixir-ls

      nil
      alejandra
      clojure-lsp

      gopls
      golangci-lint

      lua-language-server

      # ts/html/css etc
      prettierd
      nodePackages.prettier
      vscode-langservers-extracted # eslint
      nodePackages.typescript-language-server

      # sql
      sqlfluff

      # rust
      rust-analyzer

      # yaml
      yaml-language-server
      python311Packages.cfn-lint
      yamllint
    ];
  };
}
