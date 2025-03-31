rec {
  golangci-lint = final: prev: {
    golangci-lint =
      prev.callPackage
      "${prev.path}/pkgs/by-name/go/golangci-lint/package.nix"
      {
        buildGoModule = args:
          prev.buildGoModule (args
            // rec {
              version = "1.57.2";

              src = prev.fetchFromGitHub rec {
                owner = "golangci";
                repo = "golangci-lint";
                rev = "v${version}";
                sha256 = "sha256-d3U56fRIyntj/uKTOHuKFvOZqh+6VtzYrbKDjcKzhbI=";
              };

              vendorHash = "sha256-3gS/F1jcjegtkLfmPcBzYqDA4KmwABkKpPAhTxqguYw=";

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
