{
  me.ghostty = {
    darwin = {pkgs, ...}: {
      fonts.packages = [
        pkgs.nerd-fonts.iosevka
      ];
    };

    homeManager.xdg.configFile."ghostty/config" = {
      text = ''
        theme = TokyoNight Moon
        # the default scroll (of 1) jumps way too much. Make it more like kitty
        mouse-scroll-multiplier = 0.5

        font-family = Iosevka NFM
        font-size = 16
        macos-titlebar-style = tabs
      '';
    };
  };
}
