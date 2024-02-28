{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = false;
    prefix = "C-a";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_current_text "#{b:pane_current_path}"
          set -g @catppuccin_status_modules_right "application session date_time"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
      sensible
      vim-tmux-navigator
      yank
    ];
    terminal = "tmux-256color";
    # extra config
    extraConfig = ''
      set-option -ga terminal-overrides ",*256col*:Tc"

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set-option -g renumber-windows on

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      unbind -n C-Left
      unbind -n C-Right

      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind v split-window -v -c "#{pane_current_path}"
      bind h split-window -h -c "#{pane_current_path}"
    '';
  };
}
