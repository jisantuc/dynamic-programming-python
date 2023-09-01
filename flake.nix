{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-darwin" "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = with pkgs.${system}; [
            (python3.withPackages (p: [
              p.black
              p.ipython
              p.ipdb
              p.numpy
              p.matplotlib
              p.scipy
              ((import ./dependencies/quantecon.nix) { pkgs = pkgs.${system}; ps = p; })
            ]))
          ];
        };
      });
    };
}
