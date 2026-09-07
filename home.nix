# The host's own home-manager configuration.
#
#   home-manager switch -f ~/configenv/home.nix
#
# or symlink this to ~/.config/home-manager/home.nix and run `home-manager
# switch` with no arguments. The account and its home directory come from the
# environment, so this file is the same on every machine.
{ ... }:

{
  imports = [ ./default.nix ];

  configenv.desktop.enable = true;

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";
}
