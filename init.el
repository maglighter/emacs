;; Emacs Init File

;TODO: delete sml, ivy

;; startup benchmarking
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Adjust garbage collection thresholds during startup, and thereafter
(let ((init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold (* 20 1024 1024)))))

;; Don’t compact font caches during GC.
(setq inhibit-compacting-font-caches t)

;; Enables basic packaging support
(require 'package)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)
(package-initialize)
(setq package-enable-at-startup nil)

;; To correctly download packages
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Always load newest byte code
(setq load-prefer-newer t)

;; Turn off tool bar, menu bar, scroll bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Default font [old: Liberation Mono-12]
;(set-fontset-font "fontset-default" 'windows-1251 "Inconsolata LGC")
;(set-face-attribute 'default nil
;                    :family "Inconsolata LGC"
 ;                   :height 120
  ;                  :weight 'normal
   ;                 :width 'normal)

;; Add folders with elisp files to the load-path
(setq default-directory "~/")
(setq elpa-directory (expand-file-name "elpa" user-emacs-directory))
(add-to-list 'load-path
             (expand-file-name "site-lisp" user-emacs-directory))

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Keep emacs custom-settings in separate file
(setq custom-file (expand-file-name "site-lisp/custom.el" user-emacs-directory))
(load custom-file)

;; Load core appearence and behavior settings
(require 'appearence)

;; Package system settings
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
;(setq use-package-always-ensure t)

;; This package is useful for overriding major mode keybindings
(use-package bind-key)

;; Registers point to files
(set-register ?i (cons 'file (expand-file-name "init.el" user-emacs-directory)))
(set-register ?f (cons 'file (concat user-emacs-directory "/org/foo.org")))
(set-register ?j (cons 'file (concat user-emacs-directory "/org/java.org")))
(set-register ?z '(file . "/home/max/.zshrc"))

;; Encoding, default to utf-8
(set-language-environment "UTF-8")
(prefer-coding-system 'windows-1251)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(define-coding-system-alias 'windows-1251 'cp1251)
(setq default-input-method 'russian-computer)

;; Clipboard
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)
      x-select-enable-clipboard t
      save-interprogram-paste-before-kill t)

;; Browser
(setq browse-url-browser-function 'browse-url-chromium)

;;; ===================================================================
;;; Backup and history
(setq-default max/backup-directory "~/data/.emacs_backup/"
              backup-by-copying t
              backup-directory-alist
              `((".*" . ,(expand-file-name max/backup-directory)))
              auto-save-file-name-transforms
              `((".*", (expand-file-name (concat max/backup-directory "auto-save")) t))
              tramp-backup-directory-alist
              `((".*" . ,(expand-file-name max/backup-directory)))
              tramp-auto-save-directory (expand-file-name max/backup-directory)
              vc-make-backup-files t
              delete-old-versions t
              kept-new-versions 8
              kept-old-versions 2
              version-control t)
    
(defun force-backup-of-buffer ()
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook 'force-backup-of-buffer)

;; Savehist: save some history
(setq-default savehist-additional-variables
              '(kill-ring search-ring regexp-search-ring extended-command-history)
              savehist-autosave-interval 300
              savehist-file (concat max/backup-directory "savehist"))
(savehist-mode 1)

;;; ===================================================================


;;; Keys
;; Kill emacs process [v]
(global-set-key (kbd "C-x c") 'max/kill-emacs)

(defun max/focus-other-window-ace (prefix)
                                   (interactive "p")
                                  (if (= (count-windows) 1)
                                      (toggle-windows-split))
                                  (if (= prefix 1)
                                      (if (= (count-windows) 2) (other-window 1)
                                          (ace-window prefix))
                                      (if (= (count-windows) 2) (max/swap-windows)
                                          (ace-window prefix))))

;; Switch to next/previous window
(global-set-key (kbd "<C-tab>") 'max/focus-other-window-ace)

(setq aw-keys '(?a ?h ?d ?s ?f ?h ?j ?k ?l))

;; Use shell-like backspace C-h, rebind help to F1
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)

;; windows manipulations
(global-set-key (kbd "C-'") 'toggle-windows-split) ; [v]
(global-set-key (kbd "M-'")
		'(lambda ()
		   (interactive)
		   (if (= (count-windows) 1) (next-buffer) (delete-window))))
(global-set-key (kbd "C-M-'") 'kill-buffer-and-window)

;; switch to last selected buffer
(global-set-key (kbd "C-;") '(lambda ()
			       (interactive)
			       (switch-to-buffer (other-buffer))))

;; configure movement to begin/end of buffer
(global-set-key (kbd "M-<") 'tags-loop-continue)
(global-set-key (kbd "M->") 'find-tag)
(global-set-key (kbd "M-,") 'beginning-of-buffer)
(global-set-key (kbd "M-.") 'end-of-buffer)

;; transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
;(global-set-key (kbd "M-t p") 'transpose-params)

;; joins the following line onto this one
(global-set-key (kbd "M-j") 'max/smart-join-line)

;; when splitting window go to opened window
(global-set-key (kbd "C-x 2") 'max/split-window-vertically)
(global-set-key (kbd "C-x 3") 'max/split-window-horizontally)

;; switching between buffers
(global-set-key (kbd "C-.") 'ido-switch-buffer)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; move buffer at the end of the buffer-list
(global-set-key (kbd "C-c y") 'bury-buffer)

;; kill current buffer without request
(global-set-key (kbd "C-x k")
		'(lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "M-k")
		'(lambda () (interactive) (kill-buffer (current-buffer))))

;; replace default M-x behavior with some stuff of ido [v]
;(global-set-key (kbd "M-x") 'smex)
;(global-set-key (kbd "<print>") 'smex)
(global-set-key (kbd "<menu>") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;standart M-x
(global-set-key (kbd "C-c C-c <menu>") 'execute-extended-command)

;; first moves to indentation then to beginning [v]
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

;; replace by reqexp [E]
(define-key global-map (kbd "C-c r") 'vr/query-replace)
(define-key global-map (kbd "C-c q") 'vr/replace)

;; isearch with visual regexp
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward)  ;; C-M-s

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; if region - copy region, end of line - copy line, else copy to the end [v]
(global-set-key (kbd "M-w") 'max/kill-ring-save)
(define-key minibuffer-local-map
  (kbd "M-w") 'max/kill-ring-save)

;; search selection or kill line [v]
(global-set-key (kbd "C-k") 'max/eclipse-search-selected-region)

;; eval expression or region [v]
(global-set-key (kbd "C-x C-e") 'max/eval-last-expression-or-region)

;; translate current word or region [v]
(global-set-key (kbd "C-x t") 'max/translate-word-or-region)

;; menu with pointers to functions definitions
(global-set-key (kbd "M-[") 'helm-imenu)

;; shift+arrow to move between windows
(windmove-default-keybindings)

;; increase/decrease text scale
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; looks at the buffer and tries to expand word in various ways
(global-set-key (kbd "M-/") 'hippie-expand)

;; emacs process viewer
(global-set-key (kbd "C-x p") 'proced)

;; interactive lisp interpretor
(global-set-key [f6] 'ielm)

;; speedbar in same frame
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; enable god-mode
;(global-set-key (kbd "<print>") 'god-local-mode)

;; magnar's multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'set-rectangular-region-anchor)

;; Cycle through buffers 
(global-set-key (kbd "<C-M-tab>") 'next-buffer)
(global-set-key (kbd "<C-M-iso-lefttab>") 'previous-buffer)

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; zap-to-char rebind
(global-set-key (kbd "M-C-z") 'zap-to-char)

;; key-chord mode keys
(key-chord-define-global "xx" 'er/expand-region)
(key-chord-define-global "j1" 'delete-other-windows)
(key-chord-define-global "j2" 'max/split-window-vertically)
(key-chord-define-global "j3" 'max/split-window-horizontally)
(key-chord-define-global "j0" 'delete-window)

;; increment/decrement number at point
(global-set-key (kbd "C-c +") 'max/increment-number-decimal)
(global-set-key (kbd "C-c -") 'max/decrement-number-decimal)

;; swap buffers with drag and drop
(global-set-key (kbd "<C-S-drag-mouse-1>") #'max/swap-window-buffers-by-dnd)

;; move line up/down
(global-set-key (kbd "M-p") 'max/move-line-up)
(global-set-key (kbd "M-n") 'max/move-line-down)

;; Draw strokes with RMB
(global-set-key (kbd "<down-mouse-3>") 'strokes-do-stroke) 

;;; ===================================================================


;;; Aliases
(defalias 'cc 'calc)
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ee 'eval-expression)
(defalias 'gf 'grep-find) 		; find something with grep, recursive
(defalias 'hl 'highlight-lines-matching-regexp)
(defalias 'lm 'linum-mode)
(defalias 'man 'woman)
(defalias 'o 'occur)
(defalias 'mo 'multi-occur)
(defalias 'qr 'query-replace)
(defalias 'qrr 'query-replace-regexp)
(defalias 'rb 'revert-buffer)
(defalias 'sh 'shell-command)
(defalias 'wsm 'whitespace-mode)
(defalias 'df 'delete-current-buffer-file)
(defalias 'sw 'max/swap-windows)
(defalias 'rw 'max/rotate-windows)
(defalias 'rb 'revert-buffer)
(defalias 'wu 'winner-undo)
(defalias 'wr 'winner-redo)
(defalias 'bs 'bs-show)
;;; ===================================================================


;;; Modes
;; enable ido mode
(defun ido-vertical ()
  (setq ido-decorations default-ido-decorations)
  (define-key ido-completion-map (kbd "M-d")
    'smex-describe-function)
  (define-key ido-completion-map "\C-n"
    'ido-select-text)
  (define-key ido-completion-map "\C-j"
    'ido-exit-minibuffer)
  (define-key ido-completion-map "\C-p"
    'exit-minibuffer)
  (define-key ido-completion-map "\C-t"
    '(lambda ()
       (interactive)
       (if (equal default-ido-decorations ido-decorations)
           (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
         (setq ido-decorations default-ido-decorations)
         ))))

;; when pressed ~ go to home folder
(defun ido-go-home()
  ;; Go straight home
  (define-key ido-file-completion-map
    (kbd "~")
    (lambda ()
      (interactive)
      (if (looking-back "/")
          (insert "~/")
        (call-interactively 'self-insert-command)))))

(use-package ido
  :init
  (progn
    (setq-default ido-enable-flex-matching t
                  ido-everywhere t)
    (add-hook 'ido-setup-hook 'ido-vertical)
    (add-hook 'ido-setup-hook 'ido-go-home))
  :config
  (ido-mode t)
  (setq-default ido-enable-last-directory-history t
                ido-enable-work-directory-history t
                ido-max-work-directory-list 10
                ido-max-work-file-list 0
                ; ido-auto-merge-work-directories-length -1
                ido-save-directory-list-file
                (expand-file-name "temp/.ido.last" user-emacs-directory)
                default-ido-decorations ido-decorations
                ido-ignore-buffers '("\\` " "*GNU Emacs*" "*Messages*" "*Backtrace"
                                     "*Quail Com" "*Buffer" "*fsm-debug" "*Completions"
                                     "*helm mini" "*helm M-x" "^[tT][aA][gG][sS]$"))
  
  (use-package ido-completing-read+
    :ensure t
    :config 
    (ido-ubiquitous-mode 1)))

;; replace default M-x behavior with some stuff of ido
(setq smex-save-file (expand-file-name "temp/.smex-items" user-emacs-directory))

;; mode for listing of recent opened files
(use-package recentf
    :config
    (setq-default recentf-max-menu-items 50
                  recentf-max-saved-items 800
                  recentf-auto-cleanup 'never
                  recentf-save-file
                  (expand-file-name "temp/.recentf" user-emacs-directory))
    (recentf-mode t)
    (run-at-time 60 (* 10 60) (lambda () (interactive) (recentf-save-list))))

;; Default theme
(use-package doom-themes
    :ensure t
    :init (setq-default doom-vibrant-comment-bg t)
    :config
    (load-theme 'doom-vibrant t)
    (doom-themes-org-config))

;; change default mode line [configure]
;; (use-package smart-mode-line
;;     :config
;;     (setq-default sml/no-confirm-load-theme t)
;;     (sml/setup))

;; Mode-line
(use-package all-the-icons)
(use-package doom-modeline
  :custom
  (doom-modeline-minor-modes t)
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-icon t))


;; additional features to undo/redo system
(use-package undo-tree
    :config (global-undo-tree-mode 1))

;; mode for auto complete words [read more][E]
;; (use-package auto-complete
;;     :defer 3
;;     :init (setq-default ac-use-comphist nil
;;                       ac-comphist-file
;;                       (expand-file-name "temp/.ac-comphist.dat" user-emacs-directory))
;;     :config
;;     (ac-config-default)
;;     (global-auto-complete-mode t)
;;     (setq-default ac-expand-on-auto-complete nil
;;                   ac-delay 0.925
;;                   ac-auto-show-menu 0.25
;;                   ac-auto-start 2
;;                   ac-quick-help-delay 1.5
;;                   ac-ignore-case nil
;;                   ac-candidate-menu-min 2
;;                   ac-use-quick-help t
;;                   ac-limit 10
;;                   ac-disable-faces nil
;;                   ac-dwim nil
;;                   ac-sources '(ac-source-semantic
;;                                ac-source-variables
;;                                ac-source-functions
;;                                ac-source-imenu
;;                                ac-source-words-in-buffer
;;                                ac-source-words-in-same-mode-buffers
;;                                ac-source-files-in-current-dir
;;                                ac-source-dictionary
;;                                ac-source-filename)))
(use-package company
  :bind (:map company-active-map ("C-w" . nil))
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'python-mode-hook (lambda () (add-to-list 'company-backends 'company-jedi)))

  (setq-default company-tooltip-align-annotations t
                company-tooltip-limit 12
                company-idle-delay 0.8
                company-echo-delay (if (display-graphic-p) nil 0)
                company-minimum-prefix-length 1
                company-require-match nil
                company-dabbrev-ignore-case nil
                company-dabbrev-downcase nil))

;; draw documentation popups with kde
;(use-package popup-pos-tip)

; isearch configuration
(use-package isearch
    :ensure nil
    :bind
    (:map isearch-mode-map
          ("C-o" . (lambda () (interactive)
                           (let ((case-fold-search isearch-case-fold-search))
                               (occur (if isearch-regexp isearch-string
                                          (regexp-quote isearch-string))))))
          ("C-k" . isearch-repeat-forward)
          ("C-S-k" . isearch-repeat-backward))
    :init
    (setq-default
     isearch-allow-scroll t
     lazy-highlight-cleanup t
     lazy-highlight-initial-delay 0))

;; mode for opening and editing files with sudo privileges
;(use-package sudo-save)

;; auto revert buffer if file changed
(global-auto-revert-mode t)

;; restore window position
(use-package winner
    :config (winner-mode 1))

;; enables mode for execute commands by pressing two buttons simultaneously
(use-package key-chord
    :config
    (setq key-chord-one-key-delay 0.16)
    (key-chord-mode 1))
  
;; quick move cursor [E]
(use-package avy
    :bind ("M-z" . avy-goto-word-or-subword-1))

;; Maggit - git interface
(use-package magit
    :commands (magit-status magit-push))

;; EMMS configuration
(use-package emms-setup
    :commands (emmss emms-play-url emms-play-file emms-play-dired)
    :config
    (emms-standard)
    (emms-default-players))

;; Show available keys
(use-package which-key
    :init (which-key-mode))

;; god mode
(use-package god-mode
    :bind (("<print>" . god-local-mode)
           :map god-local-mode-map
           ("h" . backward-delete-char)))

;; Dired
(use-package dired
    :bind (("C-x C-j" . dired-jump)
           :map dired-mode-map
                ("<down-mouse-3>" . nil)
                ("!" . max/sudo-dired))
    :config
    (setq-default dired-listing-switches "-aBhl  --group-directories-first"
                  dired-dwim-target t)

    (add-hook 'dired-mode-hook #'dired-hide-details-mode)
    (add-hook 'dired-mode-hook 
              (lambda () (define-key dired-mode-map (kbd "<tab>")
                             (lambda () (interactive) (find-alternate-file "..")))))
    
    (use-package dired-x
        :config
            (setq-default dired-omit-verbose nil
                          dired-guess-shell-gnutar "gtar"
                          dired-x-hands-off-my-keys nil
                          dired-recursive-deletes 'always
                          dired-recursive-copies 'always)
            ;; hide backup, autosave, *.*~ files
            ;; omit mode can be toggled using `M-o' in dired buffer
            (add-hook 'dired-mode-hook #'dired-omit-mode)))

;; Org-mode
(use-package org
    :defer 4
    :hook (org-mode . (lambda() (visual-line-mode) (org-indent-mode)))
    :bind (:map org-mode-map
                ("C-<tab>" . nil)
                ("C-'" . nil)
                ("C-," . nil)
                ("C-c a" . org-agenda))
    :config
    (setq-default org-agenda-files (quote ("~/.emacs.d/org/"))
          org-log-done 'time
          org-startup-indented t
          org-catch-invisible-edits 'error
          calendar-week-start-day 1
          org-ellipsis "⤵")
    (add-function :after after-focus-change-function 'org-save-all-org-buffers)

    ;; Prettify UI
    (use-package org-bullets
        :if (char-displayable-p ?⚫)
        :hook (org-mode . org-bullets-mode))

    (use-package org-drill)
    
    (use-package org-download
        :config
        (setq-default org-download-image-dir "~/.emacs.d/org/attachments")))

;; Yasnippets
(use-package yasnippet
    :hook (prog-mode . yas/minor-mode))

;; Rainbow Delimiters
(use-package rainbow-delimiters
    :hook (prog-mode . (lambda ()
                           (rainbow-delimiters-mode)
                           (setq rainbow-delimiters-outermost-only-face-count 1)
                           (set-face-attribute 'rainbow-delimiters-depth-1-face nil
                                               :foreground 'unspecified
                                               :inherit 'my-outermost-paren-face))))

;; Helm
(use-package helm
    :ensure helm
    :bind (("M-x" . helm-M-x)
           ("C-," . helm-mini))
    :config
    (progn
        (use-package helm-config)
        ;; From https://gist.github.com/antifuchs/9238468
        (setq-default helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
              helm-input-idle-delay 0.01  ; this actually updates things
              ; reeeelatively quickly.
              helm-quick-update t
              helm-candidate-number-limit 100
              helm-M-x-requires-pattern nil
              helm-ff-skip-boring-files t
              helm-M-x-fuzzy-match t)))

(use-package projectile
  :bind (:map projectile-mode-map
         ("s-t" . projectile-find-file)) ; `cmd-t' or `super-t'
  :hook (after-init . projectile-mode)
  :init
  (setq-default projectile-keymap-prefix (kbd "C-c p")
                projectile-mode-line-prefix ""
                projectile-sort-order 'recentf
                projectile-use-git-grep t
                projectile-completion-system 'helm
                projectile-indexing-method 'alien)
  :config
  ;; (projectile-update-mode-line)         ; Update mode-line at the first time

  ;; Use the faster searcher to handle project files: ripgrep `rg'.
  (when (and (not (executable-find "fd"))
             (executable-find "rg"))
    (setq projectile-generic-command
          (let ((rg-cmd ""))
            (dolist (dir projectile-globally-ignored-directories)
              (setq rg-cmd (format "%s --glob '!%s'" rg-cmd dir)))
            (concat "rg -0 --files --color=never --hidden" rg-cmd)))))

(use-package helm-projectile)

;; show all keybindings in helm
(use-package helm-descbinds
    :after helm
    :bind (("C-h b" . helm-descbinds)
           ("C-h w" . helm-descbinds)))

;; setting engine for vr
(use-package visual-regexp-steroids)

;; highlights changes: undo, yank, kill line, ...
(use-package volatile-highlights
    :config (volatile-highlights-mode t))

(use-package ace-window)

(use-package golden-ratio
    :ensure t
    :diminish golden-ratio-mode
    :config
    (golden-ratio-mode 1)
    (add-to-list 'golden-ratio-extra-commands 'max/focus-other-window-ace))

;; calculator mode
;; (use-package calc-mode
;;     :init
;;     (progn (setq calc-float-format '(fix 12))
;;            (setq calc-full-float-format '(fix 12))
;;            (message "ccc")))

;; terminal
(use-package term
    :bind (("C-c t" . term)
           :map term-mode-map
           ("M-p" . term-send-up)
           ("M-n" . term-send-down)
           :map term-raw-map
           ("C-x" . nil)
           ("C-x k" . kill-current-buffer)
           ("C-<tab>" . other-window)
           ("M-p" . term-send-up)
           ("M-n" . term-send-down))
    :config (progn (setq-default explicit-shell-file-name "/usr/bin/zsh")))

;; ripgrep replaces ag, grep
(use-package rg
    :commands rg)

;; big files open
(use-package vlf)
(use-package vlf-setup
  :ensure nil
  :after vlf)

;; documentaion using helm-dash
(use-package dash-docs
    :config
    (setq-default dash-docs-common-docsets
                  '("Python 3" "Spring Framework" "Java")))

;;; ===================================================================


;;; Functions
;; kill emacs process [C-x c] 
(defun max/kill-emacs ()
  (interactive)
  (recentf-save-list)
  (save-some-buffers)
  (kill-emacs))

;; split window vertically and jump to opened window
(defun max/split-window-vertically (prefix)
    (interactive "p")
    (split-window-vertically)
    (other-window 1 'nil)
    (if (= prefix 1)
        (switch-to-next-buffer)))

;; split window horizontally and jump to opened window
(defun max/split-window-horizontally (prefix)
    (interactive "p")
    (split-window-horizontally)
    (other-window 1 'nil)
    (if (= prefix 1)
        (switch-to-next-buffer)))

;; edit system files with root privileges
(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file
       (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file
     (concat "/sudo:root@localhost:" buffer-file-name))))

;; kill backward word
(defun backward-kill-word-or-kill-region (arg)
  (interactive "p")
  (if (region-active-p)
      (kill-region (region-beginning)
		   (region-end))
    (backward-kill-word arg)))

(global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)

(define-key minibuffer-local-map
  (kbd "C-w") 'backward-kill-word-or-kill-region)

(add-hook 'ido-setup-hook
	  (lambda ()
	    (define-key ido-completion-map
	      (kbd "C-w") 'ido-delete-backward-word-updir)))

;; first moves to indentation then to beginning [C-a]
(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

;; toggle between split windows and a single window
(defun toggle-windows-split()
  "Switch back and forth between one window and whatever split of
windows we might have in the frame. The idea is to maximize the
current buffer, while being able to go back to the previous split
of windows in the frame simply by calling this command again."
  (interactive)
;  (let ((current-point (point)))
  (if (not (window-minibuffer-p (selected-window)))
      (progn
        (if (< 1 (count-windows))
            (progn
              (window-configuration-to-register '_)
              (delete-other-windows))
	  (progn
	    (let ((current-point (point))
                  (current-buff-name (current-buffer)))
	    (jump-to-register '_)
	    (goto-char current-point)
            (switch-to-buffer current-buff-name)))))))

;; if region copy region, end of line, select line, else select to the end [M-w]
(defun max/kill-ring-save (arg)
  (interactive "p")
  (if (region-active-p)
      (kill-ring-save (region-beginning)
		      (region-end))
    (if (= (point) (line-end-position))
	(progn 
	  (back-to-indentation-or-beginning)
	  (set-mark-command nil) 
	  (move-end-of-line nil)
	  (setq deactivate-mark nil))
      (progn (set-mark-command nil) 
	     (move-end-of-line nil)
	     (setq deactivate-mark nil)))))

;; if selected search seelection, or delete line [C-k]
(defun max/eclipse-search-selected-region (arg)
  (interactive "p")
  (if (region-active-p)
      (let ((region (funcall region-extract-function nil)))
          (deactivate-mark)
          (isearch-mode t nil nil nil)
          (isearch-yank-string region))
      (progn (kill-line))))

;; if last command wasn't yank -> show kill ring [E]
(defadvice yank-pop (around kill-ring-browse-maybe (arg))
  "If last action was not a yank, run `helm-show-kill-ring' instead."
  (if (not (eq last-command 'yank))
      (helm-show-kill-ring)
    ad-do-it))

(ad-activate 'yank-pop)

;; show line numbers when goto-line [M-g M-g]
(global-set-key [remap goto-line] 'goto-line-with-feedback)
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

;; delete file which conected to current buffer
(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;; dissable some stuff on files with big size
(defun max/large-file-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (font-lock-mode -1)
    (fundamental-mode)))

(add-hook 'find-file-hooks 'max/large-file-hook)

;; swap windows
(defun max/swap-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun max/rotate-windows ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;; eval expression or region [C-x C-e]
(defun max/eval-last-expression-or-region (arg)
  (interactive "P")
  (if (region-active-p)
      (eval-region (region-beginning) (region-end))
    (progn
      (move-end-of-line 1)
      (eval-last-sexp arg))))

;; translate current word or region [C-x t]
(defun max/translate-word-or-region (arg)
  (interactive "p")
  (let ((myStr) (translate))
    (if (region-active-p)
	(setq myStr (buffer-substring (region-beginning) (region-end)))
      (setq myStr (thing-at-point 'word)))
    (append-to-file (concat myStr "\n") nil "/data/sandbox/words_for_anki")
    (setq translate (shell-command-to-string
      (concat (expand-file-name "site-lisp/non-lisp/translate_arg" user-emacs-directory) " \"" myStr "\"")))
    (message "%s" (substring translate 0 (- (length translate) 1)))))

(setq max/java-url-or-path "/usr/share/doc/java8-openjdk/api/")
(setq max/python-url-or-path "file:///usr/share/doc/python/html/library/")
;(setq max/python-url-or-path "https://docs.python.org/3/library/")

(defun max/read-lines (file)
  "Return a list of lines in FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (split-string
     (buffer-string) "\n" t)
    ))

(defun max/show-python-module-doc (arg)
  "Show documentation of Python module in w3m or with C-u in browser"
  (interactive "p")
  (let ((class-name) (class-list))
    (setq class-list (max/read-lines "~/.emacs.d/temp/python-modules-names"))
    (setq module (downcase (ido-completing-read
                                    "Select module: " class-list)))
    (let ((url (concat max/python-url-or-path module
                          ".html#module-" module)))
         (if (= arg 4)
             (browse-url url)
           (w3m-goto-url-new-session url)))))

(defun  max/show-java-class-doc (arg)
  "Show documentation of Java class in w3m or with C-u in browser"
  (interactive "p")
  (with-temp-buffer
    (insert-file-contents "~/.emacs.d/temp/class-names-list-file-java")
    (let (Hash) (list)
         (setq list (split-string (buffer-string) "\n" t))
         (setq Hash (make-hash-table :test 'equal))
         (mapc (lambda (x)
                 (puthash
                  (car (split-string x " ")) 
                  (nth 1 (split-string x " ")) Hash)) list)
         (let (url)
           (setq url
                 (concat max/java-url-or-path
                         (gethash
                          (ido-completing-read "Select class: "
                                               (let (allkeys)
                                                 (maphash
                                                  (lambda (kk vv)
                                                    (setq allkeys (cons kk allkeys)))
                                                  Hash) allkeys)) Hash)))
           (if (= arg 4)
               (browse-url url)
             (w3m-goto-url-new-session url))))))

;; convert buffer: dos -> unix (utf-8)
(defun max/dos2unix ()
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix))

;; delete very long lines in the buffer
(defun max/delete-long-lines ()
  (interactive)
  (while (not (= (point) (point-max)))
    (next-line)
    (move-end-of-line 1)
    (if (> (current-column) 1000)
	(let ((beg (point)))
	  (forward-line 0)
	  (delete-region (point) beg)))))

(defun max/increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun max/decrement-number-decimal (&optional arg)
  (interactive "p*")
  (max/increment-number-decimal (if arg (- arg) -1)))

;; Open the current file or dired marked files in external app
(defun max/open-in-external-app (&optional file)
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           ((not file) (list (buffer-file-name)))
           (file (list file)))))
    (setq doIt (if (<= (length myFileList) 5) t
                 (y-or-n-p "Open more than 5 files? ") ) )
    
    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList))
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath)) ) myFileList))))))

;; open current dired directory with root privileges
(defun max/sudo-dired ()
  (interactive)
  (require 'tramp)
  (let ((dir (expand-file-name default-directory)))
    (if (string-match "^/sudo:" dir)
        (user-error "Already in sudo")
      (dired (concat "/sudo::" dir)))))

;; swap buffers with drag and drop
(defun max/swap-window-buffers-by-dnd (drag-event)
  "Swaps the buffers displayed in the DRAG-EVENT's start and end
window."
  (interactive "e")
  (let ((start-win (cl-caadr drag-event))
        (end-win   (cl-caaddr drag-event)))
    (when (and (windowp start-win)
               (windowp end-win)
               (not (eq start-win end-win))
               (not (memq (minibuffer-window)
                          (list start-win end-win))))
      (let ((bs (window-buffer start-win))
            (be (window-buffer end-win)))
        (unless (eq bs be)
          (set-window-buffer start-win be)
          (set-window-buffer end-win bs))))))

;; move linues up/down
(defun max/move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun max/move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun max/smart-join-line (beg end)
    "If in a region, join all the lines in it. If not, join the current line with the next line. [M-j]"
    (interactive "r")
    (if mark-active
        (if mark-active
            (let ((beg (region-beginning))
                  (end (copy-marker (region-end))))
                (goto-char beg)
                (while (< (point) end)
                    (join-line 1))))
        (delete-indentation 1)))

;;; ===================================================================


;;; Eshell
(use-package eshell
    :commands (eshell max/eshell)
    :bind ("C-x m" . max/eshell)
    :config (setq-default eshell-history-size 99999
                          eshell-history-file-name "/home/max/.histfile"
                          eshell-cmpl-cycle-completions nil
                          ehsell-save-history-on-exit t
                          eshell-cmpl-dir-ignore
                          "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'"))

(eval-after-load 'esh-opt
  '(progn
     (require 'em-prompt)
     (require 'em-term)
     (require 'em-cmpl)
     (setenv "PAGER" "cat")
     (set-face-attribute 'eshell-prompt nil :foreground "turquoise1")
     (when (< emacs-major-version 23)
       (add-hook 'eshell-mode-hook
		 '(lambda ()
		    (define-key eshell-mode-map "\C-a" 'eshell-bol)))
       (add-to-list 'eshell-output-filter-functions
		    'eshell-handle-ansi-color))

     ;; TODO: submit these via M-x report-emacs-bug
     (add-to-list 'eshell-visual-commands "ssh")
     (add-to-list 'eshell-visual-commands "tail")
     (add-to-list 'eshell-command-completions-alist
		  '("gunzip" "gz\\'"))
     (add-to-list 'eshell-command-completions-alist
		  '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\)\\'"))))

(defun eshell/cds ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory "src")))

(defun eshell/find (dir &rest opts)
  (find-dired dir (mapconcat 'identity opts " ")))


(defun max/eshell ()
  (interactive)
  (let ((buffer (file-name-directory (buffer-file-name))))
    (eshell)
    (if (not (equal (concat (eshell/pwd) "/") buffer))
        (progn
          (insert (concat "pwd; cd " buffer))
          (eshell-send-input)))))

;;; ===================================================================


;;; Lisp
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (turn-on-eldoc-mode)
            (define-key lisp-interaction-mode-map  (kbd "C-j") 'newline)
            (define-key lisp-interaction-mode-map
                (kbd "C-m") 'eval-print-last-sexp)))
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'max/lisp-settings)
(add-hook 'emacs-lisp-mode-hook 'max/lisp-settings)

(defun max/lisp-settings()
  (add-hook 'after-save-hook 'check-parens nil t)
  (turn-on-eldoc-mode)
  (setq lisp-indent-function 'common-lisp-indent-function))
;;; ===================================================================


;;; Cpp/C
(c-add-style "max/custom-style" 
             '("bsd"
               (indent-tabs-mode . nil)        ; use spaces rather than tabs
               (c-continued-statement-offset 8)
               (c-basic-offset . 4)            ; indent by four spaces
               (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
                                   (brace-list-open . 0)
                                   (statement-case-open . +)))))

(add-hook 'c++-mode-hook (lambda ()
                             (c-set-style "max/custom-style")
                             (use-package flycheck)
                             (flycheck-mode)))

(add-hook 'c-mode-hook (lambda ()
                           (c-set-style "max/custom-style")
                           (use-package flycheck)
                           (flycheck-mode)))

;;; ===================================================================


;;; Perl
(defalias 'perl-mode 'cperl-mode)
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

(defun max/perl-mode-hook ()
  ;; (setq tab-width 2)
  (local-set-key [return] 'newline-and-indent)
  (abbrev-mode 1)
  (turn-on-eldoc-mode)
  (cperl-set-style "CPerl")
;  (cperl-mode)
  (setq compile-command (concat "perl -cw " buffer-file-name))
  )
(add-hook 'cperl-mode-hook 'max/perl-mode-hook)

(setq cperl-auto-newline-after-colon nil)
(setq cperl-autoindent-on-semi t)
(setq cperl-extra-newline-before-brace t)
(setq cperl-indent-parens-as-block t)

(defun max/perl-new-source (name)
  (interactive "sEnter new perl source file name: ")
  (find-file (concat "/home/max/src/perl/" name))
  (insert "#!/usr/bin/perl -w\n")
  (cperl-mode)
  (save-buffer)
  (shell-command (concat "chmod +x " name)))
;;; ===================================================================

;;; Python
(use-package ein
    :config
    (progn
        (setq ein:notebook-modes '(ein:notebook-mumamo-mode ein:notebook-python-mode))
        (add-hook 'ein:notebook-mode-hook (lambda ()
                              (define-key ein:notebook-mode-map (kbd ".") 'nil)))
        (add-hook 'elpy-mode-hook (lambda ()  
                              (define-key elpy-mode-map (kbd "C-c C-c") 'nil)
                              (define-key elpy-mode-map (kbd "C-c C-b") 'nil)
                              (define-key elpy-mode-map (kbd "C-c C-n") 'nil)
                              (define-key elpy-mode-map (kbd "C-c C-p") 'nil)))))

;; (use-package python
;;   :mode ("\\.py\\'" . python-mode)
;;   :interpreter ("python" . python-mode)
;;   :config
;;   (progn
;;     ; (use-package info-look)
;;     ; (use-package flycheck)
;;     ;; (use-package elpy
;;     ;;   :config
;;     ;;   (progn (define-key elpy-mode-map  (kbd "M-.") 'nil)
;;     ;;          (define-key elpy-mode-map  (kbd "C-c C-j") 'elpy-goto-definition)
;;     ;;          (add-hook 'ein:multilang-mode-hook (lambda () (configure-ein)))
;;     ;;          (setq elpy-disable-backend-error-display t)
;;     ;;          (elpy-use-ipython)))
;;     ;; (elpy-enable)
;;     (eldoc-mode -1)
;;     (use-package company-backends)
;;     (use-package company-jedi)
;;     (use-package company-quickhelp
;;         :config (company-quickhelp-mode 1))
;;     ;; (setq ipython-completion-command-string
;;     ;;       "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n"
;;     ;;       ; py-electric-colon-newline-and-indent-p t
;; 	;;   ; switch to the interpreter after executing code
;;     ;;       py-shell-switch-buffers-on-execute-p t
;;     ;;       py-switch-buffers-on-execute-p t
;; 	;;   ; don't split windows
;;     ;;       py-split-windows-on-execute-p nil)
    
;;     ;; F1-S - look in info documentation
;;     ;; (info-lookup-add-help
;;     ;;  :mode 'python-mode
;;     ;;  :regexp "[[:alnum:]_]+"
;;     ;;  :doc-spec
;;     ;;  '(("(python)Index" nil "")))
;;   ))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;            (define-key company-mode-map (kbd "M-h") 'company-show-doc-buffer)
;            (define-key company-mode-map (kbd "C-w") nil)))

;; (add-hook 'python-mode-hook (lambda () (flycheck-mode)))

(defun max/music-tools-save-and-run ()
  (interactive)
  (save-buffer)
  (eshell)
  (insert "(async-shell-command \"wmctrl -Fc 'Music Tools' ; pyuic4 qt_mt.ui -o ui_main_window.py && ./qt_music_tools.py \")")
  (eshell-send-input)
  (lambda nil (interactive) (switch-to-buffer
                             (other-buffer))))

;;; ===================================================================


;;; PHP
(add-hook 'php-mode-hook 
	  (lambda ()
            ;; Toggle between PHP & HTML Helper mode.  Useful when working on
            ;; php files, that can been intertwined with HTML code
            (c-set-style "bsd")
            (setq c-basic-offset 4)
            
            (defun toggle-php-html-mode ()
              (interactive)
              "Toggle mode between PHP & HTML Helper modes"
              (cond ((string= mode-name "HTML helper")
                     (php-mode))
                    ((string= mode-name "PHP")
                     (html-helper-mode))))

            (global-set-key [f5] 'toggle-php-html-mode)
            (local-set-key (kbd "C-.") nil)
            ))



;;; Test code
(setq toe-treat-words 'downcase)

;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like 
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
  (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------


;; E - elpa
; paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

(use-package erc
  :defer 4
  :config
  (setq erc-autojoin-channels-alist '(("freenode.net"
         "#org-mode"
         "#hacklabto"
         "#emacs"))
  erc-server "irc.freenode.net"
  erc-nick "maglight"))
