(message "Loading ih-ui.el ...")

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

;;(set-message-beep 'silent)

;; Make the current line more subtle by highlighting the current line.
(hl-line-mode)

(display-time-mode 1)
(display-battery-mode 1)

;;; (set-frame-font "FiraCode Nerd Font 12" nil t)
(set-face-attribute 'default nil
  :family "FiraCode Nerd Font"
  :height 130)

(set-face-attribute 'fixed-pitch nil
  :family "FiraCode Nerd Font"
  :height 130)

(set-face-attribute 'variable-pitch nil
  :family "FiraCode Nerd Font"
  :height 130)

;;; ============================
;;;  Ligaduras (FiraCode)
;;; ============================

(use-package ligature
  :ensure t
  :config
  ;; habilita ligaduras globalmente
  (ligature-set-ligatures 't
    '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-"
      "<<" ">>" "<=" ">=" "<=>" "<>" "==" "===" "!=" "!=="
      "->" "->>" "=>" "==>" "::" ":::" ";;"))
  (global-ligature-mode t))


(load-theme 'doom-material)

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-icon t))

(provide 'ih-ui)
