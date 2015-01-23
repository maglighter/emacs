;;; Customize-group generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode c-mode cc-mode c++-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode less-css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode ts-mode sclang-mode verilog-mode qml-mode)))
 '(c-basic-offset 4)
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default)))
 '(ein:use-auto-complete t)
 '(ein:worksheet-enable-undo (quote full))
 '(electric-pair-inhibit-predicate (quote electric-pair-conservative-inhibit))
 '(elpy-default-minor-modes
   (quote
    (eldoc-mode flymake-mode highlight-indentation-mode)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-rpc-backend "rope")
 '(fci-rule-color "#383838")
 '(mpc-host "192.168.0.100:6600")
 '(nxml-child-indent 4)
 '(org-drill-optimal-factor-matrix nil)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-drill)))
 '(py-shell-name "ipython")
 '(py-tab-shifts-region-p t)
 '(py-underscore-word-syntax-p nil)
 '(rm-blacklist (quote (" hl-p" " Guide" " Undo-Tree")))
 '(sml/active-background-color "gray12")
 '(sml/inactive-background-color "gray24")
 '(sml/mode-width (quote full))
 '(sml/modified-char "+")
 '(sml/modified-time-string "Mod: %T %Y-%m-%d.")
 '(sml/name-width 40)
 '(sml/replacer-regexp-list
   (quote
    (("^~/org/" ":Org:")
     ("^~/\\.emacs\\.d/" ":ED:")
     ("^/sudo:.*:" ":SU:")
     ("^~/Documents/" ":Doc:")
     ("^~/Dropbox/" ":DB:")
     ("^:\\([^:]*\\):Documento?s/" ":\\1/Doc:")
     ("^~/[Gg]it/" ":Git:")
     ("^~/[Gg]it[Hh]ub/" ":Git:")
     ("^~/[Gg]it\\([Hh]ub\\|\\)-?[Pp]rojects/" ":Git:")
     ("^/data/Downloads/" ":Dls:")
     ("^/data/sandbox/" ":Sbx:")
     ("^~/src/" ":Src:"))))
 '(sml/show-eol t)
 '(sml/theme (quote respectful))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(which-func-modes (quote (c++-mode c-mode python-mode perl-mode java-mode))))

;; faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-foreground ((t (:foreground "gold"))))
 '(ein:cell-input-area ((t (:background "gray18"))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "chocolate"))))
 '(sml/modified ((t (:inherit sml/not-modified :background "Red" :foreground "White" :weight bold))))
 '(smld/modified ((t (:inherit sml/global :background "green4" :foreground "white" :weight bold))) t)
 '(which-func ((t (:foreground "gold"))) t))

;;; ===================================================================
