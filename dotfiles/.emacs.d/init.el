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

(display-time-mode 1)
(display-battery-mode 1)

;; using straight for package manage

;; https://github.com/raxod502/straight.el/issues/757#issuecomment-839764260
(defvar comp-deferred-compilation-deny-list ())

;; https://github.com/raxod502/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)

(use-package diminish
  :straight t)

(use-package editorconfig
  :straight t
  :disabled t
  :hook ((prog-mode . editorconfig-mode))
  :diminish editorconfig-mode)
