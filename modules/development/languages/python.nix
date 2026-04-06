{
  me.languages._.python = {
    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.uv
      ];

      programs.mise = {
        globalConfig = {
          tools = {
            python = "3.12";
          };
        };
      };

      programs.neovim = {
        extraPackages = with pkgs; [
          pyright
          ruff
        ];
      };
    };
  };
}
