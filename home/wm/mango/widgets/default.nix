{
  pkgs,
  config,
  ...
}:
let
  cfg = config.homeModules.wm.mango.widgets.eww;
  wm = "mango";

  loadedModules = map (module: import ./${module} { inherit config; }) cfg.modules;
  windowsToOpen = builtins.concatLists (map (x: x.windowsToOpen) loadedModules);

  concatConfigs =
    fileType:
    pkgs.writeText "${wm}-eww.${fileType}" (
      builtins.concatStringsSep "\n" (
        map (x: x.${fileType}) (builtins.filter (x: builtins.hasAttr fileType x) loadedModules)
      )
    );
  yuckConfig = concatConfigs "yuck";
  scssConfig = concatConfigs "scss";

  ewwPkg = pkgs.symlinkJoin {
    name = "${wm}-eww";
    buildInputs = with pkgs; [ makeWrapper ];
    paths = with pkgs; [
      eww
      (pkgs.linkFarm "${wm}-eww-config" [
        {
          name = "config/eww.yuck";
          path = yuckConfig;
        }
        {
          name = "config/eww.scss";
          path = scssConfig;
        }
      ])
    ];
    postBuild = ''
      wrapProgram $out/bin/eww \
        --append-flags "-c $out/config";
      mv $out/bin/eww $out/bin/${wm}-eww;
    '';
  };
in
{
  config.homeModules.wm.mango.widgets.eww = {
    package = ewwPkg;
    start = pkgs.writeShellScript "${wm}-eww-start" ''
      ${cfg.package}/bin/${wm}-eww daemon
      ${cfg.package}/bin/${wm}-eww open-many ${builtins.concatStringsSep " " windowsToOpen}
    '';
  };
}
