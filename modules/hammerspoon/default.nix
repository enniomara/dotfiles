{
  me.hammerspoon = {
    homeManager.home.file.".hammerspoon/init.lua" = {
      source = ./init.lua;
    };

    darwin.homebrew = {
      casks = [
        "hammerspoon"
      ];
    };
  };
}
