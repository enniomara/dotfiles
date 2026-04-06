{
  me.macContainers = {
    homeManager = {pkgs, ...}: {
      home.packages = [
        # use unstable here because nixpgks 25.11 as of 2026-04-06 contains the
        # 1.2.2 version of lima, which is EOL. That forces nix to refuse to
        # install.
        pkgs.nixpkgs-unstable.colima
        pkgs.docker-client
        # note: you need to manually set credsStore to `osxkeychain` in ~/.docker/config.json
        # docker doesn't like it when docker.config is not writeable -.-
        pkgs.docker-credential-helpers
      ];
    };
  };
}
