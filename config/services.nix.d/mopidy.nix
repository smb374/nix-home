{ pkgs, ... }:

{
  home.packages = [ pkgs.mopidy ];
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-iris
      mopidy-local
      mopidy-mpd
      mopidy-mpris
      mopidy-muse
      mopidy-notify
      mopidy-tidal
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
        port = 6601;
      };
      muse = {
        enabled = true;
      };
      tidal = {
        enabled = true;
        quality = "HI_RES_LOSSLESS";
      };
    };
  };
}
