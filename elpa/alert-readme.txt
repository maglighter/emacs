Quickstart

    (require 'alert)
    (alert-install-aliases)

    (alert "important message")

    (with-message-logonly
      (do-something-noisy))

Explanation

Alert.el provides alternatives to Emacs' built-in `message'
function.

This library is generally only useful when programming in Emacs
Lisp.  However, some end-users may find it useful to control
messaging, especially for the case of quietening chatty libraries
in their ~/.emacs files (see below).

The principal `alert' function by default works differently from
`message' in almost every respect, displaying with sound and visual
highlight, and not writing to the log.  See the `alert' docstring
for details.  The variant function `alert*' has identical
functionality, but accepts CL-style arguments.

The following functions provided by this library are drop-in
alternatives to `message' which may be useful in an `flet'
construct:

    `alert-message-nolog'
    `alert-message-logonly'
    `alert-message-highlight'
    `alert-message-insert'
    `alert-message-notify'
    `alert-message-popup'
    `alert-message-temp'
    `alert-message-string'

The following macros modify the behavior of `message' within
the enclosing expression:

    `alert-with-message-nolog'
    `alert-with-message-logonly'
    `alert-with-message-highlight'
    `alert-with-message-insert'
    `alert-with-message-notify'
    `alert-with-message-popup'
    `alert-with-message-temp'
    `alert-with-message-string'

For example, the following code would redirect messages from a very
chatty library to the log:

    (alert-with-message-nolog
      (require 'very-chatty-library))

The same method may also be handy with `defadvice':

    (defadvice very-chatty-function (around very-chatty-redirect activate)
      (alert-with-message-nolog
        ad-do-it))

Similarly, important messages may be redirected to a more visible
form:

    (defadvice an-important-function (around an-important-function activate)
      (alert-with-message-notify
        ad-do-it))

To use `alert', place the alert.el library somewhere Emacs can find
it, and add the following to your ~/.emacs file:

    (require 'alert)
    (alert-install-aliases)     ; optionally, can also be set in customize

Running `alert-install-aliases' or setting the corresponding
variable in customize will install convenience aliases outside
the "alert-" namespace.  This is disabled by default.

See Also

    M-x customize-group RET alert RET
    M-x customize-group RET notify RET
    M-x customize-group RET popup RET

Notes

    The function `alert-message-noformat' is also available, but it
    is not quite a drop-in replacement for `message'.

    Some of the functions require the availability of notify.el,
    todochiku.el or popup.el.  In all cases, the function will
    degrade to an ordinary message if the external library is not
    present.

Compatibility and Requirements

    GNU Emacs version 24.3-devel     : yes, at the time of writing
    GNU Emacs version 24.1 & 24.2    : yes
    GNU Emacs version 23.3           : yes
    GNU Emacs version 22.3 and lower : no

    Uses if present: string-utils.el, notify.el, todochiku.el,
                     popup.el

Bugs

    Soft dependency on unpublished popup-volatile.

    `message' is a subr.  Macros such as `alert-with-message-logonly'
    will only affect calls to `message' from Lisp.

TODO

    Default icons and timeouts for notifications.

License

Simplified BSD License:

Redistribution and use in source and binary forms, with or
without modification, are permitted provided that the following
conditions are met:

   1. Redistributions of source code must retain the above
      copyright notice, this list of conditions and the following
      disclaimer.

   2. Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials
      provided with the distribution.

This software is provided by Roland Walker "AS IS" and any express
or implied warranties, including, but not limited to, the implied
warranties of merchantability and fitness for a particular
purpose are disclaimed.  In no event shall Roland Walker or
contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of
use, data, or profits; or business interruption) however caused
and on any theory of liability, whether in contract, strict
liability, or tort (including negligence or otherwise) arising in
any way out of the use of this software, even if advised of the
possibility of such damage.

The views and conclusions contained in the software and
documentation are those of the authors and should not be
interpreted as representing official policies, either expressed
or implied, of Roland Walker.
