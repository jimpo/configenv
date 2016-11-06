(setq inhibit-startup-message t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default column-number-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(tool-bar-mode -1)

(global-set-key (kbd "M-.") 'etags-select-find-tag)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window))

(use-package editorconfig
  :ensure t
  :init
  (add-hook 'prog-mode-hook (editorconfig-mode 1))
  (add-hook 'text-mode-hook (editorconfig-mode 1)))

(use-package rspec-mode
  :mode "_spec\\.rb\\'")

(use-package ruby-mode
  :ensure t
  :mode "\\.rb\\'"
  :mode "\\.rake\\'"
  :init
  (progn
    (setq ruby-deep-indent-paren nil)
    (setq ruby-insert-encoding-magic-comment nil)))

(use-package js2-mode
  :mode "\\.js\\'"
  :mode "\\.jsx\\'"
  :mode "\\.json\\'"
  :interpreter "node")

(use-package yaml-mode)
(use-package coffee-mode)
(use-package go-mode)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-bright))
