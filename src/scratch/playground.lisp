;; File is not loaded

(in-package :lem)

;; Find Command Example
(lem:find-command "terminal")

;; List playground
(defclass my-list (multi-column-list)
  ((compute-items-function :initarg :compute-items-function
                           :initform nil
                           :reader context-menu-compute-items-function))
  )

;(display (make-instance 'my-list :items items)
;         :style '(:gravity :cursor)))

(defclass context-menu (multi-column-list)
  ((compute-items-function :initarg :compute-items-function
                           :initform nil
                           :reader context-menu-compute-items-function)
   (last-selected-item :initform nil
                       :accessor context-menu-last-selected-item))
  (:default-initargs :columns '()))


(defun get-items ()
 (list "hi"))

(lem/multi-column-list:display
  (make-instance 'lem/multi-column-list:multi-column-list
               :columns '("Single")
               :column-function (lambda (component buffer)
                                  (list buffer))
               :items (get-items)
               :filter-function #'completion-buffer
               :select-callback (lambda (component buffer)
                                  )
               :delete-callback (lambda (component buffer)
                                  )
               :use-check t
               ;:context-menu (make-instance
               ;               'lem/context-menu:context-menu
               ;               :items (list (make-instance 'lem/context-menu:item
               ;                                           :label "Kill selected buffers"
               ;                                           )
               ;                            (make-instance 'lem/context-menu:item
               ;                                           :label "Save selected buffers"
               ;                                           )))
               ))


;; Treesitter
; See here for main details: https://github.com/lem-project/lem/discussions/1730

; Load Bindings
; https://github.com/death/cl-tree-sitter
(asdf:load-asd (probe-file "/home/l/code/treesitter/cl-tree-sitter/cl-tree-sitter.asd"))
(ql:quickload :cl-tree-sitter)

; Connect to .so file
; https://github.com/tree-sitter-grammars/tree-sitter-commonlisp
;(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/libtree-sitter-commonlisp")
;(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/libtree_sitter_commonlisp")
;(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/tree_sitter_commonlisp")
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")
;(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree-sitter-commonlisp")

;(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/tree-sitter-commonlisp")

; Not finiding: libtree_sitter_commonlisp, with underscores, but can't find a direct reference to this.
(cl-tree-sitter:parse-string :common-lisp "(defun hi () (cond (t (lem:message \"hi\")))")

; This works, although `make` generates: `libtree-sitter-c`, which I had to rename to `tree-sitter-c`
; Because of this, I imagine I have to get the CL naming right but can't work it out.
(cl-tree-sitter:register-language :c "/usr/local/lib/libtree-sitter-c")
(cl-tree-sitter:register-language :c "/home/l/code/treesitter/tree-sitter-c/tree-sitter-c")
(cl-tree-sitter:parse-string :c "int main() { return 42; }")

; lem/buffer/file:insert-file-contents (point filename


(define-command treesitter-current-buffer () ()
  (let* ((lines (uiop:read-file-string (lem/buffer/internal::buffer-%filename (current-buffer))))
         (ts-lines (cl-tree-sitter:parse-string :common-lisp lines)))
    (lem:message "TS LINES :: ~a" ts-lines)))

(define-key *global-keymap* "C-c t" 'treesitter-current-buffer)

(getf (current-buffer) :%filename)

(lem/buffer/internal::buffer-%directory (current-buffer))
(lem/buffer/internal::buffer-%filename (current-buffer))

%directory
(current-buffer)
;; Modeline

(defstruct (test-modeline-element (:conc-name element-))
  name
  attribute)

(defvar *modeline-element* (make-test-modeline-element))
(setf *modeline-element* (make-test-modeline-element))
(setf (element-name *modeline-element*) "hi")

(lem:message "~a" *modeline-element*)

(pushnew *modeline-element* (lem:variable-value 'lem:modeline-format :global))

; Clear
(setf (lem:variable-value 'lem:modeline-format :global) (list))

;; Lime
(asdf:load-asd (probe-file "/home/l/code/lisp/lem/lem-lime/lem-lime.asd"))
(ql:quickload :lem-lime)

(defvar change nil)

(defun adder ()
(+ 1 1))

(defun test-buffer-change (start end old-len)
  (let ((log-message (format nil "CHANGE: Start: ~A, End: ~A, Old: ~A~%"
                             start end old-len)))
    (with-open-file (stream "~/.lem/src/buffer-changes.log"
                            :direction :output
                            :if-exists :append
                            :if-does-not-exist :create)
      (write-string log-message stream))
    log-message))

(format nil "Change: ~a" change)
ak
(variable-value 'lem/buffer/internal:after-change-functions :buffer)
ablee
;; BUFFER change hook
; This hook is sufficient with a bit of maths on the reslts from it
; It keeps getting removed though
(add-hook (variable-value 'lem/buffer/internal:after-change-functions :buffer) 'test-buffer-change)
abcdskdjdjaldjflakjasdlfasaklk
 the
(define-vkey-command  "Space h c" hook-change () ()
  (add-hook (variable-value 'lem/buffer/internal:after-change-functions :buffer) 'test-buffer-change)
  (lem:message "Watching for file changes"))

(variable-value 'lem/buffer/internal:after-change-functions :buffer)
(insert-string (current-point) "h")
