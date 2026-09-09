;; Suggested in https://github.com/radian-software/straight.el#getting-started
(setq package-enable-at-startup nil)

;; straight.el creates its `straight/' subdirectory under `straight-base-dir',
;; which defaults to `user-emacs-directory'. Both the bootstrap block in
;; `init.el' and straight's own `install.el' read the variable, so setting it
;; here is enough. `straight-build-dir' names a directory relative to
;; `straight/' rather than a path, so `repos/' and `build/' cannot be split;
;; `repos/' decides where the pair goes, because it holds git checkouts that
;; can carry local commits and, without lockfiles, is the only record of the
;; package versions in use.
(setq straight-base-dir
      (expand-file-name "emacs/" (or (getenv "XDG_STATE_HOME") "~/.local/state")))

;; Native-compilation output is derived from the packages and can be rebuilt.
(when (featurep 'native-compile)
  (startup-redirect-eln-cache
   (expand-file-name "emacs/eln-cache/" (or (getenv "XDG_CACHE_HOME") "~/.cache"))))
