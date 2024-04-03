{inputs, vars, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = "${vars.homeDirectory}/dev/nvim";
    recursive = true;
  };
}
