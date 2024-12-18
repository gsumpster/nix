{ config, pkgs, lib, inputs, ... }:



{
  home.stateVersion = "23.11";

  home.file = {
    ".hyper.js" = {
      source = ./.hyper.js;
      target = "${config.home.homeDirectory}/.hyper.js";
      force = true;
    };
  };

  home.packages = with pkgs; [
    coreutils
    curl
    wget
    jq
    htop
    kubectl
    kubectx
    kubernetes-helm
    awscli
    cachix
    zoom-us
    aws-vault
  ];

  # imports = [inputs._1password-shell-plugins.hmModules.default];
  programs = {
      # _1password-shell-plugins = {
      #   enable = true;
      #   plugins = with pkgs; [ gh awscli2 cachix ];
      # };
      zsh = {
        enable = true;
        enableCompletion = true;

        initExtra = ''
          source /Users/george/.config/op/plugins.sh
          export PATH="/opt/homebrew/bin:$PATH"
        '';

        oh-my-zsh = {
          enable = true;
          plugins = ["1password" "aws" "battery" "brew" "docker" "docker-compose" "git" "kubectl" "kubectx" "macos"];
        };
      };
      git = {
        enable = true;
        userName = "George Sumpster";
        userEmail = "hello@grg.smpstr.email";

        extraConfig = {
          init = {
            defaultBranch = "main";
          };
        };
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
      direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
        };
      };
      vscode = {
        enable = true;
        mutableExtensionsDir = false;
        extensions = with pkgs.vscode-extensions; [
          redhat.vscode-yaml
          jnoortheen.nix-ide
          ms-kubernetes-tools.vscode-kubernetes-tools
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          eamodio.gitlens
          github.vscode-pull-request-github
          github.vscode-github-actions
          github.codespaces
          github.copilot
          github.copilot-chat
          rust-lang.rust-analyzer
          graphql.vscode-graphql-syntax
          graphql.vscode-graphql
          ms-python.python
        ]++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "binary-plist";
            publisher = "dnicolson";
            version = "0.11.3";
            sha256 = "sha256-/Wwoy1EOfTx2QimblmnnnY2xWynofua/v1mR/9oZMAw=";
          }
          {
            name = "terraform";
            publisher = "Hashicorp";
            version = "2.29.5";
            sha256 = "sha256-r3Ay7DKfe0AcgrEQnEPBJSCh9reCFoeT30B1SMl76mk=";
          }
          {
            name = "HCL";
            publisher = "Hashicorp";
            version = "0.3.2";
            sha256 = "sha256-cxF3knYY29PvT3rkRS8SGxMn9vzt56wwBXpk2PqO0mo=";
          }
          {
            name = "vsliveshare";
            publisher = "MS-vsliveshare";
            version = "1.0.5883";
            sha256 = "sha256-BNxLINcbat2F4PHCrKHKIuMpXW1q9aP2SDb0oIv48v0=";
          }
          {
              name = "beardedtheme";
              publisher = "beardedbear";
              version = "9.1.4";
              sha256 = "sha256-RL6Yko0ustm/4Ery/JbNOaZUiQgvSbvQvd4SmQf8oWM=";
          }
          {
            name = "vscode-jest";
            publisher = "orta";
            version = "5.2.3";
            sha256 = "sha256-cPHwBO7dI44BZJwTPtLR7bfdBcLjaEcyLVvl2Qq+BgE=";
          }
          {
            name = "vscode-jest-runner";
            publisher = "firsttris";
            version = "0.4.72";
            sha256 = "sha256-1nUpOXdteWsyFYJ2uATCcr1SUbeusmbpa09Bkw9/TZM=";
          }
          {
            name = "angular-console";
            publisher = "nrwl";
            version = "18.20.0";
            sha256 = "sha256-DSu9pjDa62MxrkAJHpDI4jIF2Kjy2n2xK2fE4bqCf4Q=";
          }
        ];
      };
    };
}