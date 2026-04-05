{
  me.starship.homeManager = {
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
  };
}