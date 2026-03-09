self: super: {
  fastfetch = super.fastfetch.overrideAttrs {
    patches = [
      ./create_nixowos_logo.patch
    ];
  };
}
