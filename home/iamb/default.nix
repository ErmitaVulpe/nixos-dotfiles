{ ... }:
{
  programs.iamb = {
    enable = true;
    settings = {
      default_profile = "ErmitaVulpe";
      profiles.ErmitaVulpe.user_id = "@ermitavulpe:matrix.org";
      settings = {
        notifications.enabled = true;
        image_preview.protocol = {
          type = "sixel";
          size = {
            height = 10;
            width = 66;
          };
        };
      };
    };
  };
}
