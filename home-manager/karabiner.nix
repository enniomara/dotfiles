{
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."karabiner.edn" = lib.mkIf pkgs.stdenv.isDarwin {
    text = builtins.readFile (pkgs.substituteAll {
      src = ../karabiner/.config/karabiner/karabiner.edn;
      toggleApplicationPath = ../karabiner/.config/karabiner/ToggleApplication.scpt;
    });
  };

  home.activation.karabinerConfig = lib.hm.dag.entryAfter ["linkGeneration"] ''
    echo "==== Starting karabiner config update"
    ${pkgs.goku}/bin/goku
    echo "==== Karabiner has successfuly updated"
  '';
}
