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
        `~/.config/base16-shell`, the path
        `dotfiles/oh-my-zsh/custom/settings.zsh` sources. Null leaves that
        path alone.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # install.sh's apt line, less the packages home-manager brings itself
    # (zsh comes with programs.zsh, vim with programs.vim).
    home.packages = with pkgs; [
      curl
      delta
      direnv
      fzf
      git
      ripgrep
      tmux
      unzip
      zip
    ] ++ lib.optionals cfg.desktop.enable [
      emacs
      inconsolata
    ];

    fonts.fontconfig.enable = lib.mkIf cfg.desktop.enable true;

    home.file = {
      ".vimrc".source = ./dotfiles/vimrc;
      ".ideavimrc".source = ./dotfiles/ideavimrc;
      ".tmux.conf".source = ./dotfiles/tmux.conf;
      ".gitconfig".source = ./dotfiles/gitconfig;
      ".config/jj/config.toml".source = ./dotfiles/config/jj/config.toml;
      ".config/nvim/init.lua".source = ./dotfiles/config/nvim/init.lua;
    } // lib.optionalAttrs (cfg.base16Shell != null) {
      ".config/base16-shell".source = cfg.base16Shell;
    } // lib.optionalAttrs cfg.desktop.enable {
      # File by file, not directory by directory: emacs writes `custom.el` and
      # its own runtime files into ~/.config/emacs, and VSCode writes settings
      # into ~/.config/Code/User, and neither can do that under a read-only
      # store symlink. `early-init.el` sends the two big trees straight.el
      # would otherwise put there to ~/.local/state and ~/.cache.
      #
      # ~/.config/emacs, not ~/.emacs.d: emacs prefers ~/.emacs.d whenever it
      # exists, so a stray one shadows everything linked here.
      ".config/emacs/early-init.el".source = ./dotfiles/config/emacs/early-init.el;
      ".config/emacs/init.el".source = ./dotfiles/config/emacs/init.el;
      ".config/Code/User/keybindings.json".source = ./dotfiles/config/VSCode/keybindings.json;
    };

    # vim: the wrapper and the plugin set, beside the `vimrc` that asks for
    # them. `packageConfigurable` is the terminal build rather than the
    # default `vim-full`, whose GUI closure a headless machine has no use for.
    #
    # THE PLUGINS ARE DECLARED HERE, not read from `vimrc`: nix cannot see
    # inside a vimscript file, and `vimPlugins` normalizes an upstream name
    # (`rust.vim` is `rust-vim`). home-manager adds `vim-sensible` to whatever
    # this list holds, as the baseline `vimrc`'s own settings win over.
    #
    # `vimrc` IS STILL READ, and `extraConfig` is what reads it. The module
    # wraps the binary as `vim -u <generated vimrc>`, and `-u` makes vim skip
    # the account's own file, so the generated one sources it back.
    # `packloadall` goes first because these plugins arrive through vim's
    # package mechanism, which vim applies AFTER the vimrc, while `vimrc` runs
    # `colorscheme base16-chalk` during it.
    #
    # nixpkgs' vim plugin updater stamps `meta.license = unfree` on every
    # plugin whose licence it could not detect - base16-vim and vim-go among
    # them - so a consumer of this module needs `nixpkgs.config.allowUnfree`.
    programs.vim = {
      enable = true;
      packageConfigurable = pkgs.vim;
      plugins = with pkgs.vimPlugins; [
        base16-vim
        rust-vim
        vim-go
      ];
      extraConfig = ''
        packloadall
        if filereadable(expand('~/.vimrc'))
          source ~/.vimrc
        endif
      '';
    };

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "jimpo";
        plugins = [ "git" "jj" "vi-mode" "fzf" "docker" ];
        custom = "${./dotfiles/oh-my-zsh/custom}";
      };
    };
  };
}
