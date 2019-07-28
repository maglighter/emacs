;; Don't show splash screen
(setq inhibit-startup-screen t)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Minimal left, right fringe width size
(fringe-mode 6)

;; Scrolling settings
(setq scroll-conservatively 100000
      scroll-margin 3
      scroll-step 1
      mouse-wheel-follow-mouse 't
      mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Parens highlight
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; Parens insertion settings
(electric-pair-mode t)
(electric-indent-mode -1)
(electric-layout-mode t)

;; Show size of current file
(size-indication-mode t)

;; Set history length
(setq history-length 100)

;; Max size of messages log
(setq message-log-max 2000)

;; Yes -> y, No -> n, C-j -> return -> yes
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map (kbd "C-j") 'act)

;; Replace selected region
(delete-selection-mode t)

;; Indent settings
(setq-default tab-width          4)
(setq-default c-basic-offset     4)
(setq-default standart-indent    4)
(setq-default lisp-body-indent   4)
(setq lisp-indent-function  'common-lisp-indent-function)

;; Stop mix tabs and spaces
(setq-default indent-tabs-mode nil)

;; Set sentence end ". "
(setq sentence-end "[.?!][]\"’)]*\\($\\|\t\\| \\)[ \t\n]*")

;; Ignore case-sensitive with search
(setq case-replace nil)

;; Enable all disabled commands
(setq disabled-command-function nil)

;; Movement in words with different register
(global-subword-mode)

;; Cursor color
(set-cursor-color "#CCCCFF")

(provide 'appearence)

