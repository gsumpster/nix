{ pkgs, lib, inputs, ... }: let
  user = "george";
in {
  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    pathsToLink = [
      "/Applications"
      "/share/zsh"
    ];
    systemPackages = with pkgs; [
      coreutils
    ];
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "terraform"
      "terragrunt"
      "kubergrunt"
      "ory-hydra"
      "libffi"
    ];
    casks = [
      # "1password" - Assumed to be installed prior to nix configuration for authenticating with iCloud etc.
      "1password-cli"
      "slack"
      "tailscale"
      "rectangle"
      "spotify"
      "docker"
      "google-chrome"
      "notion"
      "tableplus"
      "postman"
      "figma"
      "skype"
      "linear-linear"
      "reverso"
      "firefox"
      "obsidian"
      "discord"
      "moonlight"
      "raycast"
      "hyper"
      "jetbrains-toolbox"
      "jan"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "Fantastical" = 975937182;
      "Omnifocus 4" = 1542143627;
      "Handmirror" = 1502839586;
      "Paprika" = 1303222628;
    };
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     (nerdfonts.override { fonts = [ "RobotoMono" ]; })
   ];

  nix = {
    settings = {
      bash-prompt-prefix = "(nix:$name)";
      build-users-group = "nixbld";
      experimental-features = [
        "auto-allocate-uids"
        "flakes"
        "nix-command"
      ];
      trusted-users = [ "@admin" "${user}" ];
    };

    extraOptions = ''
      # Generated by https://github.com/DeterminateSystems/nix-installer, version 0.11.0.
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
  };

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };
}