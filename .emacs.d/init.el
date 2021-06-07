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
(load-file "./.emacs.d/restclient.el")
(load-file "./.emacs.d/restclient-helm.el")

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
    (lsp-rust toml-mode flycheck-rust cargo rust-mode treemacs-projectile lsp-java terraform-doc company-quickhelp company-terraform avy-zap counsel editorconfig expand-region npm-mode magit yaml-mode j golden-ratio lsp-mode dracula-theme flycheck sbt-mode scala-mode dap-mode lsp-treemacs helm-lsp company-lsp lsp-ui projectile helm use-package))))
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

(use-package fold-this
  :bind (
	 ("C-c C-f" . fold-this-all)
	 ("C-c C-F" . fold-this)
	 ("C-c M-f" . fold-this-unfold-all)
	)
)
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

(use-package zoom)

(custom-set-variables
 '(zoom-mode t))

(custom-set-variables
 '(zoom-size '(0.618 . 0.618)))

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

(use-package god-mode
  :bind (("C-." . 'god-mode-all))
)

(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

(use-package multiple-cursors
  :bind (
	 ("C-S-c C-S-c" . 'mc/edit-lines)
	 ("C->" . 'mc/mark-next-like-this)
	 ("C-<" . 'mc/mark-previous-like-this)
	)
)

(use-package yasnippet)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package auto-package-update
   :ensure t
   :config
   (setq auto-package-update-delete-old-versions t
         auto-package-update-interval 4)
   (auto-package-update-maybe))

(add-to-list 'default-frame-alist '(font . "OpenDyslexicMono-10"))

(use-package dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Haskell Dante

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  ;; OR:
  ;; (add-hook 'haskell-mode-hook 'flymake-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

(setq flymake-no-changes-timeout nil)
(setq flymake-start-syntax-check-on-newline nil)
(setq flycheck-check-syntax-automatically '(save mode-enabled))

(auto-save-visited-mode 1)
(setq auto-save-visited-interval 1)

(add-hook 'dante-mode-hook
   '(lambda () (flycheck-add-next-checker 'haskell-dante
                '(warning . haskell-hlint))))

(add-to-list 'exec-path "/usr/local/bin")
(use-package ejc-sql)

(use-package presentation)

(use-package lsp-metals)

(use-package helm-company
	 :bind (
	 ("C-:" . 'helm-company)	 
))

	 
(global-set-key (kbd "C-x C-b" ) 'sbt-command)

(use-package inf-mongo)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(setq dap-auto-configure-features '(sessions locals controls tooltip))

(require 'dap-java)
(use-package dap-mode)

(use-package posframe
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )

;; -*- lexical-binding: t -*-
(define-minor-mode +dap-running-session-mode
  "A mode for adding keybindings to running sessions"
  nil
  nil
  (make-sparse-keymap)
  (evil-normalize-keymaps) ;; if you use evil, this is necessary to update the keymaps
  ;; The following code adds to the dap-terminated-hook
  ;; so that this minor mode will be deactivated when the debugger finishes
  (when +dap-running-session-mode
    (let ((session-at-creation (dap--cur-active-session-or-die)))
      (add-hook 'dap-terminated-hook
                (lambda (session)
                  (when (eq session session-at-creation)
                    (+dap-running-session-mode -1)))))))


(use-package lsp-ui)

;; Activate this minor mode when dap is initialized
(add-hook 'dap-session-created-hook '+dap-running-session-mode)

;; Activate this minor mode when hitting a breakpoint in another file
(add-hook 'dap-stopped-hook '+dap-running-session-mode)

;; Activate this minor mode when stepping into code in another file
(add-hook 'dap-stack-frame-changed-hook (lambda (session)
                                          (when (dap--session-running session)
                                            (+dap-running-session-mode 1))))

(setq lsp-lens-enable t)

