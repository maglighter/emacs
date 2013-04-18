`dired-details-hide' makes dired buffers that look like this:

 /private/rgiardin/lispHome:
 used 1264 available files

 drwxr-xr-x   5 rgiardin g632         512 Jan 19  2003 ..
 -rw-r--r--   1 rgiardin svrtech     4141 Aug 23 17:07 dired-details.el
 -rw-r--r--   1 rgiardin svrtech     4141 Aug 23 17:07 my-really-really-long-I-mean-really-long-filename.el
 -rw-r--r--   1 rgiardin svrtech       56 Aug 23 17:07 linked-file.el -> /var/tmp/checkouts/linked-file.el

look like this:

 /private/rgiardin/lispHome/emacs.config:
 used 1264 available files

 [...] ..
 [...] dired-details.el
 [...] my-really-really-long-I-mean-really-long-filename.el
 [...] linked-file.el -> [...]

The function `dired-details-toggle' will toggle details on and off.


INSTALLATION:

To apply `dired-details-hide' to all new dired buffers, add the
following to your .emacs:

(require 'dired-details)
(dired-details-install)

This also binds the following keys in dired buffers:

  ) - dired-details-show
  ( - dired-details-hide

CHANGES:

* 1.3.2: Added sr-mode to dired-details-hide function to make it word with
         Sunrise Commander
* 1.3.1: Allow "misc lines (total used, find-dired statuses, etc)" to be hidden;
         suggested by Chris Poole
* 1.3: dired-details-toggle and customization support added by Klaus Berndl
* 1.2.4: Setup hide and show keybindings earlier than the first hide.
* 1.2.3: add dired-details-initially-hide customization as suggested by Harold Maier
* 1.2.2: extensive change to support subdirs in dired buffers
* 1.2.1: respect current hidden state (not initial state) when inserting subdirs

TODO:
* add a hook for dired-add-file to hide new entries as necessary


customizable vars
