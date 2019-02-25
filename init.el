;;; init.el --- emacs init
;;; Commentary:

;;; Code:

;; Setup packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq inhibit-default-init t)

;; Emacs customizations

;; Shorter yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Use custom.el file for changes made by Custom
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Put autosave files (ie #foo#) and backup files (ie foo~) into a cache dir
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.cache/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.cache/backups/"))))

;; Put session backups into the cache directory
(setq auto-save-list-file-prefix "~/.emacs.cache/auto-save-list/.saves-")

;; Font face
(add-to-list 'default-frame-alist '(font . "Iosevka Term-14"))

(require 'nginx-mode)

(use-package ivy
  :config
  (ivy-mode t)
  (recentf-mode t)
  :bind (("s-f" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x M-j" . counsel-file-jump)
         ("C-x C-r" . counsel-recentf)
         ("C-x C-g" . counsel-git-grep)))

;; Font size
(define-key global-map (kbd "s-=") 'text-scale-increase)
(define-key global-map (kbd "s--") 'text-scale-decrease)
(defun text-scale-default ()
  (interactive)
  (text-scale-adjust 0))
(define-key global-map (kbd "s-0") 'text-scale-default)

(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)

(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)

(use-package powerline
  :config
  (powerline-default-theme))

;; duplicate-thing
;; auto-complete
;; company-mode
;; which-key
;; flycheck

(use-package visual-regexp
  :bind (("C-c r" . vr/replace)
         ("C-c q" . vr/query-replace)
         ("C-c m" . vr/mc-mark)))

(use-package visual-regexp-steroids)

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-s->" . mc/skip-to-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-s-<" . mc/skip-to-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)))

(use-package move-text
  :config (move-text-default-bindings))

;; undo-tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode t)
  (setq undo-tree-visualizer-relative-timestamps t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '((".*" . "~/.emacs.cache/undo/"))))

;; whitespace-cleanup
(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'whitespace-cleanup-mode))

;; yaml-mode
(use-package yaml-mode
  :ensure t)

;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode t))

;; saveplace
(use-package saveplace
  :ensure t
  :config
  (setq save-place-file "~/.emacs.cache/saveplace")
  (setq-default save-place t))

;; expand-region
(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; Disable the damn tabs
(setq-default indent-tabs-mode nil)

;; Make tab more powerful
(setq tab-always-indent 'complete)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

;; Always start in fullscreen with 2 buffers
(split-window-right)
(toggle-frame-fullscreen)
