;; Installing Use Package

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(load-file "./.emacs.d/becon.el")

(beacon-mode 1)

(setq wttrin-default-cities '("Des Moines"))
(load-file "./.emacs.d/xterm-color.el")
(load-file "./.emacs.d/wttrin.el")

;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

(use-package helm
  :bind (("M-x" . helm-M-x)
         ("M-<f5>" . helm-find-files)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf)))

(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-rust toml-mode flycheck-rust cargo rust-mode treemacs-projectile lsp-java terraform-doc company-quickhelp company-terraform avy-zap counsel editorconfig expand-region npm-mode magit yaml-mode j golden-ratio lsp-mode cyberpunk-theme flycheck sbt-mode scala-mode dap-mode lsp-treemacs helm-lsp company-lsp lsp-ui projectile helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key (kbd "M-q") 'projectile-find-file)
(global-set-key (kbd "C-q") 'projectile-grep)

(use-package cyberpunk-theme)

(use-package lsp-mode
  :hook (scala-mode . lsp)
  :commands lsp)

(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; optionally if you want to use debuggera

(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook (scala-mode . lsp)
  :config (setq lsp-prefer-flymake nil))

(use-package lsp-ui)

;; Add company-lsp backend for metals
(use-package company-lsp)

(use-package golden-ratio)
(golden-ratio-mode 1)

(use-package magit
  :bind (("C-x g" . magit-status))
)

(use-package npm-mode)

(use-package expand-region
  :bind (("C-=". er/expand-region))
)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package counsel)
(use-package ivy)

(use-package avy-zap)
(global-set-key (kbd "C-;") 'avy-goto-char)

(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(show-paren-mode 1)

(menu-bar-mode -1) 

(tool-bar-mode -1) 

(add-hook 'after-init-hook 'global-company-mode)

(use-package company-terraform)
(company-terraform-init)

(use-package company-quickhelp)
(company-quickhelp-mode)

(use-package terraform-doc)

(global-set-key (kbd "C-`") 'golden-ratio-adjust)

(use-package treemacs-projectile)

(use-package lsp-java)
(add-hook 'java-mode-hook #'lsp)

(use-package rust-mode)

(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

(use-package cargo)

(add-hook 'rust-mode-hook 'cargo-minor-mode)

(use-package toml-mode)

(use-package flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "pyls")
                  :major-modes '(rust-mode)
                  :server-id 'pyls))
