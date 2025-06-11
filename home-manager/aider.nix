{pkgs, ...}: {
  home.packages = [
    pkgs.nixpkgs-unstable.aider-chat
  ];

  home.file.".aider.conf.yml" = {
    text = ''
      openai-api-base: https://api.githubcopilot.com
      model: openai/gpt-4.1
      weak-model: openai/gpt-4o-mini
      show-model-warnings: false

      # do not put aider as author
      attribute-committer: false
    '';
  };

  home.file.".aider.model.settings.yml" = {
    text = ''
      # until https://github.com/Aider-AI/aider/issues/2227 is fixed
      - name: openai/gpt-4.1
        extra_params:
          extra_headers:
            Editor-Version: "aider/"
            Copilot-Integration-Id: "vscode-chat"
      - name: openai/gpt-4o-mini
        extra_params:
          extra_headers:
            Editor-Version: "aider/"
            Copilot-Integration-Id: "vscode-chat"
    '';
  };
}
