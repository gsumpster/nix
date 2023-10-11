{
  description = "George's Darwin System";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager 
    home-manager.url = "github:nix-community/home-manager/release-23.05";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-homebrew, nix-darwin, nixpkgs, home-manager }: {
    darwinConfigurations."george" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
        };
      };

      modules = [
        ./configuration.nix

        nix-homebrew.darwinModules.nix-homebrew
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

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.george = import ./home.nix;            
        }
      ];
    };
  };
}