{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  mkExtensionEntry =
    {
      id,
      pinned ? true,
    }:
    let
      base = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
        installation_mode = "force_installed";
      };
    in
    if pinned then base // { default_area = "navbar"; } else base;
  mkExtensionSettings = builtins.mapAttrs (
    _: entry:
    if builtins.isAttrs entry then
      entry
    else
      mkExtensionEntry {
        id = entry;
        pinned = false;
      }
  );
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight-official
  ];

  options.homeModules.browser.zen-browser = {
    enable = lib.mkEnableOption "zen browser";
  };

  config = lib.mkIf config.homeModules.browser.zen-browser.enable {
    home.file.".config/tridactyl/tridactylrc".source = ./tridactylrc;
    programs.zen-browser = {
      enable = true;
      languagePacks = [ "pl" ];
      nativeMessagingHosts = with pkgs; [ tridactyl-native ];
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Cryptomining = true;
          Fingerprinting = true;
          Locked = true;
          Value = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "@searchengineadremover" = "searchengineadremover";
          "addon@darkreader.org" = mkExtensionEntry { id = "darkreader"; };
          "github-no-more@ihatereality.space" = "github-no-more";
          "github-repository-size@pranavmangal" = "gh-repo-size";
          "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
          "microslop@4o4" = "microslop";
          "shinigamieyes@shinigamieyes" = "shinigami-eyes";
          "trackmenot@mrl.nyu.edu" = "trackmenot";
          "tridactyl.vim@cmcaine.co.uk" = "tridactyl-vim";
          "uBlock0@raymondhill.net" = mkExtensionEntry { id = "ublock-origin"; };
          "wappalyzer@crunchlabz.com" = mkExtensionEntry { id = "wappalyzer"; };
          "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = "chameleon-ext";
          "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github-";
        };
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
      };
      profiles.default = {
        mods = [
          "03a8e7ef-cf00-4f41-bf24-a90deeafc9db"
        ];
        settings = {
          "browser.translations.neverTranslateLanguages" = "pl";
          "devtools.toolbox.host" = "right";
          "findbar.highlightAll" = true;

          # Block new requests asking to access your X
          "permissions.default.camera" = 2;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;

          "zen.view.use-single-toolbar" = false;
          "zen.workspaces.separate-essentials" = false;
        };
      };
    };
    xdg.mimeApps = {
      associations = {
        added = {
          "x-scheme-handler/http" = "zen.desktop";
          "x-scheme-handler/https" = "zen.desktop";
        };
      };
    };
  };
}
