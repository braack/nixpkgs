{ stdenv
, lib
, fetchFromGitHub
, cups
}:

stdenv.mkDerivation {
  pname = "epson-tm-t20-cups";
  version = "2017-10-07";

  src = fetchFromGitHub {
    owner = "jimibilibob";
    repo = "epson-tm-t20-cups";
    rev = "c632a39c4b043efd3eb8867a8e4db53a0219a723";
    hash = "sha256-/262durXSENSVQuhtH3Ixg4g8wH8AkfHjtCZgxmToSI=";
  };

  buildInputs = [
    cups
  ];

  nativeBuildInputs = [
    cups
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/cups/{filter,model}
    install -m 0644 $src/tm20.ppd $out/lib/cups/model/tm20.ppd
    install -m 0755 rastertozj $out/lib/cups/filter/rastertozj

    runHook postInstall
  '';

  meta = {
    description = "CUPS filter for thermal printer Epson TM-T20II";
    homepage = "https://github.com/nemik/epson-tm-t20-cups/tree/master";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ hexa ];
  };
}
