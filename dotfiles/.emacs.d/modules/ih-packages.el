;;; package --- sumary
;;; Commentary:
;;; Code:

(use-package ivy
  :ensure t
  :config
  (ivy-mode t))

(use-package lsp-mode
  :ensure t)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode))

(use-package nerd-icons
  :ensure t)

(use-package doom-themes
  :ensure t)

(provide 'ih-packages)
;;; ih-packages.el ends here
