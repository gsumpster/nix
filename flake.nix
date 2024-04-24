{
  description = "George's Darwin System";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager 
    home-manager.url = "github:nix-community/home-manager/release-23.11";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # import the 1Password Shell Plugins Flake
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
  };

  outputs = inputs: {
    darwinConfigurations."georges-MacBook-Pro" = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix

        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = "george";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }

        inputs.home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.george = import ./home.nix;            
        }
      ];
    };
  };
}