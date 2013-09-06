;; Interactively do things
(require 'ido)
(ido-mode t)
(setq ido-create-new-buffer 'always
      ido-max-prospects 8
      ido-auto-merge-work-directories-length -1
      ido-case-fold nil
      ido-create-new-buffer 'always
      ido-enable-prefix nil
      ido-use-virtual-buffers t)
      
(set-default 'imenu-auto-rescan t)

;; Use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (if (and ido-use-virtual-buffers (fboundp 'ido-toggle-virtual-buffers))
      (ido-switch-buffer)
    (find-file (ido-completing-read "Open file: " recentf-list nil t))))

;; Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

(provide 'setup-ido)