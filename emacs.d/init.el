(setq inhibit-startup-message t)

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default column-number-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(tool-bar-mode -1)

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

(use-package helm
  :ensure t
  :diminish helm-mode
  :bind (("M-x" . helm-M-x)
         ("M-s o" . helm-occur)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files))
  :init
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action))

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  :config
  (projectile-global-mode)
  (helm-projectile-on))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-chalk t))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package org
  :ensure t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb)))

(use-package erc
  :init
  (defun erc-connect ()
    "Connect to IRC bouncer"
    (interactive)
    (erc :server "HOSTNAME"
         :port 12345
         :nick "jimpo"
         :password "jimpo/freenode:PASSWORD")))

(use-package evil
  :init
  (evil-mode 1))

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

(use-package inf-ruby)

(use-package js2-mode
  :mode "\\.es6\\'"
  :mode "\\.js\\'"
  :mode "\\.jsx\\'"
  :mode "\\.json\\'"
  :interpreter "node")

(use-package yaml-mode)
(use-package coffee-mode)
(use-package go-mode
  :init
  (add-hook 'before-save-hook #'gofmt-before-save))

(setq path-to-ctags "/usr/bin/ctags")
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name))))

;; https://gist.github.com/magnars/3292872
(defun goto-line-with-feedback (&optional line)
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive "P")
  (if line
      (goto-line line)
    (unwind-protect
        (progn
          (linum-mode 1)
          (goto-line (read-number "Goto line: ")))
      (linum-mode -1))))

(global-linum-mode -1)
(global-set-key [remap goto-line] 'goto-line-with-feedback)
