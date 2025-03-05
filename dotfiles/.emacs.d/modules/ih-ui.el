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

(set-frame-font "JetBrainsMono NF 12" nil t)

(load-theme 'doom-material)

(provide 'ih-ui)
