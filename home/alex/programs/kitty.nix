{
  pkgs,
  vars,
  utils,
  isManagedByHomeManager,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  kittyBin = "${pkgs.kitty}/bin/kitty";
  addWrapper = isLinux && isManagedByHomeManager;
  kittyBinWrapped =
    if addWrapper
    then "${pkgs.nixgl.nixGLMesa}/bin/nixGLMesa ${kittyBin}"
    else kittyBin;
  icon = "${pkgs.kitty}/share/icons/hicolor/scalable/apps/kitty.svg";
in {
  # https://mipmip.github.io/home-manager-option-search/?query=kitty
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      # Show current fonts installed : kitty --debug-font-fallback
      name = vars.font.systemName;
      size = 9; #  9 - 12
    };
    settings = {
      hide_window_decorations =
        if isDarwin
        then "titlebar-only"
        else true;
      placement_strategy = "top-left";
      window_padding_width = "1 0 0";
      shell = "${pkgs.fish}/bin/fish";
    };
    # Use the name attribute from the json file to the theme key.
    # https://github.com/kovidgoyal/kitty-themes/blob/master/themes.json
    theme = "Solarized Dark Higher Contrast";
    extraConfig = let
      inherit (vars) colors;
    in ''
      background ${colors.background}
      cursor ${colors.cursor}
      background_opacity 0.95
      dynamic_background_opacity yes
    '';
  };

  home.shellAliases.kitty = kittyBinWrapped;
  home.sessionVariables.TERMINAL = "kitty";

  xdg.dataFile."applications/kitty.desktop" = {
    enable = addWrapper;
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=kitty
      GenericName=Terminal emulator
      Comment=Fast, feature-rich, GPU based terminal
      TryExec=${kittyBin}
      Exec=${kittyBinWrapped}
      Icon=${icon}
      Categories=System;TerminalEmulator;
    '';
  };
}
