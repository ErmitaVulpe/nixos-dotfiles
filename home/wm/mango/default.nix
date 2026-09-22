{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.wm.mango = {
    enable = lib.mkEnableOption "mango config";
  };

  imports = [
    inputs.mangowm.hmModules.mango
  ];

  config = lib.mkIf config.homeModules.wm.mango.enable {
    homeModules = {
      launcher.otter-launcher.enable = true;
      terminal.foot.enable = true;
    };

    home.packages = with pkgs; [
      swayidle
      swaylock
    ];

    wayland.windowManager.mango = {
      enable = true;
      settings = {
        # Keyboard Settings
        repeat_rate = 40;
        repeat_delay = 300;
        xkb_rules_layout = "pl";

        # Trackpad
        # need relogin to make it apply
        tap_to_click = 1;
        tap_and_drag = 1;
        trackpad_accel_speed = -0.2;
        trackpad_click_method = 2;
        drag_lock = 1;
        trackpad_natural_scrolling = 1;
        trackpad_scroll_factor = 0.6;

        animations = 0;

        # Appearance
        borderpx = 2;
        gappih = 0;
        gappiv = 0;
        gappoh = 0;
        gappov = 0;

        scratchpad_width_ratio = 0.8;
        scratchpad_height_ratio = 0.9;
        rootcolor = "0x201b14ff";
        bordercolor = "0x444444ff";
        dropcolor = "0x8FBA7C55";
        splitcolor = "0xEB441EFF";
        focuscolor = "0xc9b890ff";
        maximizescreencolor = "0x89aa61ff";
        urgentcolor = "0xad401fff";
        scratchpadcolor = "0x516c93ff";
        globalcolor = "0xb153a7ff";
        overlaycolor = "0x14a57cff";

        bind = [
          "super,r,reload_config"
          "super,m,quit"
          "alt,q,killclient"

          # menu and terminal
          "alt,space,spawn_shell,mmsg get all-clients | jq -e 'any(.[] | .appid == \"otter-launcher\")' > /dev/null || foot -W 58x9 --app-id=otter-launcher otter-launcher"
          "alt,Return,spawn,foot"

          "super,1,view,1,0"
          "super,2,view,2,0"
          "super,3,view,3,0"
          "super,4,view,4,0"
          "super,5,view,5,0"
          "super,6,view,6,0"
          "super,7,view,7,0"
          "super,8,view,8,0"
          "super,9,view,9,0"

          # tag: move client to the tag and focus it
          # tagsilent: move client to the tag and not focus it
          "alt,1,tag,1,0"
          "alt,2,tag,2,0"
          "alt,3,tag,3,0"
          "alt,4,tag,4,0"
          "alt,5,tag,5,0"
          "alt,6,tag,6,0"
          "alt,7,tag,7,0"
          "alt,8,tag,8,0"
          "alt,9,tag,9,0"
        ];

        # Misc
        no_border_when_single = 1;
        focus_on_activate = 1;
        idleinhibit_ignore_visible = 0;
        idleinhibit_when_fullscreen = 0;
        enable_floating_snap = 1;
        snap_distance = 30;
        # cursor_size = 24;
        drag_tile_to_tile = 1;
        drag_tile_small = 1;

        windowrule = [
          "appid:otter-launcher,isfloating:1,isoverlay:1"
        ];

        gesturebind = [
          "none,left,3,focusdir,left"
          "none,right,3,focusdir,right"
          "none,up,3,focusdir,up"
          "none,down,3,focusdir,down"
          "none,right,4,viewprev_have_client"
          "none,left,4,viewnext_have_client"
          "none,up,4,enteroverview"
          "none,down,4,leaveoverview"
        ];
      };
      extraConfig = ''
        # Scroller Layout Setting
        scroller_structs=20
        scroller_default_proportion=0.8
        scroller_focus_center=0
        scroller_prefer_center=0
        edge_scroller_pointer_focus=1
        edge_scroller_focus_allow_speed=0.0
        scroller_default_proportion_single=1.0
        scroller_proportion_preset=0.5,0.8,1.0

        # Master-Stack Layout Setting
        new_is_master=1
        default_mfact=0.55
        default_nmaster=1
        tag_num=9
        smartgaps=0

        # Dwindle Layout Setting
        dwindle_smart_split=0
        dwindle_drop_simple_split=1
        dwindle_manual_split=0
        dwindle_hsplit=1
        dwindle_vsplit=1
        dwindle_preserve_split=0

        # Overview Setting
        hotarea_size=10
        enable_hotarea=0
        hotarea_disable_on_fullscreen=1
        overviewgappi=5
        overviewgappo=30
        overcircle_center_ratio=0.5

        # mouse
        # need relogin to make it apply
        mouse_natural_scrolling=0

        # layout support:
        # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
        tagrule=id:1,layout_name:tile
        tagrule=id:2,layout_name:tile
        tagrule=id:3,layout_name:tile
        tagrule=id:4,layout_name:tile
        tagrule=id:5,layout_name:tile
        tagrule=id:6,layout_name:tile
        tagrule=id:7,layout_name:tile
        tagrule=id:8,layout_name:tile
        tagrule=id:9,layout_name:tile

        # switch window focus
        bind=SUPER,Tab,focusstack,next
        bind=ALT,Left,focusdir,left
        bind=ALT,Right,focusdir,right
        bind=ALT,Up,focusdir,up
        bind=ALT,Down,focusdir,down

        # swap window
        bind=SUPER+SHIFT,Up,exchange_client,up
        bind=SUPER+SHIFT,Down,exchange_client,down
        bind=SUPER+SHIFT,Left,exchange_client,left
        bind=SUPER+SHIFT,Right,exchange_client,right

        # switch window status
        bind=SUPER,g,toggleglobal,
        bind=ALT,Tab,togglejump,
        bind=ALT,backslash,togglefloating,
        bind=ALT,a,togglemaximizescreen,
        bind=ALT,f,togglefullscreen,
        bind=ALT+SHIFT,f,togglefakefullscreen,
        bind=SUPER,i,minimized,
        bind=SUPER,o,toggleoverlay,
        bind=SUPER+SHIFT,I,restore_minimized
        bind=ALT,z,toggle_scratchpad

        # scroller layout
        # bind=ALT,e,set_proportion,1.0
        bind=ALT,x,switch_proportion_preset,
        bind=alt+super+ctrl,Left,scroller_stack,left
        bind=alt+super+ctrl,Right,scroller_stack,right
        bind=alt+super+ctrl,Up,scroller_stack,up
        bind=alt+super+ctrl,Down,scroller_stack,down

        #dwindle layout(manual split mode)
        bind=alt+shift,Return,dwindle_toggle_split_direction

        # switch layout
        bind=SUPER,n,switch_layout

        # monitor switch
        bind=alt+shift,Left,focusmon,left
        bind=alt+shift,Right,focusmon,right
        bind=SUPER+Alt,Left,tagmon,left
        bind=SUPER+Alt,Right,tagmon,right

        # movewin
        bind=CTRL+SHIFT,Up,movewin,+0,-50
        bind=CTRL+SHIFT,Down,movewin,+0,+50
        bind=CTRL+SHIFT,Left,movewin,-50,+0
        bind=CTRL+SHIFT,Right,movewin,+50,+0

        # resizewin
        bind=CTRL+ALT,Up,resizewin,+0,-50
        bind=CTRL+ALT,Down,resizewin,+0,+50
        bind=CTRL+ALT,Left,resizewin,-50,+0
        bind=CTRL+ALT,Right,resizewin,+50,+0

        # Mouse Button Bindings
        # btn_left and btn_right can't bind none mod key
        mousebind=SUPER,btn_left,moveresize,curmove
        # mousebind=NONE,btn_middle,togglemaximizescreen,0
        mousebind=SUPER,btn_right,moveresize,curresize


        # Axis Bindings
        axisbind=SUPER,UP,viewtoleft_have_client
        axisbind=SUPER,DOWN,viewtoright_have_client
      '';
    };
    # xdg.configFile."swaylock/config".source = ./swaylock.conf;
    # home.file.".local/bin/nws.sh".source = ./nws.sh;
  };
}
