{ ... }:

{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    publicKeys = [
      {
        source = ../sources/gpg/pub-0x0A507FC2325D77EA.gpg;
        trust = "ultimate";
      }
    ];
    settings = {
      armor = true;
      no-greeting = true;
      throw-keyids = true;
    };
  };
}
