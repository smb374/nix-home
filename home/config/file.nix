{ pkgs, ... }:

{
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".editorconfig".source = ./sources/editorconfig;
    ".gdbinit-gef.py".source = pkgs.fetchurl {
      url = "https://gef.blah.cat/py";
      hash = "sha256-TBmPJ3rzsC175YdckXmGgscTUvs5fO8bFdDll+Lotmk=";
    };
    ".gdbinit".text = ''
      source ~/.gdbinit-gef.py
    '';
  };
}
