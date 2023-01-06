rec {
  oh-my-zsh = (final: prev: {
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
  });
}
