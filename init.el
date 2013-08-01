;                      * Emacs CORE configuration file *
; load common lisp features
(require 'cl)

;; default font
;(add-to-list 'default-frame-alist
;	     '(font . "Liberation Mono-12"))

;; add directory with elisp files to the load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; add packages repository
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; turn off: hide tool bar & menu bar & scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; color theme loading
(load-theme 'wombat)

;; set history length
(setq history-length 100)

;; max size of messages log
(setq message-log-max 2000)

;; don't show startup message
(setq inhibit-splash-screen t)

;; yes -> y, no -> n, C-j -> return -> yes
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map (kbd "C-j") 'act)

;; registers point to files
(set-register ?i '(file . "~/.emacs.d/init.el"))
(set-register ?w '(file . "~/.emacs.d/help/work.org"))
(set-register ?f '(file . "~/.emacs.d/foo.org"))

;; emacs c source code directory
;(setq find-function-C-source-directory
;      "/usr/share/emacs/23.4/lisp/emacs23-23.4+1/src/")

;; replacement of selected region
(delete-selection-mode t)

;; scrolling settings
(setq scroll-conservatively 50 scroll-margin 2)

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

;; encoding: use UTF-8 environment [check]
;(set-language-environment 'UTF-8)
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;(setq x-select-enable-clipboard t)
;(define-coding-system-alias 'windows-1251 'cp1251)
;(prefer-coding-system 'koi8-r-unix)
;(prefer-coding-system 'windows-1251-dos)
;(prefer-coding-system 'utf-8-unix)
(setq default-input-method 'russian-computer)

;; Fulscreen
;(defun toggle-full-screen () (interactive) (shell-command "emacs_fullscreen.exe"))
;(global-set-key [f11] 'toggle-full-screen)

;; default directory
(setq command-line-default-directory "d:/home/")

;;; ===================================================================


;;; Backup and history
(setq
 backup-by-copying nil
 backup-by-copying-when-mismatch t
 backup-by-copying-when-linked t
 backup-directory-alist
 '((".*" . "~/.emacs.d/backups"))
 auto-save-file-name-transforms
 '((".*" "~/.emacs.d/backups" t))
 delete-old-versions t
 kept-new-versions 8
 kept-old-versions 2
 version-control t)

(defun force-backup-of-buffer ()
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook 'force-backup-of-buffer)

(setq savehist-file "~/.emacs.d/.savehist")
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring))
(savehist-mode 1)


;;; ===================================================================


;;; Keys
;; kill emacs process [v]
(global-set-key (kbd "C-x c") 'max/kill-emacs)

;; switch to next window
(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-x o") '(lambda () (interactive)(other-window -1)))

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

;; switching between buffers
(global-set-key (kbd "C-.") 'iswitchb-buffer)

;; list of recent opened files
(global-set-key (kbd "C-,") 'recentf-ido-find-file)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; kill current buffer without request
(global-set-key (kbd "C-x k")
		'(lambda () (interactive) (kill-buffer (current-buffer))))

;; replace default M-x behavior with some stuff of ido [v]
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "<print>") 'smex)
(global-set-key (kbd "<menu>") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;standart M-x
(global-set-key (kbd "C-c C-c <menu>") 'execute-extended-command)

;; first moves to indentation then to beginning [v]
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

;; visual regexp bindings
(define-key global-map (kbd "C-c r") 'vr/query-replace)
(define-key global-map (kbd "C-c q") 'vr/replace)

;; С-h <-> Backspace
(define-key key-translation-map [?\C-h] [?\C-?])

;; if region copy region, end of line, select line, else select to the end [v]
(global-set-key (kbd "M-w") 'max/kill-ring-save)
(define-key minibuffer-local-map
  (kbd "M-w") 'max/kill-ring-save)

;; translate current word or region [v]
(global-set-key (kbd "C-x t") 'max/translate-word-or-region)

;; evaluate expression or region [v]
(global-set-key (kbd "C-x C-e") 'max/eval-expression-or-region)

;; join current line with above
(global-set-key (kbd "C-c q") 'join-line)

;; menu with pointers to functions definitions
(global-set-key (kbd "C-x C-k i") 'imenu)

;; shift+arrow to move between windows
(windmove-default-keybindings)

;; change some dired shortcuts
(define-key global-map (kbd "C-x C-d")
  '(lambda () (interactive)(ido-dired)(ido-next-match)(ido-prev-match)(ido-exit-minibuffer)))
(define-key global-map (kbd "C-x d") 'ido-list-directory)

;; increase/decrease text scale
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; looks at the buffer and tries to expand word in various ways
(global-set-key (kbd "M-/") 'hippie-expand)

;; interactive lisp interpretor
(global-set-key [f6] 'ielm)

;; connect to slime [v SLIME]
;(global-set-key [f5] 'slime)
;(global-set-key [(control f5)] 'slime-selector)

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
(defalias 'qr 'query-replace)
(defalias 'qrr 'query-replace-regexp)
(defalias 'rb 'revert-buffer)
(defalias 'sh 'shell-command)
(defalias 'wsm 'whitespace-mode)

;;; ===================================================================


;;; Modes
;; enable ido mode
(custom-set-variables
 '(ido-enable-last-directory-history nil)
 '(ido-record-commands nil)
 '(ido-max-work-directory-list 0)
 '(ido-max-work-file-list 0))
(ido-mode t)
(setq default-ido-decorations ido-decorations)
(add-hook 'ido-setup-hook
          (lambda ()
	    (setq ido-decorations default-ido-decorations)
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

;; replace default M-x behavior with some stuff of ido
(require 'smex) ; [M-x]
(setq smex-save-file "~/.emacs.d/.smex-items")
(smex-initialize)

;; mode for listing of recent opened files
(require 'recentf)
(setq recentf-auto-cleanup 'never
      recentf-max-menu-items 50
      recentf-max-saved-items 400)
(setq recentf-save-file "~/.emacs.d/.recentf")
(recentf-mode t)

;; change default mode line [configure]
;(require 'powerline)
;(powerline-default)

;; syntax checking on the fly [! read more]
(require 'flymake)

;; mode for auto complete operators and other [read more]
(require 'auto-complete-config)
(setq ac-auto-start t)
(setq ac-comphist-file "~/.emacs.d/.ac-comphist.dat")
(ac-config-default)

;; activate occur inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; maggit - git interface
(autoload 'magit-status "magit" nil t)

;; w3m - browser
;(require 'w3m-load)
(setq w3m-init-file "/home/max/.emacs.d/.emacs-w3m")

;; mode for opening and editing files with sudo privileges
;(require 'sudo-save)

;; AUCTeX
;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)
;(setq TeX-auto-save t)
;(setq TeX-parse-self t)

;; Iswitch
(iswitchb-mode t)
(add-to-list 'iswitchb-buffer-ignore "*GNU Emacs*")
(add-to-list 'iswitchb-buffer-ignore "*Messages*")
(add-to-list 'iswitchb-buffer-ignore "*Backtrace")
(add-to-list 'iswitchb-buffer-ignore "*Quail Com")
(add-to-list 'iswitchb-buffer-ignore "*Buffer")
(add-to-list 'iswitchb-buffer-ignore "*fsm-debug")
(add-to-list 'iswitchb-buffer-ignore "*Completions")
(add-to-list 'iswitchb-buffer-ignore "^[tT][aA][gG][sS]$")
(add-hook 'iswitchb-minibuffer-setup-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-j"
              'iswitchb-exit-minibuffer)))

;; EMMS configuration
;(require 'emms-setup)
;(emms-standard)
;(emms-default-players)

;; Dired configs
; Dired-x - extra dired mode
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
(require 'dired-details+)

;; support for CMake
(autoload 'cmake-mode "cmake-mode" t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

;; ace jump mode major function
(add-to-list 'load-path "/full/path/where/ace-jump-mode.el/in/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; only lowerercase characters
;(setq ace-jump-mode-move-keys
;      (loop for i from ?a to ?z collect i))
;; ignore case sensitive
(setq ace-jump-mode-case-fold t)
;; you can select the key you prefer to
(define-key global-map (kbd "M-z") 'ace-jump-mode)
;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; Yasnippets
;(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
;(require 'yasnippet)
;(yas/global-mode 1)
;(yas/initialize)
;(yas/load-directory "~/.emacs.d/site-lisp/yasnippet/snippets")

;; session manager
;(require 'session)
;(add-hook 'after-init-hook 'session-initialize)

;; anything mode
;(require 'anything-match-plugin)
; (require 'anything-config)

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

;; if last command wasn't yank -> show kill ring
(defadvice yank-pop (around kill-ring-browse-maybe (arg))
  "If last action was not a yank, run `browse-kill-ring' instead."
  (if (not (eq last-command 'yank))
      (browse-kill-ring)
    ad-do-it))

(ad-activate 'yank-pop)

;; eval expression or region [C-x C-e]
(defun max/eval-expression-or-region (arg)
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
    (setq translate (shell-command-to-string
      (concat "~/.emacs.d/site-lisp/translate_arg " "\"" myStr "\"")))
    (message "%s" (substring translate 0 (- (length translate) 1)))))

;; convert buffer: dos -> unix (utf-8)
(defun max/dos2unix ()
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix))

;;; ===================================================================


;;; Eshell
(setq eshell-history-size 99999)
(setq eshell-history-file-name "~/.histfile")
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

;;; Cygwin
;(cygwin-mount-activate)

(let* ((cygwin-root "c:/cygwin")
         (cygwin-bin (concat cygwin-root "/bin")))
    (when (and (eq 'windows-nt system-type)
  	     (file-readable-p cygwin-root))
    
      (setq exec-path (cons cygwin-bin exec-path))
      (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
    
      ;; By default use the Windows HOME.
      ;; Otherwise, uncomment below to set a HOME
      ;;      (setenv "HOME" (concat cygwin-root "/home/eric"))
    
      ;; NT-emacs assumes a Windows shell. Change to baash.
      (setq shell-file-name "bash")
      (setenv "SHELL" shell-file-name) 
      (setq explicit-shell-file-name shell-file-name) 
    
      ;; This removes unsightly ^M characters that would otherwise
      ;; appear in the output of java applications.
      (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))

;;; ===================================================================

;;; Cpp [! rewrite]
;; При включении c++-mode -> стиль "BSD", C-c C-c - авто-компиляция
(add-hook 'c++-mode-hook '(lambda ()
			    (c-set-style "bsd")
			    (local-set-key (kbd "C-c c") 'comment-region)))
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
  (line-number-mode 1)
  (column-number-mode 1)
  (abbrev-mode 1)
  (turn-on-eldoc-mode)
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
  (find-file (concat "~/src/perl/" name))
  (insert "#!/usr/bin/perl -w\n")
  (cperl-mode)
  (save-buffer)
  (shell-command (concat "chmod +x " name)))
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
(autoload 'typing-of-emacs "The Typing Of Emacs, a game." t)
(setq toe-treat-words 'downcase)
(setq toe-starting-time-per-word 4)
