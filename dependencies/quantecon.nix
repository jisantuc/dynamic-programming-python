{ ps, pkgs, ... }:
with ps;
(
  buildPythonPackage rec {
    format = "flit";
    pname = "quantecon";
    version = "0.7.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-gBp9X/DpRIVtBLzo0oWzLPXnFR5HddKj6oyWMyJVmGE=";
    };
    doCheck = false;
    propagatedBuildInputs = with pkgs.python3Packages; [
      numba
      numpy
      requests
      scipy
      sympy
    ];
  }
)
