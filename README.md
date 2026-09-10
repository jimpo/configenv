Jim's Preferred Linux Configuration
===================================

To install global packages, run with root access:
```
$ sudo ./install.sh
```

To add configurations, run as user:
```
$ ./setup.sh
```

home-manager
------------

`default.nix` is a [home-manager](https://github.com/nix-community/home-manager)
module. It links the same files `setup.sh` copies, and it installs the
command-line tools and configures vim and zsh. Import it from your own
`home.nix`:
```nix
{ config, pkgs, ... }:

{
  imports = [ /path/to/configenv ];

  configenv.desktop.enable = true;

  # Required: nixpkgs stamps some of the vim plugins unfree.
  nixpkgs.config.allowUnfree = true;

  # Required: the module sets none of these.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "26.05";

  # Recommended for a standalone install: keeps the home-manager command in
  # the profile, because each generation replaces `home.packages`.
  programs.home-manager.enable = true;
}
```

To check the configuration without switching to it, run `home-manager build`.
Add `-f path/to/home.nix` if the importing `home.nix` is not at
`~/.config/home-manager/home.nix`.

### Options

| Option | Type | Default | Description |
|---|---|---|---|
| `configenv.enable` | bool | `true` | Whether to install the configuration files. It is an option, not a conditional import, because `imports` cannot sit inside `mkIf`. |
| `configenv.desktop.enable` | bool | `false` | Whether to add the primary desktop environment on top of the shared configs: emacs, Inconsolata, the emacs and VSCode configs, the base16-shell palette, and the `.rsync-filter` for backups. Leave it off on a machine that only wants the shared configs, such as a build box or a dev VM. |

