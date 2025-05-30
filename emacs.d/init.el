(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq inhibit-startup-message t)

(setq-default indent-tabs-mode t)
(setq-default show-trailing-whitespace t)
(setq-default column-number-mode t)
(setq-default tab-width 2)
(setq-default c-basic-offset 4)
(setq-default sentence-end-double-space nil)

;; https://www.emacswiki.org/emacs/ToolBar
(tool-bar-mode -1)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://github.com/radian-software/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
			 (expand-file-name
				"straight/repos/straight.el/bootstrap.el"
				(or (bound-and-true-p straight-base-dir)
						user-emacs-directory)))
			(bootstrap-version 7))
	(unless (file-exists-p bootstrap-file)
		(with-current-buffer
				(url-retrieve-synchronously
				 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
				 'silent 'inhibit-cookies)
			(goto-char (point-max))
			(eval-print-last-sexp)))
	(load bootstrap-file nil 'nomessage))


(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))


(use-package try
	:ensure t)

(use-package ace-window
	:ensure t
	:init
	(global-set-key [remap other-window] 'ace-window))

(use-package diminish
	:ensure t)

(use-package editorconfig
	:ensure t
	:config
	(editorconfig-mode 1)
	:custom
	(editorconfig-trim-whitespaces-mode 'delete-trailing-whitespace))

(use-package helm
	:straight t
	:ensure t
	:diminish helm-mode
	:bind (("M-x" . helm-M-x)
				 ("M-s o" . helm-occur)
				 ("C-x r b" . helm-filtered-bookmarks)
				 ("C-x C-f" . helm-find-files)
				 ("C-c i" . helm-semantic-or-imenu))
	:init
	(global-set-key (kbd "C-c h") 'helm-command-prefix)
	:config
	(helm-mode 1)
	(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
	(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
	(define-key helm-map (kbd "C-z") 'helm-select-action)
	:custom
	(helm-move-to-line-cycle-in-source nil))

(use-package helm-projectile
	:ensure t
	:init
	(setq projectile-completion-system 'helm)
	:config
	(projectile-global-mode)
	(helm-projectile-on)
	(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package projectile
	:custom
	(projectile-use-git-grep t))

(use-package exec-path-from-shell
	:ensure t
	:config
	(exec-path-from-shell-initialize))

(use-package sh-script
	:mode ("APKBUILD" . shell-script-mode))

(use-package base16-theme
	:ensure t
	:config
	(load-theme 'base16-bright t))

(use-package magit
	:ensure t
	:bind ("C-x g" . magit-status))

(use-package org
	:ensure t
	:bind (("C-c l" . org-store-link)
				 ("C-c a" . org-agenda)
				 ("C-c c" . org-capture)
				 ("C-c b" . org-iswitchb))
	:init
	(setq org-agenda-files (list "~/org/planner.org")))

(use-package popwin
	:ensure t
	:init
	(require 'popwin)
	(popwin-mode 1))

(use-package evil
	:ensure t
	:init
	;; https://github.com/ProofGeneral/PG/issues/174
	(setq evil-want-abbrev-expand-on-insert-exit nil)
	(setq evil-want-C-u-scroll t)
	;; https://github.com/emacs-evil/evil-collection
	(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
	(setq evil-want-keybinding nil)
	:custom
	(evil-undo-system 'undo-redo)
	:config
	(evil-mode 1)
	(define-key evil-window-map "d" 'pop-to-same-buffer))

(use-package evil-collection
	:after evil
	:ensure t
	:custom
	(evil-collection-calendar-want-org-bindings t)
	:config
	(evil-collection-init))

(use-package evil-org
	:ensure t
	:after org
	:hook (org-mode . (lambda () evil-org-mode))
	:config
	;; (add-hook 'org-mode-hook 'evil-org-mode)
	;; (add-hook 'evil-org-mode-hook
	;;           (lambda ()
	;;             (evil-org-set-key-theme)))
	(require 'evil-org-agenda)
	(evil-org-agenda-set-keys))

(use-package rspec-mode
	:mode "_spec\\.rb\\'")

(use-package ruby-mode
	:mode "\\.rb\\'"
	:mode "\\.rake\\'"
	:init
	(progn
		(setq ruby-deep-indent-paren nil)
		(setq ruby-insert-encoding-magic-comment nil)))

(use-package js2-mode
	:mode "\\.es6\\'"
	:mode "\\.js\\'"
	:mode "\\.jsx\\'"
	:interpreter "node")

(use-package rust-mode
	:hook (rust-mode . (lambda () (setq tab-width 4)))
	:hook (rust-mode . (lambda () (setq indent-tabs-mode nil))))

(use-package camkes-mode
	:mode "\\.idl4\\'"
	:mode "\\.camkes\\'")

(use-package makefile-mode
	:mode "\\.mak\\'")

(use-package go-mode
	:hook (before-save . gofmt-before-save))

(use-package lsp-mode
	:commands lsp
	:hook (svelte-mode . lsp)
	:hook (typescript-mode . lsp)
	:hook (rust-mode . lsp)
	:hook (python-mode . lsp)
	:hook (solidity-mode . lsp)
	:init
	(evil-define-minor-mode-key 'normal 'lsp-mode "gd" 'lsp-find-definition)
	(evil-define-minor-mode-key 'motion 'lsp-mode "K" 'lsp-describe-thing-at-point)
	:config
	(lsp-register-client
	 (make-lsp-client :new-connection (lsp-stdio-connection '("solc" "--lsp"))
										:activation-fn (lsp-activate-on "solidity")
										:server-id 'solc-lsp))
	(add-to-list 'lsp-language-id-configuration '(solidity-mode . "solidity"))
	:custom
	(lsp-rust-analyzer-server-command '("rustup" "run" "stable" "rust-analyzer"))
	(lsp-pylsp-plugins-black-enabled 't))

(use-package helm-lsp
	:commands helm-lsp-workspace-symbol
	:bind (("M-SPC" . helm-lsp-workspace-symbol)))

(use-package markdown-mode
	:ensure t
	:init (setq markdown-command "pandoc"))

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
					(display-line-numbers-mode)
					(goto-line (read-number "Goto line: ")))
			(display-line-numbers-mode))))

(global-set-key [remap goto-line] 'goto-line-with-feedback)

;; ElDoc can be intrusive and quite slow at times, so only show on demand.
;; (defun eldoc-show-message ()
;;   (interactive)
;;   (eldoc-message (funcall eldoc-documentation-function)))

;; (evil-global-set-key 'motion "gK" 'eldoc-show-message)
;; (global-eldoc-mode -1)

(global-set-key (kbd "C-/") 'comment-dwim)
(put 'downcase-region 'disabled nil)

;; Duplicate the current buffer in another open window.
(defun pop-to-same-buffer (&optional norecord)
	(interactive)
	(let ((pop-up-windows t))
		(pop-to-buffer (current-buffer) t norecord)))

;; Flash the mode line instead of audible bell
;; See https://www.emacswiki.org/emacs/AlarmBell#h5o-3
(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))
