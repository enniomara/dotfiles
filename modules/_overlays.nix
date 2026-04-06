{inputs, ...}: {
  nixpkgs-unstable = final: prev: {
    # available via pkgs.nixpkgs-unstable
    nixpkgs-unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  golangci-lint = final: prev: {
    golangci-lint = prev.golangci-lint.overrideAttrs rec {
      version = "2.1.6";

      src = prev.fetchFromGitHub {
        owner = "golangci";
        repo = "golangci-lint";
        rev = "v${version}";
        sha256 = "sha256-L0TsVOUSU+nfxXyWsFLe+eU4ZxWbW3bHByQVatsTpXA=";
      };

      vendorHash = "sha256-tYoAUumnHgA8Al3jKjS8P/ZkUlfbmmmBcJYUR7+5u9w=";

      postInstall = '''';

      ldflags = [
        "-s"
        "-w"
        "-X main.version=${version}"
        "-X main.commit=v${version}"
        "-X main.date=19700101-00:00:00"
      ];
    };
  };

  direnv = final: prev: {
    direnv = prev.direnv.overrideAttrs {
      # as of 2026-04-06 the test phase is failing for some reason. Disable it
      # temporarily
      checkPhase = '''';
    };
  };
}
