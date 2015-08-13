;;; init.el --- Emacs configuration of Kim Grönqvist

;;; Commentary:

;; Emacs configuration of Kim Grönqvist.

;;; Code:

(setq is-windows (equal system-type 'windows-nt))
(setq is-linux (equal system-type 'gnu/linux))

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq lisp-dir
      (expand-file-name "lisp" user-emacs-directory))

(setq user-custom-dir
      (expand-file-name "user-custom" user-emacs-directory))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Set up load path
(add-to-list 'load-path lisp-dir)
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path user-custom-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "lisp/init-custom.el" user-emacs-directory))
(load custom-file)

;; Load tern
(setq tern-dir
      (expand-file-name "tern/emacs" user-emacs-directory))
(add-to-list 'load-path tern-dir)
(autoload 'tern-mode "tern.el" nil t)

;; Setup packages
(require 'init-utils)
(require 'setup-package)

(require 'use-package)

(require 'init-modeline)
(require 'init-themes)
(require 'init-gui-frames)
(require 'init-editing-utils)
(require 'init-misc)
(require 'init-sessions)
(require 'init-locales)
(require 'init-windows)
(require 'init-uniquify)
(require 'init-org)
(require 'init-lisp)
(require 'init-css)
(require 'init-csharp)
(require 'init-company)
(require 'init-javascript)
(require 'init-tern)
(require 'init-helm)
(require 'init-which-key)
(require 'init-projectile)
(require 'init-project-explorer)
(require 'init-flycheck)

;; Stop creating auto save files
(setq auto-save-default nil)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require-package 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(require 'setup-shell)
(require 'init-smartparens)

;; Setup extensions
(require 'setup-json-mode)
(eval-after-load 'org '(require 'init-org))

(require 'setup-html-mode)
(require 'init-dired)
(require 'init-hippie)
(require 'init-yasnippet)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require-package 'multiple-cursors)
(require-package 'idomenu)

;; Setup key bindings
(require 'init-keys)

(put 'scroll-left 'disabled nil)

(use-package company-statistics         ; Sort company candidates by statistics
  :ensure t
  :defer t
  :init (with-eval-after-load 'company
          (company-statistics-mode)))

(use-package anzu                       ; Position/matches count for isearch
  :ensure t
  :init (global-anzu-mode)
  :config (setq anzu-cons-mode-line-p nil)
  :diminish anzu-mode)

(use-package which-func                 ; Current function name in header line
  :init (which-function-mode)
  :config
  (setq which-func-unknown "" ; The default is really boring…
        which-func-format
        `((:propertize (" \u0192 " which-func-current)
                       local-map ,which-func-keymap
                       face which-func
                       mouse-face mode-line-highlight
                       help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

(setq-default header-line-format
              '(which-func-mode ("" which-func-format " "))
              mode-line-format
              '("%e" mode-line-front-space
                ;; Standard info about the current buffer
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-frame-identification
                mode-line-buffer-identification " " mode-line-position
                (projectile-mode projectile-mode-line)
                (vc-mode (:propertize (:eval vc-mode) face italic))
                " "
                (flycheck-mode flycheck-mode-line) ; Flycheck status
                (isearch-mode " ")
                (anzu-mode (:eval                  ; isearch pos/matches
                            (when (> anzu--total-matched 0)
                              (anzu--update-mode-line))))
                (multiple-cursors-mode mc/mode-line) ; Number of cursors
                ;; And the modes, which we don't really care for anyway
                " " mode-line-misc-info mode-line-modes mode-line-end-spaces)
              mode-line-remote
              '(:eval
                (when-let (host (file-remote-p default-directory 'host))
                          (propertize (concat "@" host) 'face
                                      '(italic warning))))
              ;; Remove which func from the mode line, since we have it in the
              ;; header line
              mode-line-misc-info
              (assq-delete-all 'which-func-mode mode-line-misc-info))

;;; init.el ends here
