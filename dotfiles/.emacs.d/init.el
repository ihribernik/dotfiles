;; -*- lexical-binding: t; -*-

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

;; whitespaces
(setq whitespace-style '(empty face lines-tail tabs trailing))

;; Line numbers in modeline
(line-number-mode)
(column-number-mode)
(global-display-line-numbers-mode)


;; The following snippet will change some settings only when running in a
;; graphical environment.  It will include removing some window elements
;; that are not necessary at all (such as the toolbars), and it will also
;; set the font.

;; commented for learning

;; (when window-system
;;   (tool-bar-mode -1)
;;   (menu-bar-mode -1)
;;   (scroll-bar-mode -1))

;; Make the current line more subtle by highlighting the current line.
(hl-line-mode)
