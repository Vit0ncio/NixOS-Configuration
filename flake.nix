{
    description = "NixOS de Vitor";

    inputs = {
        nixpkgs-stable = {
            url = "github:NixOS/nixpkgs/nixos-25.11";
        };

        nixpkgs-unstable = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };
    };

    outputs = {
        self,
        nixpkgs-stable,
        nixpkgs-unstable,
        home-manager,
        ...
    }:

    let
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable {
            inherit system;
            config = {
                allowUnfree = true;
            };
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

                            users = {
                                vitor = import ./home.nix;
                            };
                        };
                    }
                ];
                specialArgs = { inherit unstable; };
            };
        };
    };
}

