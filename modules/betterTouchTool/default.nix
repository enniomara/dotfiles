{
  me.betterTouchTool = {
    darwin.homebrew = {
      casks = [
        "bettertouchtool"
      ];
    };
    # btt autoloads this file automatically
    # https://community.folivora.ai/t/dotfile-configuration/25654
    homeManager.home.file.".btt_autoload_preset.json" = {
      source = ./Default.bttpreset;
    };
  };
}
