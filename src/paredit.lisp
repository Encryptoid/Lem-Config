(in-package :lem-paredit-mode)
;(add-hook lem-lisp-mode:*lisp-mode-hook* 'paredit-mode)

;; I don't know what keys are useful, would not recommend copying.
(define-keys *paredit-mode-keymap*
  ;; Use M-hjkl to move between parens
  ("M-l" 'paredit-forward)
  ;; ("m-l" 'lem-core/commands/s-expression:forward-sexp)
  ("M-h" 'paredit-backward)
  ;("M-h" 'lem-core/commands/s-expression:backward-sexp)
  ("M-j" 'lem-core/commands/s-expression:down-list)
  ("M-k" 'lem-core/commands/s-expression:up-list)

  ("C-9" 'paredit-wrap-round)
  ("C-H" 'lem-core/commands/s-expression:backward-sexp)
  ("C-L" 'lem-core/commands/s-expression:forward-sexp)

  ;;defaults noted to help learn
  ("M-r" 'paredit-raise)
  )

(define-keys *global-keymap*
  ("C-h" 'lem:backward-char)
  ("C-j" 'lem:next-line)
  ("C-k" 'lem:previous-line)
  ("C-l" 'lem:forward-char))
(undefine-key *paredit-mode-keymap* "C-k")

(undefine-key *paredit-mode-keymap* "[")
(define-key lem-vi-mode:*insert-keymap* "[" 'paredit-insert-bracket)

(undefine-key *paredit-mode-keymap* "{")
(define-key lem-vi-mode:*insert-keymap* "{" 'paredit-insert-brace)

(setq *remove-whitespace* t)

;; This highlights trailing spaces
; Taken from https://github.com/fukamachi/.lem/tree/master
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (change-buffer-mode buffer 'lem-trailing-spaces::trailing-spaces t)))

;; Test Area

;; (let ((lasjd))
;;   (if (ahjsdlkj) ())
;;   )
