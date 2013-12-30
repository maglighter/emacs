;;; isearch+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (isearch-mode-help isearch-toggle-case-fold isearchp-set-region-around-search-target
;;;;;;  isearchp-toggle-set-region isearchp-toggle-regexp-quote-yank
;;;;;;  isearchp-toggle-option-toggle isearchp-toggle-search-invisible
;;;;;;  isearch-toggle-invisible isearchp-cycle-mismatch-removal
;;;;;;  isearchp-toggle-option-flag isearchp-set-region-flag isearchp-regexp-quote-yank-flag
;;;;;;  isearchp-mouse-2-flag isearchp-drop-mismatch) "isearch+"
;;;;;;  "isearch+.el" (21184 18348 53287 910000))
;;; Generated autoloads from isearch+.el

(defvar isearchp-drop-mismatch nil "\
*Non-nil means remove or replace a search-string mismatch.
There are three possible values:

`replace-last' - Replace the last mismatch in the search string with
                 the latest input (e.g., replace the last typed char
                 or last yanked text).
nil            - Never remove mismatched text from the search string.
anything else  - Always remove mismatched text from the search string.

* Vanilla Isearch has the behavior of a nil value.

* Non-nil, non-`replace-last' means the search string never contains
  mismatched characters.

* `replace-last' means you see only the latest mismatched input, and
  it is available for editing, using \\<isearch-mode-map>`\\[isearch-edit-string]'.

You can cycle among the three possible values using `\\[isearchp-cycle-mismatch-removal]'.")

(custom-autoload 'isearchp-drop-mismatch "isearch+" t)

(defvar isearchp-mouse-2-flag t "\
*Non-nil means clicking `mouse-2' during Isearch yanks the selection.
In that case, you can select text with the mouse, then hit `C-s' to
search for it.

If the value is nil, yank only if the `mouse-2' click is in the echo
area.  If not in the echo area, invoke whatever `mouse-2' is bound to
outside of Isearch.")

(custom-autoload 'isearchp-mouse-2-flag "isearch+" t)

(defvar isearchp-regexp-quote-yank-flag t "\
*Non-nil means escape special chars in text yanked for a regexp isearch.
You can toggle this with `isearchp-toggle-regexp-quote-yank', bound to
`C-`' during isearch.")

(custom-autoload 'isearchp-regexp-quote-yank-flag "isearch+" t)

(defvar isearchp-set-region-flag nil "\
*Non-nil means set region around search target.
This is used only for Transient Mark mode.
You can toggle this with `isearchp-toggle-set-region', bound to
`C-SPC' during isearch.")

(custom-autoload 'isearchp-set-region-flag "isearch+" t)

(defvar isearchp-toggle-option-flag nil "\
*Non-nil means Isearch toggling commands can affect option values.
If nil, the option value remains unchanged - the effect is temporary.

Applies to toggle commands for behavior that has an associated user
option.  Currently this means `M-s i' (`isearch-toggle-invisible') and
`M-c' (`isearch-toggle-case-fold').")

(custom-autoload 'isearchp-toggle-option-flag "isearch+" t)

(autoload 'isearchp-cycle-mismatch-removal "isearch+" "\
Cycle option `isearchp-drop-mismatch'.

\(fn)" t nil)

(autoload 'isearch-toggle-invisible "isearch+" "\
Toggle searching in invisible text on or off.
If `isearchp-toggle-option-flag' is non-nil then toggle the value of
option `search-invisible'.  If it is nil then toggle the behavior only
temporarily, so that the option value is unchanged for subsequent
searches.

A prefix argument flips the sense of the last paragraph, so that the
option is updated only if `isearchp-toggle-option-flag' is nil instead
of non-nil.

To use a prefix argument you must set either `isearch-allow-scroll' or
`isearch-allow-prefix' (if available) to non-nil.  Otherwise, a prefix
arg during Isearch exits Isearch.

When toggling invisible searching on, restores the last behavior
according to option `search-invisible': t or `open'.

\(fn FLIP)" t nil)

(autoload 'isearchp-toggle-search-invisible "isearch+" "\
Toggle the value of user option `search-invisible'.
Toggles between nil and the last non-nil value.

\(fn)" t nil)

(autoload 'isearchp-toggle-option-toggle "isearch+" "\
Toggle the value of option `isearchp-toggle-option-flag'.

\(fn)" t nil)

(autoload 'isearchp-toggle-regexp-quote-yank "isearch+" "\
Toggle `isearchp-regexp-quote-yank-flag'.

\(fn)" t nil)

(autoload 'isearchp-toggle-set-region "isearch+" "\
Toggle `isearchp-set-region-flag'.

\(fn)" t nil)

(autoload 'isearchp-set-region-around-search-target "isearch+" "\
Set the region around the last search or query-replace target.

\(fn)" t nil)

(autoload 'isearch-toggle-case-fold "isearch+" "\
Toggle case sensitivity on or off during incremental searching.
The minor-mode lighter shows `ISEARCH' for case-insensitive, `Isearch'
for case-sensitive.

If `isearchp-toggle-option-flag' is non-nil then toggle the value of
option `isearchp-case-fold'.  If it is nil then toggle the behavior
only temporarily, so that the option value is unchanged for subsequent
searches.

A prefix argument flips the sense of the last paragraph, so that the
option is updated only if `isearchp-toggle-option-flag' is nil instead
of non-nil.

To use a prefix argument you must set either `isearch-allow-scroll' or
`isearch-allow-prefix' (if available) to non-nil.  Otherwise, a prefix
arg during Isearch exits Isearch.

When toggling case-sensitive searching on, restores the last behavior
according to option `isearchp-case-fold': t or `yes'.

\(fn FLIP)" t nil)

(autoload 'isearch-mode-help "isearch+" "\
Display information on interactive search in buffer *Help*.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("isearch+-pkg.el") (21184 18348 70254
;;;;;;  375000))

;;;***

(provide 'isearch+-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; isearch+-autoloads.el ends here
