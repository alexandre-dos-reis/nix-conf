{
  imports = [
    ./apps.nix
    ./locale.nix
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

}
