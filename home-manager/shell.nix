{
  pkgs,
  lib,
  ...
}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

  # brings color to ls
  programs.dircolors.enable = true;

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
        golang = "1.21";
        nodejs = "22";
        python = "3.12";
      };
      settings = {
        idiomatic_version_file_enable_tools = [];
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      right_format = "$time";
      time = {
        disabled = false;
      };
    };
  };

}
