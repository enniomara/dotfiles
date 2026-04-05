{
  me.ollama.homeManager = {pkgs, ...}: {
    services.ollama = {
      enable = true;
      package = pkgs.nixpkgs-unstable.ollama;
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "8192";
      };
    };
  };
}