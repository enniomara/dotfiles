{pkgs, ...}: {
  home.packages = [
    pkgs.colima
    pkgs.docker-client
  ];
}
