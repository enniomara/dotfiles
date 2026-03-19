{pkgs, ...}: {
  home.packages = [
    pkgs.colima
    pkgs.docker-client
    pkgs.docker-credential-helpers
  ];

  home.file.dockerConfig = {
    target = ".docker/config.json";
    force = true;
    text = ''
      {
        "currentContext": "colima",
        "credsStore": "osxkeychain"
      }
    '';
  };
}
