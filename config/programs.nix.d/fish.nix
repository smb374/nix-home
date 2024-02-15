{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    plugins = [{
      name = "hydro";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "hydro";
        rev = "41b46a05c84a15fe391b9d43ecb71c7a243b5703";
        hash = "sha256-zmEa/GJ9jtjzeyJUWVNSz/wYrU2FtqhcHdgxzi6ANHg=";
      };
    }];
    shellInit = ''
      if [ "$GPG_TTY" != (tty | string collect; or echo) ]
          set GPG_TTY (tty | string collect; or echo)
          set -gx GPG_TTY $GPG_TTY
          gpg-connect-agent updatestartuptty /bye >/dev/null
      end
      # hydro prompt
      set -g hydro_symbol_prompt ">"
      set -g hydro_color_pwd $fish_color_cwd
      set -g hydro_color_git $fish_color_quote
      set -g hydro_color_prompt $fish_color_normal
      set -g hydro_color_duration $fish_color_user
    '';
  };
}
