;; -*- lexical-binding: t; -*-
(add-to-list 'load-path "~/.emacs.d/modules") ;; TODO: do it dinamic

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'ih-package-manager)
(require 'ih-hooks)
(require 'ih-ui)
(require 'ih-lang)

;; The default is 800 kilobytes. Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "*** Emacs loaded in %s seconds with %d garbage collections."
 		     (emacs-init-time "%.2f")
 		     gcs-done)))
;; no backups
(setq make-backup-files nil
      auto-save-default nil)
(setq vc-follow-symlinks nil)
;; whitespaces
(setq whitespace-style '(empty face lines-tail tabs trailing))

;; Line numbers in modeline
(line-number-mode)
(column-number-mode)
(global-display-line-numbers-mode)
;; commented for learning

(when window-system
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tab-bar-mode 1))

;; Make the current line more subtle by highlighting the current line.
(hl-line-mode)

(display-time-mode 1)
(display-battery-mode 1)
