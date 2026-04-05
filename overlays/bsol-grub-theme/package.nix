{
  fetchFromGitHub,
  lib,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "bsol-grub-theme";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "harishnkr";
    repo = "bsol";
    rev = "v${finalAttrs.version}";
    hash = "sha256-sUvlue+AXW6VkVYy3WOUuSt548b6LoDpJmQPbgcZDQw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r bsol/* $out/

    runHook postInstall
  '';

  meta = {
    description = "grub2 blue-screen-of-life theme";
    homepage = "https://github.com/harishnkr/bsol";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ ErmitaVulpe ];
  };
})
