{ stdenv, fetchFromGitHub, unzip, cmake, openexr, hdf5-threadsafe }:

stdenv.mkDerivation rec
{
  name = "alembic-${version}";
  version = "1.7.9";

  src = fetchFromGitHub {
    owner = "alembic";
    repo = "alembic";
    rev = "${version}";
    sha256 = "0xyclln1m4079akr31vib242912004lln678prda0qwmwvsdrf7z";
  };

  outputs = [ "bin" "dev" "out" "lib" ];

  nativeBuildInputs = [ unzip cmake ];
  buildInputs = [ openexr hdf5-threadsafe ];

  enableParallelBuilding = true;

  buildPhase = ''
    cmake -DUSE_HDF5=ON -DCMAKE_INSTALL_PREFIX=$out/ -DUSE_TESTS=OFF .

    mkdir $out
    mkdir -p $bin/bin
    mkdir -p $dev/include
    mkdir -p $lib/lib
  '';

  installPhase = ''
    make install

    mv $out/bin $bin/
    mv $out/lib $lib/
    mv $out/include $dev/
  '';

  meta = with stdenv.lib; {
    description = "An open framework for storing and sharing scene data";
    homepage = "http://alembic.io/";
    license = licenses.bsd3;
    platforms = platforms.all;
    maintainers = [ maintainers.guibou ];
  };
}
