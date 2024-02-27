{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      "default-release" = {
        id = 0;
        userChrome = builtins.readFile ./sources/userChrome.css;
      };
    };
  };
}
