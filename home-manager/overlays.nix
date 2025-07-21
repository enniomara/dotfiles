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
  custom-packages = final: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (python-final: python-prev: {
          llm-github-copilot = python-final.buildPythonPackage {
            pname = "llm-github-copilot";
            version = "0.2.0";
            pyproject = true;

            src = final.fetchFromGitHub {
              owner = "jmdaly";
              repo = "llm-github-copilot";
              rev = "main";
              sha256 = "sha256-BUVpt1Vv0+kxbTYHDdiYy3+ySJKWJ9b+dYexV7YS+NI=";
            };

            nativeBuildInputs = with final.python3Packages; [
              setuptools
              wheel
            ];

            propagatedBuildInputs = with final.python3Packages; [
              llm
              httpx
            ];
          };
        })
      ];
  };
}
