{
    description = "Um flake muito básico";

    inputs = {
        stable.url = "github:NixOS/nixpkgs/nixos-25.11";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = {
        self,
        stable,
        unstable
    }:

    let
        system = "x86_64-linux";

        overlays = [{
            nixpkgs.overlays = [
                (final: prev: {
                    unstable = import unstable {
                        inherit system;
                        config = {
                            allowUnfree = true;
                        };
                    };
                })
            ];
        }];
    in
    {
        nixosConfigurations = {
            nixos = stable.lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
                ] ++ overlays;
            };
        };
    };
}
