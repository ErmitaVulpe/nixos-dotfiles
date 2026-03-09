self: super: {
  hyfetch = super.hyfetch.overrideAttrs {
    patches = [
      ./create_nixowos_logo.patch
    ];
  };
}
