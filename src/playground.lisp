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
; Discussion: https://github.com/lem-project/lem/discussions/1730

; Load Bindings
; https://github.com/death/cl-tree-sitter
(asdf:load-asd (probe-file "/home/l/code/treesitter/cl-tree-sitter/cl-tree-sitter.asd"))
(ql:quickload :cl-tree-sitter)

; Connect to .so file
; https://github.com/tree-sitter-grammars/tree-sitter-commonlisp
(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/libtree-sitter-commonlisp")
(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/libtree_sitter_commonlisp")
(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/tree_sitter_commonlisp")

(cl-tree-sitter:register-language :common-lisp "/home/l/.lem/src/tree-sitter-commonlisp")

; Not finiding: libtree_sitter_commonlisp, with underscores, but can't find a direct reference to this.
(cl-tree-sitter:parse-string :common-lisp "(list 2 2)")

; This works, although `make` generates: `libtree-sitter-c`, which I had to rename to `tree-sitter-c`
; Because of this, I imagine I have to get the CL naming right but can't work it out.
(cl-tree-sitter:register-language :c "/usr/local/lib/libtree-sitter-c")
(cl-tree-sitter:register-language :c "/home/l/.lem/src/tree-sitter-c")
(cl-tree-sitter:parse-string :c "int main() { return 42; }")

