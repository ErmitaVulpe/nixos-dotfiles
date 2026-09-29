{ ... }: {
  windowsToOpen = [ "bar-powerline" ];
  scss = builtins.readFile ./eww.scss;
  yuck = builtins.readFile ./eww.yuck;
}
