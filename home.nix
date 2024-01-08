{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    coreutils
    curl
    wget
    jq
    htop
    kubectl
    kubectx
    awscli
    cachix
    zoom-us
  ];

  programs = {
      zsh = {
        enable = true;
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
          rust-lang.rust-analyzer
          serayuzgur.crates
          graphql.vscode-graphql-syntax
          graphql.vscode-graphql
          orta.vscode-jest
          firsttris.vscode-jest-runner
        ]++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "binary-plist";
            publisher = "dnicolson";
            version = "0.11.3";
            sha256 = "sha256-/Wwoy1EOfTx2QimblmnnnY2xWynofua/v1mR/9oZMAw=";
          }
          {
            name = "vsliveshare";
            publisher = "MS-vsliveshare";
            version = "1.0.5883";
            sha256 = "sha256-BNxLINcbat2F4PHCrKHKIuMpXW1q9aP2SDb0oIv48v0=";
          }
        ];
      };
    };
}