;;; Customize-group generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ido-completing-read+ org-download logview k8s-mode doom-modeline ranger helm-config dired-x dired emms-setup sudo-save popup-pos-tip helm-projectile projectile windresize which-key volatile-highlights vlf visual-regexp-steroids use-package undo-tree typing smex smart-mode-line skewer-mode shell-pop rg rect-mark recentf-ext rainbow-mode rainbow-delimiters python-mode pymacs pylint php-mode paredit org-drill org-bullets nov nose neotree multiple-cursors monokai-theme memory-usage markdown-mode magit key-chord jabber isearch+ info+ iedit idomenu hydra help-mode+ help-fns+ help+ helm-descbinds helm-dash golden-ratio god-mode go-mode git-rebase-mode git-commit-mode fuzzy fringe-helper frame-cmds flymake-cursor flymake find-file-in-project expand-region esup elpy ein doom-themes dedicated csv-mode company-quickhelp company-jedi attrap ascii ace-window ac-python)))

;; faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(deftheme max-custom-theme
  "Created 2015-01-24.")

(custom-theme-set-variables
 'max-custom-theme
 '(ac-modes (quote (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode c-mode cc-mode c++-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode less-css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode ts-mode sclang-mode verilog-mode qml-mode)))
 '(c-basic-offset 4)
 '(custom-safe-themes (quote ("c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default)))
 '(electric-pair-inhibit-predicate (quote electric-pair-conservative-inhibit))
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-drill)))
 '(rm-blacklist (quote (" hl-p" " Guide" " Undo-Tree")))
 '(sml/mode-width (quote full))
 '(sml/modified-char "+")
 '(sml/modified-time-string "Mod: %T %Y-%m-%d.")
 '(sml/name-width 40)
 '(sml/replacer-regexp-list (quote (("^~/org/" ":Org:") ("^~/\\.emacs\\.d/" ":ED:") ("^/sudo:.*:" ":SU:") ("^~/Documents/" ":Doc:") ("^~/Dropbox/" ":DB:") ("^:\\([^:]*\\):Documento?s/" ":\\1/Doc:") ("^~/[Gg]it/" ":Git:") ("^~/[Gg]it[Hh]ub/" ":Git:") ("^~/[Gg]it\\([Hh]ub\\|\\)-?[Pp]rojects/" ":Git:") ("^/data/Downloads/" ":Dls:") ("^/data/sandbox/" ":Sbx:") ("^~/src/" ":Src:"))))
 '(sml/show-eol t)
 '(sml/theme (quote dark)))

(custom-theme-set-faces
 'max-custom-theme
 '(ace-jump-face-foreground ((t (:foreground "gold"))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "chocolate"))))
 '(sml/modified ((t (:inherit sml/not-modified :background "Red" :foreground "White" :weight bold))))
 '(smld/modified ((t (:inherit sml/global :background "green4" :foreground "white" :weight bold))))
 '(which-func ((t (:foreground "gold")))))

(provide-theme 'max-custom-theme)

;;; ===================================================================
