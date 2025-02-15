{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
  };
  xdg.desktopEntries.vscode = {
    name = "VS Code";
    genericName = "Text Editor";
    exec = "${pkgs.vscode}/bin/code --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto %F";
    icon = "vscode";
    type = "Application";
    categories = [
      "Utility"
      "TextEditor"
      "Development"
      "IDE"
    ];
    actions = {
      "new-empty-window" = {
        name = "New Empty Window";
        exec = "${pkgs.vscode}/bin/code --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --new-window %F";
        icon = "vscode";
      };
    };
  };
}
