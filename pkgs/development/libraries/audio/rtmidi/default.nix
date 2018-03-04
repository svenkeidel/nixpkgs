{ stdenv, fetchFromGitHub, autoconf, automake, libtool, libjack2, alsaLib, pkgconfig }:

stdenv.mkDerivation rec {
  version = "3.0.0";
  name = "rtmidi-${version}";

  src = fetchFromGitHub {
    owner = "thestk";
    repo = "rtmidi";
    rev = "v${version}";
    sha256 = "11pl45lp8sq5xkpipwk622w508nw0qcxr03ibicqn1lsws0hva96";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ autoconf automake libtool libjack2 alsaLib ];

  preConfigure = ''
    ./autogen.sh --no-configure
  '';

  configureFlags = [ "--with-alsa" "--with-jack" ];

  meta = {
    description = "A set of C++ classes that provide a cross platform API for realtime MIDI input/output";
    homepage =  http://www.music.mcgill.ca/~gary/rtmidi/;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.magnetophon ];
    platforms = with stdenv.lib.platforms; linux ++ darwin;
  };
}
