{ pkgs, ... }:

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
  ];
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-iris
      mopidy-local
      mopidy-mpd
      mopidy-mpris
      mopidy-muse
      mopidy-notify
    ];
    settings = {
      audio = {
        output = "pipewiresink";
      };
      file = {
        media_dirs = [
          "~/Music"
        ];
        follow_symlinks = true;
        excluded_file_extensions = [
          ".html"
          ".zip"
          ".jpg"
          ".jpeg"
          ".png"
          ".tif"
          ".tiff"
          ".log"
        ];
      };
      http = {
        port = 6689;
      };
      local = {
        media_dir = "~/Music";
        scan_follow_symlinks = true;
        excluded_file_extensions = [
          ".html"
          ".zip"
          ".jpg"
          ".jpeg"
          ".png"
        ];
        album_art_files = [
          "cover.png"
          "cover.jpg"
          "folder.png"
          "folder.jpg"
        ];
      };
      mpd = {
        enabled = true;
        hostname = "::";
        port = 6600;
      };
      muse = {
        enabled = true;
      };
    };
  };
}
