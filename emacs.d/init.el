(setq inhibit-startup-message t)

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default column-number-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default sentence-end-double-space nil)

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
  :config
  (editorconfig-mode 1))

(use-package helm
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
  (helm-projectile-on)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

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
  (evil-mode 1)
  (define-key evil-window-map "d" 'pop-to-same-buffer))

(use-package evil-magit
  :ensure t
  :init
  (require 'evil-magit))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

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
(use-package go-mode
  :hook (before-save . gofmt-before-save))

;; (use-package racer
;;   :hook (rust-mode . racer-mode)
;;   :init
;;   (evil-define-minor-mode-key 'normal 'racer-mode "gd" 'racer-find-definition)
;;   (evil-define-minor-mode-key 'motion 'racer-mode "K" 'racer-describe))

(use-package lsp-mode
  :hook ((rust-mode . lsp))
  :commands lsp
  :init
  (evil-define-minor-mode-key 'normal 'lsp-mode "gd" 'lsp-find-definition)
  (evil-define-minor-mode-key 'motion 'lsp-mode "K" 'lsp-describe-thing-at-point))

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  :bind (("M-SPC" . helm-lsp-workspace-symbol)))

(use-package markdown-mode
  :ensure t
  :init (setq markdown-command "pandoc"))

(use-package proof-general)

(setq path-to-ctags "/usr/local/bin/ctags")
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

;; ElDoc can be intrusive and quite slow at times, so only show on demand.
;; (defun eldoc-show-message ()
;;   (interactive)
;;   (eldoc-message (funcall eldoc-documentation-function)))

;; (evil-global-set-key 'motion "gK" 'eldoc-show-message)
;; (global-eldoc-mode -1)

(define-key undo-tree-map (kbd "C-/") nil)
(global-set-key (kbd "C-/") 'comment-dwim)
(put 'downcase-region 'disabled nil)

;; Duplicate the current buffer in another open window.
(defun pop-to-same-buffer (&optional norecord)
  (interactive)
  (let ((pop-up-windows t))
    (pop-to-buffer (current-buffer) t norecord)))
