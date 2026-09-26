{ lib, pkgs, ... }: {
  options.homeModules.bar.eww = lib.mkOption {
    description = "Function to generate a preconfigured eww bar derivation";
    readOnly = true;
    type = lib.types.functionTo lib.types.attrs;
    default =
      {
        wm,
        modules ? [ "activate-linux" ],
      }:
      let
        loadedModules = map (module: import ./${module}) modules;
        windowsToOpen = builtins.concatLists (map (x: x.windowsToOpen) loadedModules);

        concatConfigs =
          fileType:
          pkgs.writeText "${wm}-eww.${fileType}" (
            builtins.concatStringsSep "\n" (map (x: x.${fileType}) loadedModules)
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
          '';
        };
      in
      {
        pkg = ewwPkg;
        start =
          let
            startScript = pkgs.writeShellScriptBin "${wm}-eww-start" ''
              eww daemon
              eww open-many ${builtins.concatStringsSep " " windowsToOpen}
            '';
          in
          "${startScript}/bin/${wm}-eww-start";
      };
  };
}
