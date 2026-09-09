# The host's own home-manager configuration.
#
#   home-manager switch -f ~/configenv/home.nix
#
# or symlink this to ~/.config/home-manager/home.nix and run `home-manager
# switch` with no arguments. The account and its home directory come from the
# environment, so this file is the same on every machine.
{ config, pkgs, ... }:

{
  imports = [ ./default.nix ];

  configenv.desktop.enable = true;

  # nixpkgs' vim plugin updater stamps `meta.license = unfree` on every plugin
  # whose licence it could not detect - base16-vim and vim-go among them - so
  # the module's vim does not evaluate without this.
  nixpkgs.config.allowUnfree = true;

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

