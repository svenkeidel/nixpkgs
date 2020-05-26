{ stdenv, fetchFromGitHub, autoreconfHook, curl, texlive }:

let tex = texlive.combined.scheme-small;
in stdenv.mkDerivation rec {
  pname = "dblpbibtex";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "cr-marcstevens";
    repo = "dblpbibtex";
    rev = "refs/tags/v${version}";
    sha256 = "0vbp1jkizkwwm9kkrr21ksc6fnyv5f5sw6vgdyi8dyz1cm1nplyl";
  };

  prePatch = ''
    substituteInPlace src/dblpbibtex.cpp \
      --replace 'BIBTEX = "bibtex";' \
                'BIBTEX = "${tex}/bin/bibtex";'
  '';

  buildInputs = [ autoreconfHook curl ];

  meta = with stdenv.lib; {
    description = "Bibtex wrapper for automatic DBLP & IACR ePrint downloads";
    homepage = "https://github.com/cr-marcstevens/dblpbibtex/";
    license = licenses.boost;
    maintainers = with maintainers; [ skeidel ];
  };
}
