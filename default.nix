with import <nixpkgs> {};

stdenv.mkDerivation rec {

  name = "astrochem-env";

  env = buildEnv { name = name; paths = buildInputs; };

  python2Env = python2.withPackages (ps: with ps; [ numpy h5py cython ]);

  sundials2 = stdenv.mkDerivation rec {
    pname = "sundials";
    version = "2.7.0";
    name = "${pname}-${version}";

    src = fetchurl {
      url = "https://computation.llnl.gov/projects/${pname}/download/${pname}-${version}.tar.gz";
      sha256 = "01513g0j7nr3rh7hqjld6mw0mcx5j9z9y87bwjc16w2x2z3wm7yk";
    };

    preConfigure = ''
      export cmakeFlags="-DCMAKE_INSTALL_PREFIX=$out -DEXAMPLES_INSTALL_PATH=$out/share/examples $cmakeFlags"
    '';

    buildInputs = [ cmake python ];
  };

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
