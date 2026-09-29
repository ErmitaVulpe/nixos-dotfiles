{ ... }: {
  windowsToOpen = [ "activate-linux" ];
  scss = builtins.readFile ./eww.scss;
  yuck = builtins.readFile ./eww.yuck;
}
