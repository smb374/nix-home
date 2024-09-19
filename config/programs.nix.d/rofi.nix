{ pkgs, ... }:

let
  rofi_root = "$HOME/.config/rofi";
  powermenu = pkgs.writeScriptBin "rofi-powermenu" ''
    rofi_command="rofi -theme ${rofi_root}/powermenu.rasi"

    uptime=$(uptime -p | sed -e 's/up //g')

    # Options
    shutdown='󰤆'
    reboot='󰜉'
    lock='󰌾'
    suspend='󰤄'
    logout='󰗼'
    yes='󰗠'
    no='󰅙'

    # Confirmation CMD
    confirm_cmd() {
        rofi -dmenu \
            -p 'Confirmation' \
            -mesg 'Are you Sure?' \
            -theme "${rofi_root}/confirm.rasi"
    }

    # Ask for confirmation
    confirm_exit() {
        echo -e "$yes\n$no" | confirm_cmd
    }

    # Variable passed to rofi
    options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

    chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 0)"
    case $chosen in
    "$shutdown")
        ans=$(confirm_exit)
        if [[ "$ans" == "$yes" ]]; then
            systemctl poweroff
        else
            exit
        fi
        ;;
    "$reboot")
        ans=$(confirm_exit)
        if [[ "$ans" == "$yes" ]]; then
            systemctl reboot
        else
            exit
        fi
        ;;
    "$lock")
        swaylock-fancy
        ;;
    "$suspend")
        ans=$(confirm_exit)
        if [[ "$ans" == "$yes" ]]; then
            mpc -q pause
            loginctl lock-session
            systemctl suspend
        else
            exit
        fi
        ;;
    "$logout")
        ans=$(confirm_exit)
        if [[ "$ans" == "$yes" ]]; then
            hyprctl dispatch exit
        else
            exit
        fi
        ;;
    esac
  '';
  launcher = pkgs.writeScriptBin "rofi-launcher" ''
    rofi -config "${rofi_root}/launcher.rasi" -show "$1"
  '';
  clipboard = pkgs.writeScriptBin "rofi-clipboard" ''
    cliphist list | rofi -theme $ROFI_ROOT/clipboard-theme.rasi -dmenu -p "Clipboard" | cliphist decode | wl-copy
  '';
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  home.packages = [
    launcher
    powermenu
    clipboard
  ];
}
