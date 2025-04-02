rec {
  golangci-lint = final: prev: {
    golangci-lint =
      prev.callPackage
      "${prev.path}/pkgs/by-name/go/golangci-lint/package.nix"
      {
        buildGo124Module = args:
          prev.buildGo124Module (args
            // rec {
              version = "1.64.8";

              src = prev.fetchFromGitHub {
                owner = "golangci";
                repo = "golangci-lint";
                rev = "v${version}";
                sha256 = "sha256-H7IdXAleyzJeDFviISitAVDNJmiwrMysYcGm6vAoWso=";
              };

              vendorHash = "sha256-i7ec4U4xXmRvHbsDiuBjbQ0xP7xRuilky3gi+dT1H10=";

              ldflags = [
                "-s"
                "-w"
                "-X main.version=${version}"
                "-X main.commit=v${version}"
                "-X main.date=19700101-00:00:00"
              ];
            });
      };
  };
}
