{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        scrolloff = 4;
        lsp.display-inlay-hints = true;
      };
    };
  };
}
