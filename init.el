;                      * Emacs CORE configuration file *

;; load common lisp (loop)
(require 'cl)

;; default font
(add-to-list 'default-frame-alist
	     '(font . "Liberation Mono-12"))
(package-initialize)

;; add directory with elisp files to the load-path
(add-to-list 'load-path "/home/max/.emacs.d/site-lisp/")

;; packages repository
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; turn off: hide tool bar & menu bar & scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; color theme loading
;(load-theme 'wombat)

;; don't show startup screen
(setq inhibit-startup-screen t)

;; set history length
(setq history-length 100)

;; max size of messages log
(setq message-log-max 2000)

;; yes -> y, no -> n, C-j -> return -> yes
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map (kbd "C-j") 'act)

;; registers point to files
(set-register ?i '(file . "/home/max/.emacs.d/init.el"))
(set-register ?f '(file . "/home/max/.emacs.d/foo.org"))
(set-register ?z '(file . "/home/max/.zshrc"))

;; replacement of selected region
(delete-selection-mode t)

;; scrolling settings
(setq scroll-conservatively 10000
      scroll-margin 2
      scroll-step 1
      mouse-wheel-follow-mouse 't
      mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; on't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; brackets highlight
(show-paren-mode 1)

;; brackets settings
(setq skeleton-pair t)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)

;; enable all disabled commands
(setq disabled-command-function nil)

;; set sentence end ". "
(setq sentence-end "[.?!][]\"’)]*\\($\\|\t\\| \\)[ \t\n]*")

;; ignore case-sensitive with search
(setq case-replace nil)

;; minimal left, right fringe width size
(fringe-mode 4)

;; encoding, default to utf-8
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(define-coding-system-alias 'windows-1251 'cp1251)
(setq default-input-method 'russian-computer)

;; clipboard
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(setq x-select-enable-clipboard t)
(setq save-interprogram-paste-before-kill t)

;; show function name
;(which-func-mode t)
;;; ===================================================================


;;; Backup and history
(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "/data/.emacs_backup/"))
 auto-save-file-name-transforms
 '((".*" "/data/.emacs_backup/" t))
 vc-make-backup-files t
 delete-old-versions t
 kept-new-versions 8
 kept-old-versions 2
 version-control t)

(defun force-backup-of-buffer ()
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook 'force-backup-of-buffer)

(setq savehist-file "/data/.emacs_backup/savehist")
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring))
(savehist-mode 1)

;;; ===================================================================


;;; Keys
;; kill emacs process [v]
(global-set-key (kbd "C-x c") 'max/kill-emacs)

;; switch to next/previous window
(global-set-key (kbd "<C-tab>") 'other-window)

;; use shell-like backspace C-h, rebind help to F1
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
(global-set-key (kbd "M-t p") 'transpose-params)

;; joins the following line onto this one
(global-set-key (kbd "M-j") (lambda() (interactive)(join-line -1)))

;; switching between buffers
(global-set-key (kbd "C-.") 'ido-switch-buffer)

;; list of recent opened files
(global-set-key (kbd "C-,") 'recentf-ido-find-file)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; move buffer at the end of the buffer-list
(global-set-key (kbd "C-c y") 'bury-buffer)

;; kill current buffer without request
(global-set-key (kbd "C-x k")
		'(lambda () (interactive) (kill-buffer (current-buffer))))

;; replace default M-x behavior with some stuff of ido [v]
(global-set-key (kbd "M-x") 'smex)
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

;; quick move cursor [v][E]
(define-key global-map (kbd "M-z") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; if region - copy region, end of line - copy line, else copy to the end [v]
(global-set-key (kbd "M-w") 'max/kill-ring-save)
(define-key minibuffer-local-map
  (kbd "M-w") 'max/kill-ring-save)

;; eval expression or region [v]
(global-set-key (kbd "C-x C-e") 'max/eval-last-expression-or-region)

;; translate current word or region [v]
(global-set-key (kbd "C-x t") 'max/translate-word-or-region)

;; join current line with above
;(global-set-key (kbd "C-c q") 'join-line)

;; menu with pointers to functions definitions
(global-set-key (kbd "M-[") 'ido-imenu)

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

;; connect to slime [v SLIME]
(global-set-key [f5] 'slime)
(global-set-key [(control f5)] 'slime-selector)

;; speedbar in same frame
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; enable god-mode
(global-set-key (kbd "<print>") 'god-local-mode)

;; magnar's multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'set-rectangular-region-anchor)
 
;; key-chord mode keys
(key-chord-define-global "q]" 'ace-jump-buffer)
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
(setq
 ido-enable-flex-matching t
 ido-enable-last-directory-history t
 ido-enable-work-directory-history t
 ido-max-work-directory-list 10
 ido-max-work-file-list 0
 ido-save-directory-list-file "~/.emacs.d/temp/.ido.last")
(ido-mode t)
(setq default-ido-decorations ido-decorations)
(add-hook 'ido-setup-hook
          (lambda ()
	    (setq ido-decorations default-ido-decorations)
	    (define-key ido-completion-map (kbd "M-d")
	      'smex-describe-function)
            (define-key ido-completion-map "\C-n"
              'ido-select-text)
	    (define-key ido-completion-map "\C-j"
              'ido-exit-minibuffer)
	    (define-key ido-completion-map "\C-t"
              '(lambda ()
		(interactive)
		 (if (equal default-ido-decorations ido-decorations)
		     (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
		  (setq ido-decorations default-ido-decorations)
		  )))))

;; when pressed ~ go to home folder
(add-hook 'ido-setup-hook
 (lambda ()
   ;; Go straight home
   (define-key ido-file-completion-map
     (kbd "~")
     (lambda ()
       (interactive)
       (if (looking-back "/")
           (insert "~/")
         (call-interactively 'self-insert-command))))))

;; Use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))
(ido-ubiquitous-use-new-completing-read webjump 'webjump)
(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

;; replace default M-x behavior with some stuff of ido
(setq smex-save-file "/home/max/.emacs.d/temp/.smex-items")

;; mode for listing of recent opened files
(require 'recentf)
(setq recentf-auto-cleanup 'never
      recentf-max-menu-items 50
      recentf-max-saved-items 400)
(setq recentf-save-file "/home/max/.emacs.d/temp/.recentf")
(recentf-mode t)

;; change default mode line [configure]
(require 'smart-mode-line)
(sml/setup)

;; additional features to undo/redo system
(require 'undo-tree)
(global-undo-tree-mode 1)

;; mode for auto complete words [read more][E]
(setq ac-comphist-file "/home/max/.emacs.d/temp/.ac-comphist.dat")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-expand-on-auto-complete nil)
(setq ac-delay 0.125
      ac-auto-show-menu 0.25
      ac-auto-start 2
      ac-quick-help-delay 2.0
      ac-ignore-case nil
      ac-candidate-menu-min 2
      ac-use-quick-help t
      ac-limit 10
      ac-disable-faces nil
      ac-dwim nil)
(setq-default ac-sources '(ac-source-imenu
                           ac-source-words-in-buffer
                           ac-source-words-in-same-mode-buffers
                           ac-source-dictionary
                           ac-source-filename))

;(define-key ac-completing-map (kbd "C-n") 'ac-next)
;(define-key ac-completing-map (kbd "C-p") 'ac-previous)

;; activate occur inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; mode for opening and editing files with sudo privileges
(require 'sudo-save)

;; auto revert buffer if file changed
(global-auto-revert-mode t)

;; restore window position
(winner-mode t)

;; enables mode for execute commands by pressing two buttons simultaneously
(key-chord-mode t)

;; quick move cursor [E]
(setq ace-jump-mode-case-fold t)
(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(setq ace-jump-mode-move-keys
      (loop for i from ?a to ?z collect i))

;; maggit - git interface
(autoload 'magit-status "magit" nil t)

;; w3m - browser
;(require 'w3m-load)
(setq w3m-init-file "/home/max/.emacs.d/.emacs-w3m")
(setq w3m-home-page "http://www.google.com")
(setq w3m-use-cookies t)
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-show-graphic-icons-in-header-line t)
(setq w3m-show-graphic-icons-in-mode-line t)

;; AUCTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
;(setq TeX-auto-save t)
;(setq TeX-parse-self t)

;; Buffer names completion
(icomplete-mode t)
(add-to-list 'ido-ignore-buffers "*GNU Emacs*")
(add-to-list 'ido-ignore-buffers "*Messages*")
(add-to-list 'ido-ignore-buffers "*Backtrace")
(add-to-list 'ido-ignore-buffers "*Quail Com")
(add-to-list 'ido-ignore-buffers "*Buffer")
(add-to-list 'ido-ignore-buffers "*fsm-debug")
(add-to-list 'ido-ignore-buffers "*Completions")
(add-to-list 'ido-ignore-buffers "^[tT][aA][gG][sS]$")

;; EMMS configuration
(require 'emms-setup)
(emms-standard)
(emms-default-players)

;; guide-key
(require 'guide-key)
(setq guide-key/guide-key-sequence
      '("C-x r" "C-x 4" "C-x v" "C-x 8" "M-t" "M-g" "<f1>"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'right)

(require 'god-mode)
(define-key god-local-mode-map (kbd "h") 'backward-delete-char)

;; Dired-x - extra dired mode
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    (setq dired-guess-shell-gnutar "gtar")
	    (setq dired-x-hands-off-my-keys nil)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
					;(dired-omit-mode 1)
	    ))
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; support for CMake
(autoload 'cmake-mode "cmake-mode" t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

;; syntax checking on the fly [! read more]
(require 'flymake)
;; temporary copies in the system temp dir.
(setq flymake-run-in-place nil)
(setq temporary-file-directory "/data/.emacs_backup/")

;; Yasnippets
;(add-to-list 'load-path "/home/max/.emacs.d/site-lisp/yasnippet")
;(require 'yasnippet)
;(yas/global-mode 1)
;(yas/initialize)
;(yas/load-directory "/home/max/.emacs.d/site-lisp/yasnippet/snippets")

;;; ===================================================================


;;; Functions
;; kill emacs process [C-x c] 
(defun max/kill-emacs ()
  (interactive)
  (save-some-buffers)
  (kill-emacs))

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
	    (let ((current-point (point))) 
	    (jump-to-register '_)
	    (goto-char current-point)))))))

;; find a recent file using ido
(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((default-ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))))
  (let (
	(file
	 (ido-completing-read "Recent opened files: " recentf-list nil t))
	)
    (when file
      (find-file file)))))

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

;; if last command wasn't yank -> show kill ring [E]
(defadvice yank-pop (around kill-ring-browse-maybe (arg))
  "If last action was not a yank, run `browse-kill-ring' instead."
  (if (not (eq last-command 'yank))
      (browse-kill-ring)
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
      (concat "/home/max/.emacs.d/site-lisp/translate_arg " "\"" myStr "\"")))
    (message "%s" (substring translate 0 (- (length translate) 1)))))

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

;; ido for imenu
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Function: " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark (point))
      (goto-char position))))
;;; ===================================================================


;;; Eshell
(setq eshell-history-size 99999)
(setq eshell-history-file-name "/home/max/.histfile")
(global-set-key (kbd "C-x m") 'eshell)
(setq eshell-cmpl-cycle-completions nil
      ehsell-save-history-on-exit t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

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
;;; ===================================================================


;;; Slime
(setq auto-mode-alist
      (append '(("\\.lisp$"   . lisp-mode)
		("\\.lsp$"    . lisp-mode)
		("\\.cl$"     . lisp-mode)
		("\\.asd$"    . lisp-mode)
		("\\.system$" . lisp-mode))
	      auto-mode-alist))
(add-hook 'lisp-mode-hook
	  (lambda ()
	    (setq lisp-indent-function 'common-lisp-indent-function)
	    (setq show-trailing-whitespace t)))

(load (expand-file-name "/home/max/quicklisp/slime-helper.el"))
(require 'slime)
(slime-setup
 '(slime-fancy slime-indentation slime-tramp slime-asdf slime-sprof))
(setq slime-net-coding-system 'utf-8-unix)
(setq slime-default-lisp 'sbcl)
(setq slime-lisp-implementations
      `((sbcl ("/usr/bin/sbcl") :coding-system utf-8-unix)))
(eval-after-load 'slime
  '(progn
     (setq slime-scratch-file "/home/max/.emacs.d/tmp/scratch.lisp")
     (setq slime-edit-definition-fallback-function 'find-tag)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (setq slime-when-complete-filename-expand t)
     (setq slime-truncate-lines nil)
     (setq slime-autodoc-use-multiline-p t)
     (slime-autodoc-mode)))
(add-hook 'lisp-mode-hook
	  (lambda ()
	    (setq slime-use-autodoc-mode t)))
(defun max/customized-lisp-keyboard ()
  (define-key slime-repl-mode-map (kbd "C-c ;") 'slime-insert-balanced-comments)
  (local-set-key [C-c tab] 'slime-fuzzy-complete-symbol)
  (local-set-key [return] 'newline-and-indent))
(add-hook 'lisp-mode-hook 'max/customized-lisp-keyboard)
;;; ===================================================================


;;; Cpp [! rewrite]
;(setq max/gdb-process ""
;      max/buffer-name "")
;(add-hook 'gdb-mode-hook '(lambda ()
;			    (setq max/gdb-process
;				  (substring (buffer-name) 1 (- (length (buffer-name)) 1)))))
;; При включении c++-mode -> стиль "BSD", C-c C-c - авто-компиляция
(add-hook 'c++-mode-hook '(lambda ()
			    (c-set-style "bsd")
			    (setq c-basic-offset 4)))
;			    (setq compile-command "g++ ")
			    ;;включает режим авто вставки переносов строк (после ;), С-с С-а
					;(c-toggle-auto-state t)
;			    (local-set-key (kbd "C-c C-r") 'gud-run)
;			    ;;будет выполняться после завершения компиляции
;			    (defun max/cpp-notify-compilation-result(buffer msg)
;			      (interactive)
;			      (other-window -1)
;			      (if (string-match "^finished" msg)
;				  (progn
;				    ;(gdb (concat "gdb -i=mi -silent --annotate=3 " max/buffer-name))
;				    (gdb (concat "gdb -i=mi -silent " max/buffer-name))
;				    (insert "r")
;				    (comint-send-input))))


;			    (add-to-list 'compilation-finish-functions
;					 'max/cpp-notify-compilation-result)

;			    (defun max/cpp-compile-and-run ()
;			      (interactive)
;			      (save-buffer)
;			      (setq max/buffer-name
;				    (substring (buffer-name) 0 (- (length (buffer-name)) 4)))
;			      (if (not (eql max/gdb-process ""))
;				  (progn
;				    (if (get-buffer (concat "*" max/gdb-process "*"))
;					(if (shell-command "killall gdb")
;					    (kill-buffer (concat "*" max/gdb-process "*"))))
;				    (setq max/gdb-process "")))
;			      (delete-other-windows)
;			      (split-window-horizontally)
;			      (enlarge-window-horizontally 12)
;			      (compile (concat "g++ -g " max/buffer-name ".cpp -o " max/buffer-name)))
;			    (local-set-key (kbd "C-c r") 'gdb)
			    (local-set-key (kbd "C-c c") 'comment-region)
;			    (local-set-key (kbd "C-c C-c") 'max/cpp-compile-and-run)))
;;; ===================================================================


;;; Csharp [! rewrite]
;(setq max/csharp-add-to-command "")
;(defun max/csharp-mode-fn ()
;  "function that runs when csharp-mode is initialized for a buffer."
;  (c-set-style "bsd")
;  (setq c-basic-offset 4)
;  (setq compile-command "gmcs ")
;  ;;будет выполняться после завершения компиляции
;  (defun max/csharp-notify-compilation-result(buffer msg)
;    (interactive)
;    (other-window -1)
;    (if (string-match "^finished" msg)
;	(progn
;	  (eshell)
;	  (insert (concat "mono " max/buffer-name ".exe"))
;	  (eshell-send-input))))

;  (add-to-list 'compilation-finish-functions
;	       'max/csharp-notify-compilation-result)

;  (defun max/csharp-compile-and-run ()
;    (interactive)
;    (save-buffer)
;    (setq max/buffer-name
;	  (substring (buffer-name) 0 (- (length (buffer-name)) 3)))
;    (delete-other-windows)
;    (split-window-horizontally)
;    (enlarge-window-horizontally 12)
;    (compile
;     (concat "gmcs " max/buffer-name ".cs " max/csharp-add-to-command)))

;  (local-set-key (kbd "C-c c") 'comment-region)
;  (local-set-key (kbd "C-c C-c") 'max/csharp-compile-and-run))

;(add-hook  'csharp-mode-hook 'max/csharp-mode-fn t)
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
  (setq indent-tabs-mode nil)
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
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(setq py-install-directory "/usr/share/emacs/site-lisp/")
(require 'python-mode)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
(require 'info-look)
(eval-after-load "jedi"
  '(define-key jedi-mode-map (kbd "<C-tab>") nil))
(add-hook 'python-mode-hook 
	  (lambda ()
	    (setq py-electric-colon-newline-and-indent-p t)
	    ; switch to the interpreter after executing code
	    (setq py-shell-switch-buffers-on-execute-p t)
	    (setq py-switch-buffers-on-execute-p t)
	    ; don't split windows
	    (setq py-split-windows-on-execute-p nil)
	    ; try to automagically figure out indentation
	    (setq py-smart-indentation t)

	    ; jedi autocomplete
	    (jedi:setup)
	    (jedi:ac-setup)
	    (setq jedi:complete-on-dot t)
	    (setq jedi:complete [C-c tab])))

;; pymacs settings
;; (require 'pymacs)
;; (setq pymacs-python-command py-python-command)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")

;; F1-S - look in info documentation
(info-lookup-add-help
 :mode 'python-mode
 :regexp "[[:alnum:]_]+"
 :doc-spec
 '(("(python)Index" nil "")))

;; show errors on the fly
(defun flymake-python-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "epylint" (list local-file))))

(defun flymake-activate ()
  "Activates flymake when real buffer and you have write access"
  (if (and
       (buffer-file-name)
       (file-writable-p buffer-file-name))
      (progn
        (flymake-mode t)
        ;; this is necessary since there is no flymake-mode-hook...
        (local-set-key (kbd "C-c n") 'flymake-goto-next-error)
        (local-set-key (kbd "C-c p") 'flymake-goto-prev-error))))

(defun ca-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'ca-flymake-show-help)
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-python-init))
(add-hook 'python-mode-hook 'flymake-activate)
;;; ===================================================================

;;; Lisp
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;;; ===================================================================

;;; Java [! rewrite]
;(setq max/java-add-to-command "")
;(defun max/java-mode-fn ()
;  "function that runs when java-mode is initialized for a buffer."
;  (c-set-style "bsd")
;  (setq c-basic-offset 4)
;  (setq compile-command "javac ")
;  ;;будет выполняться после завершения компиляции
;  (defun max/java-notify-compilation-result(buffer msg)
;    (interactive)
;    (other-window -1)
;    (if (string-match "^finished" msg)
;	(progn
;	  (eshell)
;	  (eshell-send-input)
;	  (insert (concat "java " max/buffer-name))
;	  (eshell-send-input))))

;  (add-to-list 'compilation-finish-functions
;	       'max/java-notify-compilation-result)

;  (defun max/java-compile-and-run ()
;    (interactive)
;    (save-buffer)
;    (setq max/buffer-name
;	  (substring (buffer-name) 0 (- (length (buffer-name)) 5)))
;    (delete-other-windows)
;    (split-window-horizontally)
;    (enlarge-window-horizontally 12)
;    (compile
;     (concat "javac " max/buffer-name ".java " max/java-add-to-command)))

(local-set-key (kbd "C-c c") 'comment-region)
;  (local-set-key (kbd "C-c C-c") 'max/java-compile-and-run))

;(add-hook  'java-mode-hook 'max/java-mode-fn t)
;;; ===================================================================


;;; Test code
(setq toe-treat-words 'downcase)

;; load dired+
(require 'dired+)

;; hide additional info in dired buffers
(require 'dired-details+)
(setq-default dired-details-hidden-string "--- ")
 
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

;;; Customize-group generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("31d3463ee893541ad572c590eb46dcf87103117504099d362eeed1f3347ab18f" default)))
 '(fci-rule-color "#383838")
 '(jedi:key-complete [C-c Tab])
 '(py-tab-shifts-region-p t)
 '(py-underscore-word-syntax-p nil)
 '(python-eldoc-string-code "__PYDOC_get_help('''%s''')")
 '(sml/active-background-color "gray12")
 '(sml/hidden-modes (quote (" hl-p" " Guide" " Undo-Tree")))
 '(sml/inactive-background-color "gray24")
 '(sml/mode-width (quote full))
 '(sml/modified-char "+")
 '(sml/modified-time-string "Mod: %T %Y-%m-%d.")
 '(sml/name-width 40)
 '(sml/replacer-regexp-list (quote (("^~/org/" ":Org:") ("^~/\\.emacs\\.d/" ":ED:") ("^/sudo:.*:" ":SU:") ("^~/Documents/" ":Doc:") ("^~/Dropbox/" ":DB:") ("^:\\([^:]*\\):Documento?s/" ":\\1/Doc:") ("^~/[Gg]it/" ":Git:") ("^~/[Gg]it[Hh]ub/" ":Git:") ("^~/[Gg]it\\([Hh]ub\\|\\)-?[Pp]rojects/" ":Git:") ("^/data/Downloads/" ":Dls:") ("^/data/sandbox/" ":Sbx:") ("^~/src/" ":Src:"))))
 '(sml/show-eol t)
 '(sml/theme nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(which-func-modes (quote (c++-mode c-mode python-mode perl-mode java-mode))))

;; faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-foreground ((t (:foreground "gold"))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(sml/modified ((t (:inherit sml/global :background "green4" :foreground "white" :weight bold))))
 '(which-func ((t (:foreground "gold"))) t))
;;; ===================================================================

;; E - elpa
; paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
