{
  me.languages._.go = {
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
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
            golangci-lint
          ];
      };
    };
  };
}
