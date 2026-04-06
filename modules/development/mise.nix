{
  me.mise.homeManager = {
    programs.mise = {
      enable = true;
      enableZshIntegration = true;
      globalConfig = {
        tools = {
          python = "3.12";
        };
        settings = {
          idiomatic_version_file_enable_tools = [];
        };
      };
    };
  };
}

