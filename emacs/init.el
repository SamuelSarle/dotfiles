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
  (setq show-paren-when-point-inside-paren t)
  (setq-default indent-tabs-mode nil)
  (smartparens-mode 1)
  (evil-smartparens-mode 1)
  (global-hl-line-mode 1)
  (rainbow-delimiters-mode 1)
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
(defadvice projectile-project-root (around ignore-remote first activate)
  (unless (file-remote-p default-directory) ad-do-it))

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

(general-define-key :states '(normal visual)
                    "j" 'evil-next-visual-line
                    "k" 'evil-previous-visual-line
                    ;; switch visual-block and -char around
                    "v" 'evil-visual-block
                    "C-v" 'evil-visual-char
                    "C-h" 'windmove-left
                    "C-j" 'windmove-down
                    "C-k" 'windmove-up
                    "C-l" 'windmove-right)

(general-define-key :states '(normal insert visual emacs)
                    :keymaps '(normal override dired-mode-map)
                    :prefix "SPC"
                    :non-normal-prefix "C-SPC"
                    "SPC" '(counsel-M-x :which-key "M-x")
                    "a" '(org-agenda :which-key "Org-Agenda")
                    "b" '(switch-to-buffer :which-key "Switch buffer")
                    "c" '(org-capture :which-key "Org-Capture")
                    "d" '(dired :which-key "Dired")
                    "e" '(evil-ex :which-key "Evil Ex")
                    "f" '(find-file :which-key "Find file")
                    "g" '(magit-status :which-key "Magit")
                    "m" '(:ignore t :which-key "Bookmark")
                    "ms" '(bookmark-set :which-key "set")
                    "mo" '(bookmark-jump :which-key "Jump")
                    "s" '(save-buffer :which-key "Save buffer")
                    "t" '(neotree-toggle :which-key "Neotree")
                    "k" '(kill-current-buffer :which-key "Kill buffer"))

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

(use-package evil-smartparens)

(use-package expand-region
  :general
  (:states '(normal visual)
           "S-SPC" 'er/expand-region
           "C-SPC" 'er/contract-region))

(use-package avy
  :bind
  (:map evil-normal-state-map
        ("g s" . avy-goto-char-timer)
        ("g w" . avy-goto-word-1)))

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
  :general
  ("C-s" 'swiper)
  (:keymaps 'ivy-minibuffer-map
            "TAB" 'ivy-alt-done
            "C-l" 'ivy-alt-done
            "C-j" 'ivy-next-line
            "C-k" 'ivy-previous-line)
  (:keymaps 'ivy-switch-buffer-map
            "C-k" 'ivy-previous-line
            "C-l" 'ivy-done
            "C-d" 'ivy-switch-buffer-kill)
  (:keymaps 'ivy-reverse-i-search-map
            "C-k" 'ivy-previous-line
            "C-d" 'ivy-reverse-i-search-kill)
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

(use-package parinfer-rust-mode
  :hook '(emacs-lisp-mode clojure-mode)
  :init
  (setq parinfer-rust-auto-download t))

(use-package smartparens)

(use-package rainbow-delimiters)

(use-package flycheck)

(use-package magit)

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-hide-dotfiles-mode))

(use-package projectile
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :general
  (:states 'normal
           "SPC p" 'projectile-command-map)
  :init
  (setq projectile-project-search-path '("~/repos"))
  (setq projectile-mode-line "Projectile")
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

(use-package ledger-mode)

(use-package nix-mode)

(use-package yaml-mode)

(use-package zoom
  :config
  (zoom-mode 1)
  (setq zoom-size '(0.618 . 0.618)))

(use-package docker
  :config
  (use-package docker-compose-mode)
  (use-package docker-tramp)
  (use-package dockerfile-mode))

(use-package elixir-mode
  :config
  (add-hook 'elixir-mode-hook (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
  (use-package mix
    :config
    (add-hook 'elixir-mode-hook 'mix-minor-mode)))

(use-package clojure-mode
  :config
  (add-hook 'clojure-mode-hook (lambda () (smartparens-mode -1)))
  (use-package cider)
  (use-package clj-refactor))

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
   "TAB" 'self-insert-command)
  (define-key cperl-mode-map "{" nil)
  (smart-tabs-advice cperl-indent-line cperl-indent-level)
  (setq indent-tabs-mode t)
  (smartparens-mode t)
  (smart-tabs-mode-enable)
  (setq cperl-indent-level 8
        ;;      cperl-close-paren-offset -4
        ;;      cperl-continued-statement-offset 4
        cperl-tab-always-indent t
        cperl-indent-parens-as-block t))

(add-hook 'cperl-mode-hook #'my-perl)

(use-package highlight-indent-guides
  :config
  (add-hook 'cperl-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'bitmap))

(use-package org
  :config
  (setq org-agenda-files '("~/org/tasks.org"))
  (setq org-agenda-start-with-log-mode t)
  (setq org-edit-src-content-indentation 0)
  (setq org-src-tab-acts-natively t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (org-babel-do-load-languages 'org-babel-load-languages '((ledger . t)))
  (setq org-refile-targets
        '(("archive.org" :maxlevel . 1)
          ("tasks.org" :maxlevel . 1)))
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")))
  (setq org-capture-templates
        `(("t" "Task" entry (file+olp "~/org/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)))
  (use-package org-bullets
    :hook (org-mode . org-bullets-mode)
    :custom
    (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))))

;; (load "ob-C.el")
;; (require 'ob-C)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((C . t)
;;    (ledger . t)))

(custom-set-variables
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("d2db4af7153c5d44cb7a67318891e2692b8bf5ddd70f47ee7a1b2d03ad25fcd9" "a10ca93d065921865932b9d7afae98362ce3c347f43cb0266d025d70bec57af1" "96c56bd2aab87fd92f2795df76c3582d762a88da5c0e54d30c71562b7bf9c605" "7ea491e912d419e6d4be9a339876293fff5c8d13f6e84e9f75388063b5f794d6" defa))
 '(nil nil t)
 ;; '(package-selected-packages '(modus-operandi-theme)))
 (put 'narrow-to-region 'disabled nil)
 (custom-set-faces))
