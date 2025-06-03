{ pkgs, ... }:

{
  home.file.".cargo/config.toml" = {
    text = ''
      [target.x86_64-unknown-linux-gnu]
      rustflags = ["-C", "link-arg=-fuse-ld=mold"]
    '';
  };
}
