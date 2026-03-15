{ fselFlake }:
self: super: {
  fsel = fselFlake.packages.${self.system}.default;
}
