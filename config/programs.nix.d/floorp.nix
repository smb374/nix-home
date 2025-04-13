{ pkgs, ... }:

{
  programs.floorp = {
    enable = true;
    nativeMessagingHosts = with pkgs; [ uget-integrator ];
  };
}
