{ config, lib, pkgs, ... }:

let
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "tokyo-night";
      publisher = "enkia";
      version = "0.9.6";
      sha256 = "sha256-Vk6wIGMzWPpv+A4vnHWAYnxTFYQBpVYZNu1BRim/TN0=";
    }
    {
      name = "azure-account";
      publisher = "ms-vscode";
      version = "0.11.6";
      sha256 = "sha256-bLhlQxpZHhL3IHAqFxJEhe38/hIklBqCxBdXeKPBawI=";
    }
    {
      name = "codesandbox-projects";
      publisher = "codesandbox-io";
      version = "0.2.124";
      sha256 = "sha256-Y2Rf/WykoooFJ5oeVWyFonNuDwRIqt2S05xSsBO6Hzw=";
    }
    {
      name = "d2";
      publisher = "terrastruct";
      version = "0.8.8";
      sha256 = "sha256-nnljLG2VL7r8bu+xFOTBx5J2UBsdjOwtAzDDXKtK0os=";
    }
    {
      name = "es6-string-css";
      publisher = "bashmish";
      version = "0.1.0";
      sha256 = "sha256-PrH0rw1rbL8oXRPvGRCH7R9C1zwlXXi5mID85f9wNUE=";
    }
    {
      name = "es6-string-html";
      publisher = "tobermory";
      version = "2.14.1";
      sha256 = "sha256-l0WQOHrZse6ezrRO3aUaGnlT4oCpt8fkXRPmnRst+Xw=";
    }
    {
      name = "vscode-js-profile-flame";
      publisher = "ms-vscode";
      version = "1.0.8";
      sha256 = "sha256-qgWWhpQ391EIKiLfLd0zA9MXxYlibg2G+N+/1BPPjMU=";
    }
    {
      name = "github-markdown-preview";
      publisher = "bierner";
      version = "0.3.0";
      sha256 = "sha256-7pbl5OgvJ6S0mtZWsEyUzlg+lkUhdq3rkCCpLsvTm4g=";
    }
    {
      name = "vscode-jest";
      publisher = "orta";
      version = "6.2.0";
      sha256 = "sha256-FOONZFo0NvkaC2n/Uqasbjoph23bXmPcxYO9Ln4pVtQ=";
    }
    {
      name = "ksql";
      publisher = "rmoff";
      version = "0.1.4";
      sha256 = "sha256-nAfj4GMyBWchp/6ufsoBcu3Cy15+7nGp56rRQ041tX4=";
    }
    {
      name = "vscode-edge-devtools";
      publisher = "ms-edgedevtools";
      version = "2.1.4";
      sha256 = "sha256-O3O03sYW3g3noEnhY1OqW5zjMsO33xDa/wP3X7TwPLc=";
    }
    {
      name = "vscode-sql-formatter";
      publisher = "adpyke";
      version = "1.4.4";
      sha256 = "sha256-g4oqB0zV7jB7PeA/d2e8jKfHh+Ci+us0nK2agy1EBxs=";
    }
    {
      name = "ts-barrelr";
      publisher = "mikerhyssmith";
      version = "1.6.0";
      sha256 = "sha256-zc21SVBH5meq4v1RxvSuoEWENyB/VGOa2WU4g0ysBM8=";
    }
  ];
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        (ms-python.python.overrideAttrs (finalAttrs: previousAttrs: {
          postPatch = "";
          separateDebugInfo = true;
        }))
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        xaver.clang-format
        ms-vscode-remote.remote-containers
        mikestead.dotenv
        elixir-lsp.vscode-elixir-ls
        dbaeumer.vscode-eslint
        tamasfe.even-better-toml
        mhutchie.git-graph
        github.codespaces
        github.vscode-pull-request-github
        golang.go
        graphql.vscode-graphql
        graphql.vscode-graphql-syntax
        eamodio.gitlens
        ms-kubernetes-tools.vscode-kubernetes-tools
        ms-vscode.live-server
        ms-vsliveshare.vsliveshare
        esbenp.prettier-vscode
        zxh404.vscode-proto3
      ] ++ marketplaceExtensions;

    userSettings = builtins.fromJSON ''
{
    "omnisharp.useGlobalMono":"always",
    "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "workbench.colorTheme": "Noctis High Contrast",
    "editor.codeActionsOnSave": {
        "source.fixAll": "explicit"
    },
    "jest.showCoverageOnLoad": true,
    "jest.coverageColors": {
        "covered": "rgba(9, 156, 65, 0.4)",
        "uncovered": "rgba(121, 31, 10, 0.4)",
        "partially-covered": "rgba(235, 198, 52, 0.4)",
    },
    "jest.coverageFormatter": "GutterFormatter",
    "[yaml]": {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "keep",
        "gitlens.codeLens.scopes": [
            "document"
        ],
        "editor.quickSuggestions": {
            "other": true,
            "comments": false,
            "strings": true
        }
    },
    "[json]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[jsonc]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "typescript.updateImportsOnFileMove.enabled": "always",
    "javascript.updateImportsOnFileMove.enabled": "always",
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "files.exclude": {
        "**/.classpath": true,
        "**/.project": true,
        "**/.settings": true,
        "**/.factorypath": true
    },
    "java.home": "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",
    "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[java]": {
        "editor.defaultFormatter": "redhat.java"
    },
    "vs-kubernetes": {
        "vscode-kubernetes.helm-path.mac": "/Users/maxbolotin/.vs-kubernetes/tools/helm/darwin-arm64/helm",
        "vscode-kubernetes.kubectl-path.mac": "/Users/maxbolotin/.vs-kubernetes/tools/kubectl/kubectl",
        "vscode-kubernetes.minikube-path.mac": "/Users/maxbolotin/.vs-kubernetes/tools/minikube/darwin-arm64/minikube"
    },
    "editor.tabSize": 2,
    "go.alternateTools": {
        "go": "/opt/homebrew/bin/go"
    },
    "githubPullRequests.pullBranch": "never",
    "D2.previewSketch": false,
    "D2.previewTheme": "Dark mauve",
    "D2.previewLayout": "elk",
    "editor.fontLigatures": true,
    "githubPullRequests.pushBranch": "always",
    "editor.accessibilitySupport": "off",
    "scm.autoReveal": true,
    "editor.fontWeight": "500",
    "D2.execPath": "/opt/homebrew/bin/d2",
    "jest.autoRun": {
        "watch": false
    },
    "barrelr.useDoubleQuotes": true,
    "barrelr.lineEnding": "LF",
    "codesandbox.currentWorkspace": "d47959d1-a1b4-4c97-a25f-c6d4d1bfcc5b",
    "vscode-edge-devtools.browserFlavor": "Default",
    "editor.fontFamily": "'JetBrainsMono Nerd Font Mono', Menlo, Monaco, 'Courier New', monospace"
}
    '';
  };
}
