;;; browse-kill-ring+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "browse-kill-ring+" "browse-kill-ring+.el"
;;;;;;  (22645 8537 537705 413000))
;;; Generated autoloads from browse-kill-ring+.el

(defvar browse-kill-ring-yank-commands (if (boundp 'secondary-selection-yank-commands) secondary-selection-yank-commands '(yank icicle-yank-maybe-completing)) "\
*Commands that yank.
Used by `yank-pop' to tell whether the previous command was a yank command.
Used only if `browse-kill-ring-default-keybindings' has been called,
so `yank-pop' is advised.")

(custom-autoload 'browse-kill-ring-yank-commands "browse-kill-ring+" t)

(defvar browse-kill-ring-alternative-yank-commands (and (boundp 'secondary-selection-yank-secondary-commands) secondary-selection-yank-secondary-commands) "\
*Commands that yank using the alternative selection ring.
Used by `browse-kill-ring-setup' to tell whether the previous command
yanked from `browse-kill-ring-alternative-ring'.")

(custom-autoload 'browse-kill-ring-alternative-yank-commands "browse-kill-ring+" t)

(defvar browse-kill-ring-alternative-ring (and (boundp 'secondary-selection-ring) 'secondary-selection-ring) "\
*Selection ring to use as an alternative to `kill-ring'.
A value of nil means there is no alternative selection ring; that is,
`kill-ring' is used always.")

(custom-autoload 'browse-kill-ring-alternative-ring "browse-kill-ring+" t)

(defvar browse-kill-ring-alternative-push-function (and (boundp 'secondary-selection-ring) 'add-secondary-to-ring) "\
*Function that adds item to the front of alternative selection ring.
This is analogous to `kill-new' for the alternative ring.
It must accept the same same arguments as `kill-new'.")

(custom-autoload 'browse-kill-ring-alternative-push-function "browse-kill-ring+" t)

(autoload 'browse-kill-ring-delete "browse-kill-ring+" "\
Remove all occurrences of selection at point from current selection ring.

\(fn)" t nil)

(autoload 'browse-kill-ring-insert-and-move "browse-kill-ring+" "\
Like `browse-kill-ring-insert', but move selection to front of ring.
Insert the selection at point unless optional arg
APPEND/PREPEND is:
 `append'  - insert at eob, not at point
 `prepend' - insert at bob, not at point

\(fn &optional QUIT APPEND/PREPEND)" t nil)

(autoload 'browse-kill-ring-prepend-insert-and-move "browse-kill-ring+" "\
`browse-kill-ring-prepend-insert', but move selection to front of ring.

\(fn &optional QUIT)" t nil)

(autoload 'browse-kill-ring-append-insert-and-move "browse-kill-ring+" "\
`browse-kill-ring-append-insert', but move selection to front of ring.

\(fn &optional QUIT)" t nil)

(autoload 'browse-kill-ring-forward "browse-kill-ring+" "\
Move forward by ARG selection-ring entries.

\(fn &optional ARG)" t nil)

(autoload 'browse-kill-ring-default-keybindings "browse-kill-ring+" "\
Set up `M-y' so that it can invoke `browse-kill-ring'.
See also option `browse-kill-ring-yank-commands'.

\(fn)" t nil)

(autoload 'browse-kill-ring-edit "browse-kill-ring+" "\
Edit the current selection ring entry at point.

\(fn)" t nil)

(autoload 'browse-kill-ring-edit-finish "browse-kill-ring+" "\
Commit the changes to the current selection ring.

\(fn)" t nil)

(autoload 'browse-kill-ring "browse-kill-ring+" "\
Browse the current selection ring.
With a prefix arg, browse the alternative selection ring instead.

\(If `browse-kill-ring-alternative-ring' is nil, then a prefix arg has
no effect.)

\(fn &optional OTHER-RING-P)" t nil)

(autoload 'browse-kill-ring-switch-to-other-kill-ring "browse-kill-ring+" "\
Browse the other selection ring.
If the current ring is `kill-ring' then browse the alternative ring
\(e.g. `secondary-selection-ring'), and vice versa.  The alternative
ring is the value of `browse-kill-ring-alternative-ring'.

\(fn)" t nil)

(autoload 'toggle-browse-kill-ring-display-style "browse-kill-ring+" "\
Toggle browse-kill-ring-display-style between `separated' and `one-line'.

\(fn)" t nil)

(autoload 'browse-kill-ring-copy-to-other-ring "browse-kill-ring+" "\
Copy the selection at point from current selection ring to other ring.
With a prefix arg, move it instead of copying it.
If the other ring is also displayed, then its displayed is updated.

\(fn &optional MOVEP)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; browse-kill-ring+-autoloads.el ends here
