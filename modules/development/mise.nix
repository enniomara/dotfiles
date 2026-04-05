{
  me.mise.homeManager = {
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
  };
}