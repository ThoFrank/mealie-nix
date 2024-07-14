{
  description = "Application packaged using poetry2nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mealie = {
      url = "github:mealie-recipes/mealie/v1.10.2";
      flake = false;
    };
    
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix, mealie }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          mealie = pkgs.callPackage ./mealie {
            inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication overrides;
            src = mealie;
            python = pkgs.python311;
          };
          default = self.packages.${system}.mealie;
        };
      });
}
