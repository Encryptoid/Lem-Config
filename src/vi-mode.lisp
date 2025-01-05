(in-package lem-vi-mode)

(vi-mode)

(lem:define-key *normal-keymap* "Space f f" 'lem/grep:grep)
(lem:define-key *normal-keymap* "Space f j" 'lem/grep:grep)

(lem:define-command find-file-current-buf () ()
  (find-file (lem/buffer/internal::buffer-%directory (current-buffer))))

(lem:define-key *normal-keymap* "Space e f" 'lem-vi-mode::find-file-current-buf)

(lem:define-command save-all-buffers () ()
  (lem:save-some-buffers t)
  (lem-core/commands/edit:delete-trailing-whitespace)
  (lem:message "Saved"))
(lem:define-key *normal-keymap* "Space Space" 'save-all-buffers)

;(lem:define-key *normal-keymap* "g e" 'lem:find-file)

(lem:define-command go-to-def-center () ()
  (lem/language-mode:find-definitions)
  (lem-vi-mode/commands:vi-scroll-line-to-center))
(lem:define-key *normal-keymap* "g d" 'go-to-def-center)

(lem:define-key *normal-keymap* "g t" 'LEM-LISP-MODE/INTERNAL:LISP-DESCRIBE-SYMBOL)

(lem:define-key *normal-keymap* "Space f d" 'lem-core/commands/file:find-file-recursively)

(lem:define-key *normal-keymap* "C-b" 'lem:previous-buffer)
(lem:define-key *normal-keymap* "C-B" 'lem:next-buffer)

(lem:define-key *normal-keymap* "Space x" 'lem:execute-command) ;; 🚀

(lem:define-key *normal-keymap* "C-c n" 'lem-vi-mode/commands:vi-switch-to-buffer)

(lem:define-key *normal-keymap* "H" 'lem-vi-mode/commands:vi-move-to-beginning-of-line)
(lem:define-key *normal-keymap* "L" 'lem-vi-mode/commands:vi-move-to-end-of-line)

(lem:define-command big-next-line () () (lem-vi-mode/commands:vi-next-line 10))
(lem:define-key *normal-keymap* "J" 'big-next-line)

(lem:define-command big-prev-line () () (lem-vi-mode/commands:vi-previous-line 10))
(lem:define-key *normal-keymap* "K" 'big-prev-line)

(lem:define-key *normal-keymap* "Q" 'lem-vi-mode/commands:vi-execute-macro)

;; This is default, but a good example of setting an editor-variable
(setf (variable-value 'lem-vi-mode/text-objects:vi-operator-surrounding-blanks :global) nil)

;; Relative line numbers
(lem/line-numbers::line-numbers-mode)
;(setf (lem:variable-value 'lem/line-numbers:line-number-format :global) " ~2D ")
(setf lem/line-numbers:*relative-line* t)
;(setf lem/line-numbers::*zero-index-line* nil)

;; For Dev
(define-command load-vi-tests () ()
  (ql:quickload :lem-vi-mode/tests))

;; TODO
; Smart dd
; Expand/Reduce split
