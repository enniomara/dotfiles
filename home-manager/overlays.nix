rec {
  oh-my-zsh = final: prev: {
    oh-my-zsh = prev.oh-my-zsh.overrideAttrs (finalAttrs: previousAttrs: {
      src = prev.fetchFromGitHub {
        owner = "ohmyzsh";
        repo = "ohmyzsh";
        # this commit includes my fix of autojump, which has not reached nixos
        # stable/unstable as of 2023-01-06
        rev = "00c37b6991895aac0398a24d7d8b78cda63dec05";
        sha256 = "sha256-hOemkWFJgh8LBD9GtlGcKdxtHLDequ0LpC7F2nGdDTo=";
      };
    });
  };
  golangci-lint = final: prev: {
    # from https://github.com/grafana/loki-hackathon-2023-03-project-lili/blob/main/flake.nix
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
