{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.wm.mango.widgets.eww;
  wm = "mango";

  loadedModules = map (module: import ./${module} { inherit config; }) cfg.modules;
  windowsToOpen = builtins.concatLists (map (x: x.windowsToOpen) loadedModules);

  concatConfigs =
    fileType:
    let
      extractors = type: [
        (m: m.${type}.prefix or null)
        (m: m.${type}.text or null)
        (m: lib.optional (m.${type}.source != null) (builtins.readFile m.${type}.source))
      ];
    in
    loadedModules
    |> builtins.filter (x: builtins.hasAttr fileType x)

    |> (mods: extractors fileType |> map (e: map (m: e m) mods |> lib.filter (x: x != null)))
    |> lib.flatten
    |> builtins.concatStringsSep "\n"
    |> pkgs.writeText "${wm}-eww.${fileType}";
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
