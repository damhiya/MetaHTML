{
  description = "MetaHTML";

  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, haskellNix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        index-state = "2022-07-23T00:00:00Z";
        overlays = [
          haskellNix.overlay
          (final: prev: {
            MetaHTML = final.haskell-nix.cabalProject' {
              inherit index-state;
              src = ./.;
              compiler-nix-name = "ghc902";
              shell.tools = {
                cabal = {
                  inherit index-state;
                  version = "3.6.2.0";
                };
                haskell-language-server = {
                  inherit index-state;
                  version = "1.7.0.0";
                };
                hpack = {
                  inherit index-state;
                  version = "0.35.0";
                };
              };
            };
          })
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
          inherit (haskellNix) config;
        };
        flake = pkgs.MetaHTML.flake { };
      in flake // rec {
        packages.default = flake.packages."MetaHTML:exe:MetaHTML";
        apps.default = {
          type = "app";
          program = "${packages.default}/bin/MetaHTML";
        };
      });
}
