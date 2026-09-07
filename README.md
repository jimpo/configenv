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

Or, with [home-manager](https://github.com/nix-community/home-manager):
```
$ home-manager switch -f home.nix
```

`default.nix` is the same configuration as an importable module, for anything
that wants these files without the rest of `home.nix`:
```nix
imports = [ /path/to/configenv ];
configenv.desktop.enable = true;   # editors and fonts; off by default
```

To check the configuration without building it:
```
$ nix-instantiate '<home-manager/home-manager.nix>' \
    --argstr confPath "$PWD/home.nix" -A activationPackage
```
