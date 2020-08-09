(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(coq-compile-before-require t)
 '(custom-safe-themes
   (quote
    ("e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" "36282815a2eaab9ba67d7653cf23b1a4e230e4907c7f110eebf3cdf1445d8370" "25c06a000382b6239999582dfa2b81cc0649f3897b394a75ad5a670329600b45" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(font-use-system-font t)
 '(lsp-rust-server (quote rust-analyzer))
 '(package-selected-packages
   (quote
    (helm-lsp lsp-mode evil-org org zig-mode csv-mode proof-general gnu-elpa-keyring-update haskell-mode typescript-mode dockerfile-mode json-mode helm-sage sage-shell-mode company-terraform terraform-mode tuareg popwin racer go-mode yaml-mode evil-magit evil lua-mode rust-mode inf-ruby flycheck helm-projectile less-css-mode markdown-mode exec-path-from-shell helm solidity-mode magit coffee-mode rspec-mode ace-window try use-package js2-mode)))
 '(popwin:special-display-config
   (quote
    (("*Miniedit Help*" :noselect t)
     (help-mode)
     (completion-list-mode :noselect t)
     (compilation-mode :noselect nil)
     (grep-mode :noselect t)
     (occur-mode :noselect t)
     ("*Pp Macroexpand Output*" :noselect t)
     ("*Shell Command Output*")
     ("*vc-diff*")
     ("*vc-change-log*")
     (" *undo-tree*" :width 60 :position right)
     ("^\\*anything.*\\*$" :regexp t)
     ("*slime-apropos*")
     ("*slime-macroexpansion*")
     ("*slime-description*")
     ("*slime-compilation*" :noselect t)
     ("*slime-xref*")
     (sldb-mode :stick t)
     (slime-repl-mode)
     (slime-connection-list-mode)
     ("*Racer Help*"))))
 '(safe-local-variable-values (quote ((projectile-globally-ignored-file-suffixes ".o"))))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "PfEd" :slant normal :weight normal :height 128 :width normal)))))
