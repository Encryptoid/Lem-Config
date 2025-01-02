(in-package :lem)

;; Font
(when (typep (lem:implementation) 'lem-sdl2/sdl2:sdl2)
  (let ((font-regular #P"/home/l/fonts/IosevkaNerdFont/IosevkaNerdFont-Regular.ttf")
        (font-bold #P"/home/l/fonts/IosevkaNerdFont/IosevkaNerdFont-Bold.ttf")
        (font-size 20))
    (lem-sdl2/display:change-font (lem-sdl2/display:current-display)
                                  (lem-sdl2/font:make-font-config
                                   :latin-normal-file font-regular
                                   :latin-bold-file font-bold
                                   :size font-size))))

(lem-lisp-mode/paren-coloring::enable)

;; Messages Buffer
(define-command show-messages-buffer () ()
  (select-buffer "*Messages*"))
(define-key *global-keymap* "C-c m" 'show-messages-buffer)

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

;(asdf:load-asd (probe-file "/home/l/code/lisp/vi-collection/vi-collection.asd"))
;(ql:quickload :vi-collection)

;(vi-collection::tester)

;(asdf:load-asd (probe-file "/home/l/code/lisp/workspaces/workspaces.asd"))