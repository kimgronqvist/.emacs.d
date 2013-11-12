(defun skip-to-next-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-forward " >")
    (unless (search-forward-regexp "^\\s *$" nil t)
      (goto-char (point-max)))))

(defun skip-to-previous-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-backward " >")
    (unless (search-forward-regexp "^\\s *$" nil t)
      (goto-char (point-min)))))

(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))

(require 'simplezen)

(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas/fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

(add-hook 'sgml-mode-hook '--setup-simplezen)

(add-hook 'html-mode-hook
		  (lambda()
			(setq sgml-basic-offset 4)))

(eval-after-load "sgml-mode"
 '(progn
    ;; don't include equal sign in symbols
    (modify-syntax-entry ?= "." html-mode-syntax-table)

    (define-key html-mode-map [remap forward-paragraph] 'skip-to-next-blank-line)
    (define-key html-mode-map [remap backward-paragraph] 'skip-to-previous-blank-line)
    (define-key html-mode-map (kbd "/") nil)

    (require 'tagedit)
    (define-key html-mode-map (kbd "C-M-<left>") 'tagedit-forward-barf-tag)
    (define-key html-mode-map (kbd "C-M-<right>") 'tagedit-forward-slurp-tag)
    ;; (define-key html-mode-map (kbd "M-r") 'tagedit-raise-tag)
    ;; (define-key html-mode-map (kbd "M-s") 'tagedit-splice-tag)
    ;; (define-key html-mode-map (kbd "M-J") 'tagedit-join-tags)
    ;; (define-key html-mode-map (kbd "M-S") 'tagedit-split-tag)
    ;; (define-key html-mode-map (kbd "M-?") 'tagedit-convolute-tags)
    (define-key html-mode-map (kbd "C-M-k") 'tagedit-kill)
    (define-key html-mode-map (kbd "C-S-k") 'tagedit-kill-attribute)
    (tagedit-add-experimental-features)
    (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))

;; after delting a tag, indent properly
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))

(provide 'setup-html-mode)
