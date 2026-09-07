# Jim's configuration files as a home-manager module. The same files
# `setup.sh` copies, linked into place instead.
#
# Self-contained: `imports = [ ./configenv ]` needs nothing wired. It sets no
# `home.username`, `home.homeDirectory` or `home.stateVersion` — those belong
# to whoever imports it. See `home.nix` for the host's own entry point.
{ config, lib, pkgs, ... }:

let
  cfg = config.configenv;
in
{
  options.configenv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install Jim's configuration files. An option rather than a
        conditional import, because `imports` cannot sit inside `mkIf`.
      '';
    };

    desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to add the editors and fonts a workstation wants on top of the
        shared configs: emacs, Inconsolata, and the VSCode keybindings.
      '';
    };

    base16Shell = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      defaultText = lib.literalExpression "pkgs.fetchFromGitHub { ... }";
      default = pkgs.fetchFromGitHub {
        owner = "chriskempson";
        repo = "base16-shell";
        rev = "588691ba71b47e75793ed9edfcfaa058326a6f41";
        hash = "sha256-X89FsG9QICDw3jZvOCB/KsPBVOLUeE7xN3VCtf0DD3E=";
      };
      description = ''
        Source of chriskempson/base16-shell, linked to
        `~/.config/base16-shell`, the path `oh-my-zsh/custom/settings.zsh`
        sources. Null leaves that path alone.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # install.sh's apt line, less the packages home-manager brings itself
    # (zsh comes with programs.zsh).
    home.packages = with pkgs; [
      curl
      delta
      direnv
      fzf
      git
      ripgrep
      tmux
      unzip
      vim
      zip
    ] ++ lib.optionals cfg.desktop.enable [
      emacs
      inconsolata
    ];

    fonts.fontconfig.enable = lib.mkIf cfg.desktop.enable true;

    home.file = {
      ".vimrc".source = ./vimrc;
      ".ideavimrc".source = ./ideavimrc;
      ".tmux.conf".source = ./tmux.conf;
      ".gitconfig".source = ./gitconfig;
      ".config/jj/config.toml".source = ./jj/config.toml;
      ".config/nvim".source = ./nvim;
    } // lib.optionalAttrs (cfg.base16Shell != null) {
      ".config/base16-shell".source = cfg.base16Shell;
    } // lib.optionalAttrs cfg.desktop.enable {
      # File by file, not directory by directory: emacs writes package trees
      # into ~/.emacs.d and VSCode writes settings into ~/.config/Code/User,
      # and neither can do that under a read-only store symlink.
      ".emacs.d/early-init.el".source = ./emacs.d/early-init.el;
      ".emacs.d/init.el".source = ./emacs.d/init.el;
      ".emacs.d/custom.el".source = ./emacs.d/custom.el;
      ".config/Code/User/keybindings.json".source = ./VSCode/keybindings.json;
    };

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "jimpo";
        plugins = [ "git" "jj" "vi-mode" "fzf" "docker" ];
        custom = "${./oh-my-zsh/custom}";
      };
    };
  };
}
