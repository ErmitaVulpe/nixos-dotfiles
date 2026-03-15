{ fselFlake }:
self: super: {
  fsel = fselFlake.packages.${self.stdenv.hostPlatform.system}.default;
}
