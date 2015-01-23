The Emacs Lisp Python Environment in Emacs

Elpy is an Emacs package to bring powerful Python editing to Emacs.
It combines a number of existing Emacs packages, and uses one of a
selection of Python packages for code introspection.

To use, you need to install not only this package, but a few Python
packages as well. See the installation instructions on the wiki.

Documentation is available there as well.

https://github.com/jorgenschaefer/elpy/wiki

Writing Elpy Modules:

A module is a function which is called with one or more arguments.
This first argument is the command specifier symbol, which can be
one of the following:

global-init:
- Called once, when Elpy is enabled using `elpy-enable'.

global-stop:
- Called once, when Elpy is disabled using `elpy-disable'.

buffer-init:
- Called in a buffer when elpy-mode is enabled.

buffer-stop:
- Called in a buffer when elpy-mode is disabled.

Writing test runners:

A test runner is a function that receives four arguments, described
in the docstring of `elpy-test-at-point'. If only the first
argument is given, the test runner should find tests under this
directory and run them. If the others are given, the test runner
should run the specified test only, or as few as it can.

Test runners should use an interactive spec of (interactive
(elpy-test-at-point)) so they can be called directly by the user.
For their main work, they can simply call `elpy-test-run'. See the
`elpy-test-discover-runner' for an example.
