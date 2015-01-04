(require-package 'js2-mode)
(require-package 'js-comint)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.jshintrc$" . js-mode))

(add-hook 'js-mode-hook (lambda () (flycheck-mode t)))
(add-hook 'js2-mode-hook (lambda () (flycheck-mode t)))

(eval-after-load "js2-mode"
  '(defadvice js2-mode (after js2-rename-modeline activate)
     (setq mode-name "JS2")))

(after-load 'js2-mode
  ;; Indendt case labels on extra level
  (setq-default js2-indent-switch-body t)
  ;; Globals
  (setq-default js2-global-externs '("module" "require" "jQuery" "$" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "console" "JSON" "angular" "moment" "opto" "op"))
  ;; Delay in seconds before re-parsing
  (setq-default js2-idle-timer-delay 0.1)
  ;; js2-line-break sets + at the end
  (setq-default js2-concat-multiline-strings 'eol)

  ;; Let flycheck handle parse errors
  (setq-default js2-allow-rhino-new-expr-initializer nil)
  (setq-default js2-strict-inconsistent-return-warning nil)
  (setq-default js2-mode-show-parse-errors nil)
  (setq-default js2-mode-show-strict-warnings nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-strict-trailing-comma-warning t) ;; jshint does not warn about this now for some reason

  ;; steal back alt-j
  (define-key js2-mode-map (kbd "M-j") '(lambda () (interactive)
                                          (join-line -1)
                                          (indent-for-tab-command)))
  (define-key js2-mode-map (kbd "M-n") '(lambda () (interactive) (js2-line-break)))

  ;; Refactoring tools
  (require-package 'js2-refactor)
  (define-key js2-mode-map (kbd "C-c C-m a") 'js2r-extract-function)
  (define-key js2-mode-map (kbd "C-c C-m b") 'js2r-extract-method)
  (define-key js2-mode-map (kbd "C-c C-m c") 'js2r-introduce-parameter)
  (define-key js2-mode-map (kbd "C-c C-m d") 'js2r-localize-parameter)
  (define-key js2-mode-map (kbd "C-c C-m e") 'js2r-expand-function)
  (define-key js2-mode-map (kbd "C-c C-m f") 'js2r-contract-function)
  (define-key js2-mode-map (kbd "C-c C-m g") 'js2r-expand-array)
  (define-key js2-mode-map (kbd "C-c C-m h") 'js2r-contract-array)
  (define-key js2-mode-map (kbd "C-c C-m i") 'js2r-wrap-buffer-in-iife)
  (define-key js2-mode-map (kbd "C-c C-m j") 'js2r-inject-global-in-iife)
  (define-key js2-mode-map (kbd "C-c C-m k") 'js2r-add-to-globals-annotation)
  (define-key js2-mode-map (kbd "C-c C-m l") 'js2r-extract-var)
  (define-key js2-mode-map (kbd "C-c C-m m") 'js2r-inline-var)
  (define-key js2-mode-map (kbd "C-c C-m n") 'js2r-rename-var)
  (define-key js2-mode-map (kbd "C-c C-m o") 'js2r-var-to-this)
  (define-key js2-mode-map (kbd "C-c C-m p") 'js2r-arguments-to-object)
  (define-key js2-mode-map (kbd "C-c C-m q") 'js2r-ternary-to-if)
  (define-key js2-mode-map (kbd "C-c C-m r") 'js2r-split-var-declaration)
  (define-key js2-mode-map (kbd "C-c C-m s") 'js2r-split-string)
  (define-key js2-mode-map (kbd "C-c C-m t") 'js2r-unwrap)
  (define-key js2-mode-map (kbd "C-c C-m v") 'js2r-log-this)
  (define-key js2-mode-map (kbd "C-c C-m w") 'js2r-forward-slurp)
  (define-key js2-mode-map (kbd "C-c C-m x") 'js2r-forward-barf)

  (define-key js2-mode-map (kbd "C-k") 'js2r-kill)
  
  (js2-imenu-extras-setup))

;; Appereance
(font-lock-add-keywords
 'js-mode `(("\\(function\\) *("
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "\u0192")
                       nil)))))

(font-lock-add-keywords
 'js-mode `(("function *([^)]*) *{ *\\(return\\) "
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "\u2190")
                       nil)))))

(font-lock-add-keywords
 'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
              (0 (progn (compose-region (match-beginning 1)
                                        (match-end 1) "\u2190")
                        nil)))))

(font-lock-add-keywords
 'js2-mode `(("\\(function\\) *("
              (0 (progn (compose-region (match-beginning 1)
                                        (match-end 1) "\u0192")
                        nil)))))

;; ---------------------------------------------------------------------------
;; Run and interact with an inferior JS via js-comint.el
;; ---------------------------------------------------------------------------

(setenv "NODE_NO_READLINE" "1")

(setq inferior-js-program-command "node --interactive")

(defvar inferior-js-minor-mode-map (make-sparse-keymap))
(define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
(define-key inferior-js-minor-mode-map "\C-\M-x" 'js-send-last-sexp-and-go)
(define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)
(define-key inferior-js-minor-mode-map "\C-c\C-b" 'js-send-buffer-and-go)
(define-key inferior-js-minor-mode-map "\C-cl" 'js-load-file-and-go)

(define-minor-mode inferior-js-keys-mode
  "Bindings for communicating with an inferior js interpreter."
  nil " InfJS" inferior-js-minor-mode-map)

(dolist (hook '(js2-mode-hook js-mode-hook))
  (add-hook hook 'inferior-js-keys-mode))

;; ---------------------------------------------------------------------------
;; Alternatively, use skewer-mode
;; ---------------------------------------------------------------------------

;; Bookmarklet to load skewer:
;;
;;     javascript:(function(){var d=document ;var s=d.createElement('script');s.src='http://localhost:8023/skewer';d.body.appendChild(s);})()
;;

(require-package 'skewer-mode)

(after-load 'skewer-mode
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'skewer-mode-hook
            (lambda () (inferior-js-keys-mode -1))))

(defun skewer-start ()
  (interactive)
  (let ((httpd-port 8023))
    (httpd-start)
    (message "Ready to skewer the browser. Now jack in with the bookmarklet.")))

(defun skewer-demo ()
  (interactive)
  (let ((httpd-port 8024))
    (run-skewer)
    (skewer-repl)))

(provide 'init-javascript)