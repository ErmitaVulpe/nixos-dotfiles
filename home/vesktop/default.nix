{
  config,
  lib,
  ...
}:
{
  options.homeModules.vesktop = {
    enable = lib.mkEnableOption "vesktop";
  };

  config = lib.mkIf config.homeModules.vesktop.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        discordBranch = "ptb";
        tray = false;
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        arRPC = false;
        enableTaskbarFlashing = true;
        enableSplashScreen = true;
        splashTheming = true;
        spellCheckLanguages = [
          "en-US"
          "pl"
        ];
      };
      vencord = {
        settings = {
          frameless = true;
          plugins = {
            AccountPanelServerProfile = {
              enabled = true;
              prioritizeServerProfile = true;
            };
            AlwaysExpandRoles = {
              enabled = true;
            };
            AlwaysTrust = {
              enabled = true;
              domain = false;
              file = true;
            };
            BadgeAPI = {
              enabled = true;
            };
            BetterGifAltText = {
              enabled = true;
            };
            BetterGifPicker = {
              enabled = true;
            };
            BetterRoleContext = {
              enabled = true;
            };
            BetterSessions = {
              enabled = true;
              backgroundCheck = false;
              checkInterval = 20;
            };
            BetterSettings = {
              enabled = true;
              disableFade = true;
              organizeMenu = true;
              eagerLoad = true;
            };
            BetterUploadButton = {
              enabled = true;
            };
            BiggerStreamPreview = {
              enabled = true;
            };
            CallTimer = {
              enabled = true;
            };
            ClearURLs = {
              enabled = true;
            };
            CommandsAPI = {
              enabled = true;
            };
            CopyEmojiMarkdown = {
              enabled = true;
            };
            CopyFileContents = {
              enabled = true;
            };
            CopyStickerLinks = {
              enabled = true;
            };
            CrashHandler = {
              enabled = true;
            };
            CustomIdle = {
              enabled = true;
              idleTimeout = 10;
              remainInIdle = true;
            };
            DisableDeepLinks = {
              enabled = true;
            };
            DontRoundMyTimestamps = {
              enabled = true;
            };
            DynamicImageModalAPI = {
              enabled = true;
            };
            ExpressionCloner = {
              enabled = true;
            };
            FakeNitro = {
              enabled = true;
              enableEmojiBypass = true;
              emojiSize = 48;
              transformEmojis = true;
              enableStickerBypass = true;
              stickerSize = 160;
              transformStickers = true;
              transformCompoundSentence = false;
              enableStreamQualityBypass = true;
              useHyperLinks = true;
              hyperLinkText = "{{NAME}}";
              disableEmbedPermissionCheck = false;
            };
            FavoriteGifSearch = {
              enabled = true;
              searchOption = "hostandpath";
            };
            FixCodeblockGap = {
              enabled = true;
            };
            FixImagesQuality = {
              enabled = true;
              originalImagesInChat = false;
            };
            FixSpotifyEmbeds = {
              enabled = true;
              volume = 5;
            };
            FixYoutubeEmbeds = {
              enabled = true;
            };
            ForceOwnerCrown = {
              enabled = true;
            };
            FriendsSince = {
              enabled = true;
            };
            FullSearchContext = {
              enabled = true;
            };
            GifPaste = {
              enabled = true;
            };
            GreetStickerPicker = {
              enabled = true;
              greetMode = "Greet";
            };
            ImageFilename = {
              enabled = true;
              showFullUrl = true;
            };
            ImageLink = {
              enabled = true;
            };
            ImageZoom = {
              enabled = true;
            };
            ImplicitRelationships = {
              enabled = true;
              sortByAffinity = true;
            };
            IrcColors = {
              enabled = true;
              lightness = 70;
              memberListColors = true;
              applyColorOnlyToUsersWithoutColor = true;
              applyColorOnlyInDms = false;
            };
            MemberCount = {
              enabled = true;
              toolTip = true;
              memberList = true;
              voiceActivity = true;
            };
            MessageAccessoriesAPI = {
              enabled = true;
            };
            MessageEventsAPI = {
              enabled = true;
            };
            MessageLatency = {
              enabled = true;
              latency = 2;
              detectDiscordKotlin = false;
              showMillis = false;
              ignoreSelf = false;
            };
            MoreQuickReactions = {
              enabled = true;
              reactionCount = 5;
            };
            MutualGroupDMs = {
              enabled = true;
            };
            NewGuildSettings = {
              enabled = true;
              guild = true;
              messages = 3;
              everyone = false;
              role = false;
              highlights = true;
              events = true;
              showAllChannels = true;
            };
            NoOnboardingDelay = {
              enabled = true;
            };
            NoTrack = {
              enabled = true;
              disableAnalytics = true;
            };
            NoTypingAnimation = {
              enabled = true;
            };
            NoUnblockToJump = {
              enabled = true;
            };
            OpenInApp = {
              enabled = true;
              spotify = true;
              steam = true;
              epic = false;
              tidal = false;
              itunes = false;
            };
            PictureInPicture = {
              enabled = true;
              loop = false;
            };
            RelationshipNotifier = {
              enabled = true;
              notices = true;
              offlineRemovals = true;
              friends = true;
              friendRequestCancels = true;
              servers = true;
              groups = true;
            };
            ReverseImageSearch = {
              enabled = true;
            };
            RoleColorEverywhere = {
              enabled = true;
              chatMentions = true;
              memberList = true;
              voiceUsers = true;
              reactorsList = true;
              pollResults = true;
              colorChatMessages = true;
              messageSaturation = 30;
            };
            SecretRingToneEnabler = {
              enabled = true;
              onlySnow = false;
            };
            ServerInfo = {
              enabled = true;
            };
            Settings = {
              enabled = true;
              settingsLocation = "aboveNitro";
            };
            ShikiCodeblocks = {
              enabled = true;
              theme = "https://cdn.jsdelivr.net/gh/shikijs/textmate-grammars-themes@bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/github-dark.json";
              tryHljs = "SECONDARY";
              useDevIcon = "COLOR";
              bgOpacity = 100;
            };
            ShowConnections = {
              enabled = true;
              iconSize = 32;
              iconSpacing = 1;
            };
            ShowHiddenChannels = {
              enabled = true;
              hideUnreads = true;
              showMode = 0;
              defaultAllowedUsersAndRolesDropdownState = true;
            };
            ShowTimeoutDuration = {
              enabled = true;
              displayStyle = "ssalggnikool";
            };
            SortFriendRequests = {
              enabled = true;
              showDates = true;
            };
            SpotifyCrack = {
              enabled = true;
              noSpotifyAutoPause = true;
              keepSpotifyActivityOnIdle = true;
            };
            StickerPaste = {
              enabled = true;
            };
            SupportHelper = {
              enabled = true;
            };
            Unindent = {
              enabled = true;
            };
            UnlockedAvatarZoom = {
              enabled = true;
              zoomMultiplier = 4;
            };
            UnsuppressEmbeds = {
              enabled = true;
            };
            UserSettingsAPI = {
              enabled = true;
            };
            WebContextMenus = {
              enabled = true;
            };
            WebKeybinds = {
              enabled = true;
            };
            WebScreenShareFixes = {
              enabled = true;
            };
            YoutubeAdblock = {
              enabled = true;
            };
            iLoveSpam = {
              enabled = true;
            };
          };
        };
      };
    };
  };
}
