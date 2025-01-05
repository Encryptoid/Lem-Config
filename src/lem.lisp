(in-package :lem)

;; Font
(when (typep (lem:implementation) 'lem-sdl2/sdl2:sdl2)
  (let ((font-regular #P"/home/l/fonts/IosevkaNerdFont/IosevkaNerdFont-Regular.ttf")
        (font-bold #P"/home/l/fonts/IosevkaNerdFont/IosevkaNerdFont-Bold.ttf")
        (font-size 20)) ;; 20
    (lem-sdl2/display:change-font (lem-sdl2/display:current-display)
                                  (lem-sdl2/font:make-font-config
                                   :latin-normal-file font-regular
                                   :latin-bold-file font-bold
                                   :size font-size))))


;(when (typep (lem:implementation) 'lem-sdl2/sdl2:sdl2)
;  (let ((font-regular #P"/home/l/fonts/JetbrainsMonoNerdFont/JetBrainsMonoNLNerdFont-Regular.ttf")
;        (font-bold #P"/home/l/fonts/JetbrainsMonoNerdFont/JetBrainsMonoNLNerdFont-Bold.ttf")
;        (font-size 18))
;    (lem-sdl2/display:change-font (lem-sdl2/display:current-display)
;                                  (lem-sdl2/font:make-font-config
;                                   :latin-normal-file font-regular
;                                   :latin-bold-file font-bold
;                                   :size font-size))))


(lem-lisp-mode/paren-coloring::enable)

;; Messages Buffer
(define-command show-messages-buffer () ()
  (select-buffer "*Messages*"))
(define-key *global-keymap* "C-c m b" 'show-messages-buffer)

(define-key *global-keymap* "C-c m f" 'lem-lisp-mode:lisp-scratch)

;; Dashboard
(define-key *global-keymap* "C-c d" 'lem-dashboard:open-dashboard)
(define-key *global-keymap* "C-c n" 'lem-vi-mode/commands:vi-switch-to-buffer)

;; C-h Emacs Keys
; From https://github.com/lem-project/lem/discussions/1500
; I use `C-h` as `Left`, so using `C-c h` here.
(define-keys *global-keymap*
  ("C-c h a" 'lem-lisp-mode/internal:lisp-apropos)
  ("C-c h b" 'lem-core/commands/help::describe-bindings)
  ("C-c h f" 'lem-lisp-mode/internal:lisp-describe-symbol)
  ("C-c h k" 'lem-core/commands/help::describe-key)
  ("C-c h m" 'lem-core/commands/help::describe-mode)
  )

(asdf:load-asd (probe-file "/home/l/.plugins/lem/lem-rooms-client/lem-rooms-client.asd"))
(ql:quickload :lem-rooms-client)

;; Personal plugin development

;; QuickProject
; Allows you to make a project with asd and main file quickly.
; Example: (quickproject:make-project "<path-to-project>/<project-name>")
;(ql:quickload :quickproject)

;(quickproject:make-project "/home/l/code/lisp/lem/lem-treesitter")
;(asdf:load-asd (probe-file "/home/l/code/lisp/vi-collection/vi-collection.asd"))
;(ql:quickload :vi-collection)

;(vi-collection::tester)

;(asdf:load-asd (probe-file "/home/l/code/lisp/workspaces/workspaces.asd"))


;; Completion

;(run-hooks (variable-value 'self-insert-after-hook) char))

;(add-hook (variable-value 'lem-core/commands/edit:self-insert-after-hook) 'paredit-mode)

;(asdf:load-asd (probe-file "/home/l/code/lisp/lem/lem-treesitter/lem-treesitter.asd"))

;(asdf:load-asd (probe-file "/home/l/code/treesitter/cl-treesitter/cl-treesitter.asd"))
;(ql:quickload :cl-treesitter)


;(lem-lisp-mode/highlight::lisp-highlight)

(defmacro define-key-command (keymap key-name command-name (&rest lambda-list) (&rest qualifiers) &body body)
  `(progn
     (define-command ,command-name (,@lambda-list) (,@qualifiers)
       ,@body)
     (define-key ,keymap ,key-name ',command-name)))

(defmacro define-gkey-command (key-name command-name (&rest lambda-list) (&rest qualifiers) &body body)
  `(define-key-command *global-keymap* ,key-name ,command-name (,@lambda-list) (,@qualifiers)
     ,@body))

; vi-mode
(defmacro define-vkey-command (key-name command-name (&rest lambda-list) (&rest qualifiers) &body body)
  `(define-key-command lem-vi-mode:*normal-keymap* ,key-name ,command-name (,@lambda-list) (,@qualifiers)
     ,@body))
