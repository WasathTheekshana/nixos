{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure.customRC = ''
      inoremap jk <Esc>
      set timeoutlen=300
    '';
  };
}
