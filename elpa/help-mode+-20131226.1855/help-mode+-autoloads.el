;;; help-mode+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (help-make-xrefs help-mode) "help-mode+" "help-mode+.el"
;;;;;;  (21184 18370 130257 549000))
;;; Generated autoloads from help-mode+.el

(autoload 'help-mode "help-mode+" "\
Major mode for viewing help text and navigating references in it.
Entry to this mode runs the normal hook `help-mode-hook'.
Commands:
\\{help-mode-map}

\(fn)" t nil)

(autoload 'help-make-xrefs "help-mode+" "\
Parse and hyperlink documentation cross-references in the given BUFFER.

Find cross-reference information in a buffer and activate such cross
references for selection with `help-follow'.  Cross-references have
the canonical form `...'  and the type of reference may be
disambiguated by the preceding word(s) used in
`help-xref-symbol-regexp'.  Faces only get cross-referenced if
preceded or followed by the word `face'.  Variables without
variable documentation do not get cross-referenced, unless
preceded by the word `variable' or `option'.

If the variable `help-xref-mule-regexp' is non-nil, find also
cross-reference information related to multilingual environment
\(e.g., coding-systems).  This variable is also used to disambiguate
the type of reference as the same way as `help-xref-symbol-regexp'.

A special reference `back' is made to return back through a stack of
help buffers.  Variable `help-back-label' specifies the text for
that.

\(fn &optional BUFFER)" t nil)

;;;***

;;;### (autoloads nil nil ("help-mode+-pkg.el") (21184 18370 144452
;;;;;;  131000))

;;;***

(provide 'help-mode+-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; help-mode+-autoloads.el ends here
