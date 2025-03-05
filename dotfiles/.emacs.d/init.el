;; -*- lexical-binding: t; -*-
(add-to-list 'load-path "~/.emacs.d/modules") ;; TODO: do it dinamic

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'ih-package-manager)
(require 'ih-packages)
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
