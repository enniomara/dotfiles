{
  me.macContainers = {
    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.colima
        pkgs.docker-client
        # note: you need to manually set credsStore to `osxkeychain` in ~/.docker/config.json
        # docker doesn't like it when docker.config is not writeable -.-
        pkgs.docker-credential-helpers
      ];
    };
  };
}
