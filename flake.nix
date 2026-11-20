{
  description = "Tapes v2 - Atomic per-target dotfile switcher";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      tapes-src = pkgs.callPackage ./nix/package.nix {};
    in {
      packages =
        {
          default = tapes-src;
          tapes = tapes-src;
          inherit tapes-src;
        }
        // pkgs.lib.optionalAttrs (system == "x86_64-linux") {
          tapes-bin = pkgs.callPackage ./nix/bin.nix {};
        };
    })
    // {
      overlays = {
        default = final: prev: {
          tapes = self.packages.${prev.stdenv.hostPlatform.system}.tapes-src;
        };
        tapes = self.overlays.default;
      };
    };
}
