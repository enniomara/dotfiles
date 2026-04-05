{inputs, ...}: {
  nixpkgs-unstable = final: prev: {
    # available via pkgs.nixpkgs-unstable
    nixpkgs-unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  golangci-lint = final: prev: {
    golangci-lint =
      prev.callPackage
      "${prev.path}/pkgs/by-name/go/golangci-lint/package.nix"
      {
        buildGo124Module = args:
          prev.buildGo124Module (args
            // rec {
              version = "2.1.6";

              src = prev.fetchFromGitHub {
                owner = "golangci";
                repo = "golangci-lint";
                rev = "v${version}";
                sha256 = "sha256-L0TsVOUSU+nfxXyWsFLe+eU4ZxWbW3bHByQVatsTpXA=";
              };

              vendorHash = "sha256-tYoAUumnHgA8Al3jKjS8P/ZkUlfbmmmBcJYUR7+5u9w=";

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
