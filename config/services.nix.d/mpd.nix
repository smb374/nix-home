{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "mpd_cover_path" ''
      file="$(mpc status -f %file% | sed -n '1p')"
      parent="$(dirname "$HOME/Music/$file")"
      cover="$(fd -c never -t f -i '(folder|cover)\.(jpg|jpeg|png|tif|tiff|gif)' "$parent" | sed -n '1p' | tr -d '\n')"

      if [ -z "$cover" ]; then
          echo "$HOME/placeholder.png"
      else
          echo "$cover"
      fi
    '')
    pkgs.ncmpcpp
    pkgs.rmpc
  ];
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    network.listenAddress = "0.0.0.0";
    extraConfig = ''
      audio_output {
        type            "pipewire"
        name            "Topping E30"
        target          "alsa_output.usb-Topping_E30-00.HiFi__Headphones__sink"
        dsd             "yes"
      }

      audio_output {
        type            "pipewire"
        name            "Pipewire Server"
        enabled         "no"
      }

      decoder {
        plugin "dsdiff"
        enabled "yes"
      }

      decoder {
        plugin "dsf"
        enabled "yes"
      }
      decoder {
        plugin "ffmpeg"
        enabled "yes"
      }


      neighbors {
        plugin "udisks"
      }
    '';
  };
  services.mpdris2 = {
    enable = true;
    mpd = {
      host = "127.0.0.1";
      port = 6600;
    };
  };
}
