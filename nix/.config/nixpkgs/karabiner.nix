{ pkgs, lib, ... }:
{
  xdg.configFile."karabiner.edn" = lib.mkIf pkgs.stdenv.isDarwin {
    text = builtins.readFile (pkgs.substituteAll {
      src = ../../../karabiner/.config/karabiner/karabiner.edn;
      toggleApplicationPath = ../../../karabiner/.config/karabiner/ToggleApplication.scpt;
    })
    ;
    onChange = ''
      ${pkgs.goku}/bin/goku
      echo "==== Karabiner has successfuly updated"
    '';
  };
}

