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
        # see https://github.com/nix-community/poetry2nix/tree/master#api for more functions and examples.
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication overrides;
      in
      {
        packages = {
          mealie = mkPoetryApplication {
            projectDir = mealie;
            python = pkgs.python311;
            overrides = overrides.withDefaults (final: prev: {
              coveragepy-lcov = prev.coveragepy-lcov.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.poetry-core ];
                }
              );
              jstyleson = prev.jstyleson.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
                }
              );
              types-python-slugify = prev.types-python-slugify.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
                }
              );
              apprise = prev.apprise.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.babel ];
                }
              );
              mkdocs-get-deps = prev.mkdocs-get-deps.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.hatchling ];
                }
              );
              pydantic-to-typescript = prev.pydantic-to-typescript.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
                }
              );
              mf2py = prev.mf2py.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
                }
              );
              pyrdfa3 = prev.pyrdfa3.overridePythonAttrs (
                old: {
                  patches = old.patches or [ ] ++ [ ./patches/0001-fix-setup.py.patch ];
                }
              );
              html-text = prev.html-text.overridePythonAttrs (
                old: {
                  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
                }
              );
            });
          };
          default = self.packages.${system}.mealie;
        };
      });
}
