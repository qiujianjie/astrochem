with import <nixpkgs> {};

stdenv.mkDerivation rec {

  name = "astrochem-env";

  env = buildEnv { name = name; paths = buildInputs; };

  python2Env = python2.withPackages (ps: with ps; [ numpy h5py cython ]);

  sundials2 = sundials.overrideAttrs (oldAttrs: rec {
    name = "sundials-2.7.0";
    src = fetchurl {
      url = "https://computation.llnl.gov/projects/sundials/download/sundials-2.7.0.tar.gz";
      sha256 = "01513g0j7nr3rh7hqjld6mw0mcx5j9z9y87bwjc16w2x2z3wm7yk";
    };
  });

  buildInputs = [
    python2Env
    gfortran
    hdf5
    autoconf
    automake
    libtool
    sundials2
  ];

}
