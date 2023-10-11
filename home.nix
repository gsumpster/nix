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
          jnoortheen.nix-ide
          ms-kubernetes-tools.vscode-kubernetes-tools
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          eamodio.gitlens
          github.vscode-pull-request-github
        ];
      };
    };
}