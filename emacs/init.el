(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(setq visible-bell t)

(defun my-prog-mode ()
  (display-line-numbers-mode 1)
  (show-paren-mode 1)
  (setq show-paren-delay 0)
  (global-hl-line-mode 1)
  (rainbow-delimiters-mode 1)
  (smartparens-mode t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace))

(add-hook 'prog-mode-hook #'my-prog-mode)

(set-frame-font "Hack-11" nil t)

;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
(setq display-time-format "%Y-%m-%d (%a) %R")
(display-time-mode 1)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq user-emacs-directory "~/.cache/emacs")
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq auto-save-default nil)

(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 3)
(setq tramp-completion-reread-directory-timeout nil)

(setq dired-dwim-target t)

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
(require 'use-package)

(setq use-package-always-ensure t)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
;; (package-refresh-contents)

(use-package no-littering)

(use-package modus-themes
	     :config
	     (load-theme 'modus-vivendi t))

;; (use-package color-theme-modern
;;   :config
;;   (load-theme 'lawrence t))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package general
  :after evil)

(general-define-key
 :states '(normal visual)
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line
 ;; switch visual-block and -char around
 "v" 'evil-visual-block
 "C-v" 'evil-visual-char)

(general-define-key
 :states '(normal insert visual emacs)
 :keymaps '(normal override dired-mode-map)
 :prefix "SPC"
 :non-normal-prefix "C-SPC"
 "SPC" '(counsel-M-x :which-key "M-x")
 "b" '(switch-to-buffer :which-key "Switch buffer")
 "d" '(dired :which-key "Dired")
 "e" '(evil-ex :which-key "Evil Ex")
 "f" '(find-file :which-key "Find file")
 "g" '(magit-status :which-key "Magit")
 "m" '(:ignore t :which-key "Bookmark")
 "ms" '(bookmark-set :which-key "set")
 "mo" '(bookmark-jump :which-key "Jump")
 "s" '(save-buffer :which-key "Save buffer"))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-visualstar
  :config
  (global-evil-visualstar-mode 1))

(use-package evil-nerd-commenter
  :general
  ("M-/" 'evilnc-comment-or-uncomment-lines))

(use-package expand-region
  :general
  (:states '(normal visual)
	   "C-=" 'er/expand-region
	   "C--" 'er/contract-region))

(use-package avy
  :general
  (:states '(normal visual)
	   "s" 'avy-goto-char-timer))

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  :general
  (:states 'normal
	   "u" 'undo-tree-undo
	   "U" 'undo-tree-redo))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :config
  (counsel-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  (setq ivy-rich-parse-remote-buffer nil))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering t)
  :config
  (prescient-persist-mode 1)
  (setq prescient-filter-method '(literal regexp fuzzy))
  (ivy-prescient-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package smartparens)
(use-package rainbow-delimiters)

(use-package flycheck)
(use-package magit)
(use-package minimap)

(use-package projectile
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :general
  (:states 'normal
	   "SPC p" 'projectile-command-map)
  :init
  (when (file-directory-p "~/repos")
    (setq projectile-project-search-path '("~/repos")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package pdf-tools
  :init
  (pdf-tools-install))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package nix-mode)

(use-package elixir-mode
  :config
  (add-hook 'elixir-mode-hook (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
  (use-package mix
    :config
    (add-hook 'elixir-mode-hook 'mix-minor-mode)))

(use-package hungry-delete)

(defalias 'perl-mode 'cperl-mode)

(use-package smart-tabs-mode
  :config
  (smart-tabs-insinuate 'cperl))

(defun my-perl ()
  (general-define-key
   :states 'normal
   :keymaps 'local
   "C-h f" 'cperl-perldoc)
  (general-define-key
   :states 'insert
   :keymaps 'local
   "TAB" 'self-insert-command
   "DEL" 'hungry-delete-backward)
  (smart-tabs-advice cperl-indent-line cperl-indent-level)
  (smartparens-mode 0)
  (smart-tabs-mode-enable)
  (hungry-delete-mode 1)
  (setq cperl-indent-level 8
	cperl-electric-parens t
	;; 	 cperl-close-paren-offset -4
	;; 	 cperl-continued-statement-offset 4
	cperl-tab-always-indent t
	cperl-indent-parens-as-block t))

(add-hook 'cperl-mode-hook #'my-perl)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("96c56bd2aab87fd92f2795df76c3582d762a88da5c0e54d30c71562b7bf9c605" "7ea491e912d419e6d4be9a339876293fff5c8d13f6e84e9f75388063b5f794d6" default))
 '(package-selected-packages '(modus-operandi-theme))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ))
(put 'narrow-to-region 'disabled nil)
