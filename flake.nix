{
    description = "NixOS de Vitor";

    inputs = {
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };

        plasma-manager = {
            url = "github:nix-community/plasma-manager";

            inputs = {
                nixpkgs.follows = "nixpkgs-stable";
                home-manager.follows = "home-manager";
            };
        };
    };

    outputs = {
        self,
        nixpkgs-stable,
        nixpkgs-unstable,
        home-manager,
        plasma-manager,
        ...
    }:

    let
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    in
    {
        nixosConfigurations = {
            nixos = nixpkgs-stable.lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
                    home-manager.nixosModules.home-manager {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            extraSpecialArgs = {
                                inherit unstable;
                            };

                            users.vitor = import ./home.nix;
                            backupFileExtension = "backup";

                            sharedModules = [
                                plasma-manager.homeManagerModules.plasma-manager
                            ];
                        };
                    }
                ];
                specialArgs = { inherit unstable; };
            };
        };
    };
}
