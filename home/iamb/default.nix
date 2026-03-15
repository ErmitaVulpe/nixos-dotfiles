{ ... }:
{
  programs.iamb = {
    enable = true;
    settings = {
      default_profile = "Zerda";
      profiles.ErmitaVulpe.user_id = "@ermitavulpe:matrix.org";
      profiles.Zerda.user_id = "@zerda:simplybush.pl";
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
