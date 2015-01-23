(require 'flymake)

;; show symbol in fringe in line with error
(require 'fringe-helper)  
(setq flymake-run-in-place nil)
(setq temporary-file-directory "/tmp/")

(defun flymake-show-warerr-in-fringe ()
  (defvar flymake-fringe-overlays nil)
  (make-variable-buffer-local 'flymake-fringe-overlays)

  (defadvice flymake-make-overlay (after add-to-fringe first
                                         (beg end tooltip-text face mouse-face)
                                         activate compile)
    (push (fringe-helper-insert-region
           beg end
           (fringe-lib-load (if (eq face 'flymake-errline)
                                fringe-lib-exclamation-mark
                              fringe-lib-question-mark))
           'right-fringe 'font-lock-warning-face)
          flymake-fringe-overlays))

  (defadvice flymake-delete-own-overlays (after remove-from-fringe activate
                                                compile)
    (mapc 'fringe-helper-remove flymake-fringe-overlays)
    (setq flymake-fringe-overlays nil)))

(defun flymake-activate ()
  "Activates flymake when real buffer and you have write access"
  (message (buffer-file-name))
  (file-writable-p buffer-file-name)
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

(defun flymake-cpp-init ()
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-std=c++11" "-fsyntax-only" local-file))))

(defun flymake-cc-init ()
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;; python flymake
(defun flymake-python-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-intemp))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "pyflakes3k" (list local-file))))

(add-hook 'post-command-hook 'ca-flymake-show-help)

(provide 'setup-flymake)
