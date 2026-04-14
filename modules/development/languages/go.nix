{
  me.languages._.go = {
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      home.packages = with pkgs; [
        golangci-lint
      ];

      programs.mise = {
        enable = true;
        globalConfig = {
          tools = {
            golang = "1.21";
          };
        };
      };

      programs.neovim = {
        extraPackages = with pkgs;
          lib.mkAfter [
            gopls
          ];
      };

      programs.vscode = {
        profiles = {
          default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
              golang.go
            ];
          };
        };
      };
    };
  };
}
