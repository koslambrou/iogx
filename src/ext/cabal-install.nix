{ pkgs, lib, ... }:

# Builds cabal-install using the given ghc version.

ghc:

let

  project = pkgs.haskell-nix.hackage-project {

    name = "cabal-install";

    version = "3.10.3.0";

    compiler-nix-name = ghc;

    # The test suite depends on a nonexistent package...
    configureArgs = "--disable-tests";

    modules = [{
      packages.cabal-install.components.exes.cabal.dontStrip = false;
    }];
  };

in

project.hsPkgs.cabal-install.components.exes.cabal
