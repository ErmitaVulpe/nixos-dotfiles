{
  fetchFromGitHub,
  lib,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "polishcow-plymouth-theme";
  version = "0-unstable-2026-04-06";

  src = fetchFromGitHub {
    owner = "berceni74";
    repo = "plymouth-polishcow";
    rev = "db9cfa71382fbf3cfe5aca8681a4b46353239356";
    hash = "sha256-jrLtjWNu+MYIStNJcK5pSXB0I1nWmwW/m8C1kL72fhw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plymouth/themes/polishcow
    mv polishcow.script images $out/share/plymouth/themes/polishcow/
    sed "s@/usr/@$out/@" polishcow.plymouth > $out/share/plymouth/themes/polishcow/polishcow.plymouth

    runHook postInstall
  '';

  meta = {
    description = "Plymouth theme with the animated polish cow";
    homepage = "https://github.com/berceni74/plymouth-polishcow";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ ErmitaVulpe ];
  };
})
