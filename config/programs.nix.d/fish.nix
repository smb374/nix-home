{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "hydro";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "41b46a05c84a15fe391b9d43ecb71c7a243b5703";
          hash = "sha256-zmEa/GJ9jtjzeyJUWVNSz/wYrU2FtqhcHdgxzi6ANHg=";
        };
      }
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev  = "8920367cf85eee5218cc25a11e209d46e2591e7a";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];
    shellInit = ''
      # gpg tty setting
      if [ "$GPG_TTY" != (tty | string collect; or echo) ]
          set GPG_TTY (tty | string collect; or echo)
          set -gx GPG_TTY $GPG_TTY
          gpg-connect-agent updatestartuptty /bye >/dev/null
      end
      # gpg ssh agent
      gpg-connect-agent /bye
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      # hydro prompt
      set -g hydro_symbol_prompt ">"
      set -g hydro_color_pwd $fish_color_cwd
      set -g hydro_color_git $fish_color_quote
      set -g hydro_color_prompt $fish_color_normal
      set -g hydro_color_duration $fish_color_user
      # zoxide integration
      zoxide init fish | source
    '';
  };
}
