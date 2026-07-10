{ txmFlake }:
self: super: {
  txm = txmFlake.packages.${self.stdenv.hostPlatform.system}.default;
}
