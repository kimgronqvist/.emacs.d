(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "90bd0eb20a1cb155b5a076f698b3c72cfe775aa7ea93b7bfbc171eb250db5e20" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "10e3d04d524c42b71496e6c2e770c8e18b153fcfcc838947094dad8e5aa02cef" "4182c491b5cc235ba5f27d3c1804fc9f11f51bf56fb6d961f94788be034179ad" "5310b88333fc64c0cb34a27f42fa55ce371438a55f02ac7a4b93519d148bd03d" "b378249b7f647796b186c70f61eaaee7aa1bd123681d5ca8c44d3ca8875e1b70" "a6e5edd129bc48c9540ab6ed4a76a2e4e0da6359e981a3ec0bffbeb4416d4cc9" "e91ca866d6cbb79786e314e0466f4f1b8892b72e77ed702e53bf7565e0dfd469" "9d1df5b65ccacca5d4dba470f2ae7138ac26a0c3878b782be4a1206312491300" "3a651bfd6708cd2995c6f9b50146e890e06419d445980a7cdc095af245899aa7" "b00752c0281b9671076d9a7448a0b063b0c420f15756503a8c4f80eb115bb56c" "fa197eae8396863c1ce30faaa5df2eca6449f86fd43506ade97076a85d327753" "ef479623c75026d8ba1de98a8cb74198f6f3eedc6fca509990ac2559ba830675" "2601b6cb623a44e906f61d42685dfc1ad2d06c7906088856b5e780af3a1b5036" "398f0209bfd642cf7a5e3e03bdc20db2822fd6746225a4bd99ccf9b26d3059d0" "16241cf61a64014901a8dfb661cff9e5d9702f743f4e888c26de8c92267242d6" "9f3181dc1fabe5d58bbbda8c48ef7ece59b01bed606cfb868dd147e8b36af97c" "06dbcfac3705aaaa79e1a3264c6fd44ef0cf86ef5ed67930e4007e63a8c1e8ee" "84a0e9f3a2e3c239bcbfc5bdbd7c2ddd73e029948d47e1b14d955a0f72e78f80" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "elpa" "node_modules")))
 '(grep-find-ignored-files
   (quote
    (".#*" "*.o" "*~" "*.bin" "*.bak" "*.obj" "*.map" "*.ico" "*.pif" "*.lnk" "*.a" "*.ln" "*.blg" "*.bbl" "*.dll" "*.drv" "*.vxd" "*.386" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.cache")))
 '(package-selected-packages
   (quote
    (helm-projectile projectile rjsx-mode fontawesome sml-mode indium graphql-mode clj-refactor cider dashboard fsharp-mode helm-descbinds neotree company doom-themes helm-flycheck tide whitespace-cleanup-mode spaceline jade csharp-mode which-key wgrep use-package undo-tree tagedit smooth-scrolling smartparens scss-mode restclient rainbow-mode pt move-text material-theme markdown-mode magit less-css-mode json-mode js2-refactor ignoramus idomenu ibuffer-vc hydra highlight-symbol helm-swoop helm-css-scss helm-ag flycheck f expand-region css-eldoc company-tern anzu ace-window)))
 '(safe-local-variable-values
   (quote
    ((eval progn
           (add-to-list
            (quote grep-find-ignored-directories)
            "bundle")
           (dolist
               (item
                (list "*.txt" "*.xml"))
             (add-to-list
              (quote grep-find-ignored-directories)
              item)))
     (eval progn
           (add-to-list
            (quote exec-path)
            (concat
             (locate-dominating-file default-directory ".dir-locals.el")
             "Code/ServerHtml5/Web/node_modules/.bin/"))
           (add-to-list
            (quote grep-find-ignored-directories)
            "bundle")
           (dolist
               (item
                (list "*.txt" "*.xml"))
             (add-to-list
              (quote grep-find-ignored-directories)
              item)))
     (eval progn
           (add-to-list
            (quote exec-path)
            (concat
             (locate-dominating-file default-directory ".dir-locals.el")
             "Code/ServerHtml5/Web/node_modules/.bin/"))))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))
