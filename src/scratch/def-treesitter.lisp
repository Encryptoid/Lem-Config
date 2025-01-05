ts lines :: (SOURCE ((0 0) (10 5))
                    ((LIST_LIT ((0 0) (9 0)) ;; (sqrt -1)
                               (((VALUE SYM_LIT) ((1 0) (5 0)) NIL) ;; sqrt
                                ((VALUE NUM_LIT) ((6 0) (8 0)) NIL))) ;; -1
                     (LIST_LIT ((0 1) (8 1)) ;; (sqrt 2)
                               (((VALUE SYM_LIT) ((1 1) (5 1)) NIL) ;; sqrt
                                ((VALUE NUM_LIT) ((6 1) (7 1)) NIL))) ;; 2
                     (LIST_LIT ((0 2) (14 2)) ;; (expt 2 65536)
                               (((VALUE SYM_LIT) ((1 2) (5 2)) NIL) ;; expt
                                ((VALUE NUM_LIT) ((6 2) (7 2)) NIL) ;; 2
                                ((VALUE NUM_LIT) ((8 2) (13 2)) NIL))) ;; 65536
                     (LIST_LIT ((0 4) (10 5))
                               ((DEFUN ((0 4) (10 5))
                                    ((DEFUN_HEADER ((1 4) (15 4))
                                       (((KEYWORD DEFUN_KEYWORD) ((1 4) (6 4)) NIL)
                                        ((FUNCTION_NAME SYM_LIT) ((7 4) (12 4)) NIL)
                                        ((LAMBDA_LIST LIST_LIT) ((13 4) (15 4)) NIL)))
                                     ((VALUE LIST_LIT) ((2 5) (9 5)) ;; (+ 2 2)
                                      (((VALUE SYM_LIT) ((3 5) (4 5)) NIL) ;; +
                                       ((VALUE NUM_LIT) ((5 5) (6 5)) NIL) ;; 2
                                       ((VALUE NUM_LIT) ((7 5) (8 5)) NIL))))))))) ;; 2


(asdf:load-asd (probe-file "/home/l/code/treesitter/cl-tree-sitter/cl-tree-sitter.asd"))
(ql:quickload :cl-tree-sitter)
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")

;(cl-tree-sitter/low-level:ts-node-descendant-for-point-range :common-lisp "(defun hi ))" '(5 0))

;; Register the language first
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")

;; Create our point struct
(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

;; Create and setup parser
(defvar parser (cl-tree-sitter/low-level:ts-parser-new))
(cl-tree-sitter/low-level:ts-parser-set-language parser (cl-tree-sitter/low-level:language :common-lisp))

;; Parse the file
(defvar tree (cl-tree-sitter/low-level:ts-parser-parse-string
              parser
              (cffi:null-pointer)
              (uiop:read-file-string "/home/l/.lem/src/defs.lisp")
             (length (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))))

;; Get root node and find descendant
(defvar root-node (cl-tree-sitter/low-level:ts-tree-root-node tree))
(ts-node-named-descendant-for-point-range root-node point-ts point-ts)

(setf (cffi:foreign-slot-value point-ts 'cl-tree-sitter/low-level:ts-point row) 5)
(cffi:foreign-slot-value point-ts 'cl-tree-sitter/low-level:ts-point 'column)

;; Probably important..
; (foreign-free)

;; (setf (cffi:foreign-slot-value point-ts 'cl-tree-sitter/low-level:ts-point 'row) 5
;;   (cffi:foreign-slot-value point-ts 'cl-tree-sitter/low-level:ts-point 'column) 5)

;(defvar point-ts (cffi:foreign-alloc 'cl-tree-sitter/low-level:ts-point))



(cffi:with-foreign-slots ((row column) point-ts cl-tree-sitter/low-level::ts-point)
  (setf row 5
        column 5))

(cffi:)

(cffi:with-foreign-object (point-ts 'cl-tree-sitter/low-level:ts-point)
  ;(cffi:with-foreign-slots ((row column) 'point-ts 'cl-tree-sitter/low-level:ts-point)
    ;(format t "Row: ~a, Column: ~a~%" row column)
)


(cffi:with-foreign-object (point-ts 5)

  ;(cffi:with-foreign-slots ((row column) 'point-ts 'cl-tree-sitter/low-level:ts-point)
  ;(format t "Row: ~a, Column: ~a~%" row column)
)


(setf (cffi:foreign-slot-value point-ts 'cl-tree-sitter/low-level:ts-point 'row) 42
      (cffi:foreign-slot-value point-ts 'cl-tree-sitter/low-level:ts-point 'column) 42)

(setf (cffi:mem-ref point-ts 'cl-tree-sitter/low-level:ts-point) 5)


;; (cffi:with-foreign-slots ((row column) point-ts ts-pointer)
;;   (setf row 5
;;         column 5)))
;;   (cffi:with-foreign-slots ((row column) pete ts-pointer))

(defvar tester (make-pointer 42))

(cffi:with-foreign-object tester 'cl-tree-sitter/low-level:ts-point)

(defcstruct ts-point
(row :uint32)
(column :uint32))


(cffi:with-foreign-object (pete 'cl-tree-sitter/low-level:ts-point)
  (setf (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point :row) 5
      (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'column) 5)
  (cffi:with-foreign-slots ((row column) pete cl-tree-sitter/low-level:ts-point))
)

(cffi:with-foreign-object (pete 'cl-tree-sitter/low-level:ts-point)
  (setf (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'row) 5)
  (setf (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'column) 5)

;; Verify values
  (format t "Row: ~a, Column: ~a~%"
          (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'row)
          (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'column)))


(cffi:with-foreign-object (pete 'cl-tree-sitter/low-level:ts-point)
;; Set the fields
  (setf (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'row) 5)
  (setf (cffi:foreign-slot-value pete 'cl-tree-sitter/low-level:ts-point 'column) 5)

;; Access the fields using with-foreign-slots
  (cffi:with-foreign-slots ((row column) pete cl-tree-sitter/low-level:ts-point)
    (format t "Row: ~a, Column: ~a~%" row column)))

(lem:message tester)

(defvar pointer ('cl-tree-sitter/low-level::make-ts-point))

(cl-tree-sitter/low-level:ts-node-descendant-for-point-range :common-lisp def-ts '(5 0))


(let* ((lines (uiop:read-file-string (lem/buffer/internal::buffer-%filename (current-buffer))))
       (ts-lines (cl-tree-sitter:parse-string :common-lisp lines)))

#:ts-node-descendant-for-point-range


(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))

(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

(defvar ts-str (cl-tree-sitter:parse-string :common-lisp (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))))



(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

;; Create parser
(defvar parser (cl-tree-sitter/low-level:ts-parser-new))

;; Set language (we need to get the language from cl-tree-sitter)
;; Look at what cl-tree-sitter provides for getting the common lisp language
(describe 'cl-tree-sitter:*common-lisp-language*)

;; Then set it
(cl-tree-sitter/low-level:ts-parser-set-language parser )

;; Now parse
(defvar tree (cl-tree-sitter/low-level:ts-parser-parse-string
              parser
              (cffi:null-pointer)
              (uiop:read-file-string "/home/l/.lem/src/defs.lisp")
              (length (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))))

(defvar root-node (cl-tree-sitter/low-level:ts-tree-root-node tree))
(ts-node-named-descendant-for-point-range root-node point-ts point-ts)


;; Register the language first
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")

;; Create our point struct
(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

;; Create and setup parser
(defvar parser (cl-tree-sitter/low-level:ts-parser-new))
(cl-tree-sitter/low-level:ts-parser-set-language parser (cl-tree-sitter/high-level::language-module :common-lisp))

;; Parse the file
(defvar tree (cl-tree-sitter/low-level:ts-parser-parse-string
              parser
              (cffi:null-pointer)
              (uiop:read-file-string "/home/l/.lem/src/defs.lisp")
              (length (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))))

;; Get root node and find descendant
(defvar root-node (cl-tree-sitter/low-level:ts-tree-root-node tree))
(ts-node-named-descendant-for-point-range root-node point-ts point-ts)


;; Register the language first
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")

;; Create our point struct
(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

;; Create and setup parser
(defvar parser (cl-tree-sitter/low-level:ts-parser-new))
(format t "Parser pointer: ~A~%" parser)

;; Get and set language
(defvar lang (cl-tree-sitter/high-level::language-module :common-lisp))
(format t "Language pointer: ~A~%" lang)
(format t "Set language result: ~A~%"
        (cl-tree-sitter/low-level:ts-parser-set-language parser lang))

;; Parse the file
(defvar input-string (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))
(defvar tree (cl-tree-sitter/low-level:ts-parser-parse-string
              parser
              (cffi:null-pointer)
              input-string
              (length input-string)))
(format t "Tree pointer: ~A~%" tree)

;; Let's check if the tree pointer is null
(when (cffi:null-pointer-p tree)
  (error "Tree pointer is null after parsing"))

;; Get root node and find descendant
(defvar root-node (cl-tree-sitter/low-level:ts-tree-root-node tree))











;; Register the language first
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")

;; Create our point struct
(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

;; Create and setup parser
(defvar parser (cl-tree-sitter/low-level:ts-parser-new))

;; Get and set language
(defvar lang (cl-tree-sitter/high-level::language-module :common-lisp))
(cl-tree-sitter/low-level:ts-parser-set-language parser lang)

;; Parse the file - let's try with a simpler string first
(defvar test-string "(defun hello () (print \"hello\"))")
(defvar tree (cl-tree-sitter/low-level:ts-parser-parse-string
              parser
              (cffi:null-pointer)
              test-string
              (length test-string)))

(format t "Tree pointer for simple string: ~A~%" tree)



;; Load library first
(cffi:use-foreign-library cl-tree-sitter/low-level:tree-sitter)

;; Register the language
(cl-tree-sitter:register-language :common-lisp "/home/l/code/treesitter/tree-sitter-commonlisp/tree_sitter_commonlisp")

;; Create our point struct
(defvar point-ts (cffi:foreign-alloc '(:struct cl-tree-sitter/low-level:ts-point)))
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::row) 5)
(setf (cffi:foreign-slot-value point-ts '(:struct cl-tree-sitter/low-level:ts-point) 'cl-tree-sitter/low-level::column) 5)

;; Create and setup parser
(defvar parser (cl-tree-sitter/low-level:ts-parser-new))

;; Get and set language
(defvar lang (cl-tree-sitter/high-level::language-module :common-lisp))
(cl-tree-sitter/low-level:ts-parser-set-language parser lang)

;; Try with explicit encoding
(defvar test-string "(defun hello () (print \"hello\"))")
(defvar tree (cl-tree-sitter/low-level:ts-parser-parse-string-encoding
              parser
              (cffi:null-pointer)
              test-string
              (length test-string)
              :utf-8))

(format t "Tree pointer: ~A~%" tree)


;; Try high-level parse first
(defvar test-parse (cl-tree-sitter:parse-string :common-lisp "(+ 1 2)"))
(format t "High level parse result: ~A~%" test-parse)


;; Second Lib



(asdf:load-asd (probe-file "/home/l/code/treesitter/cl-treesitter/cl-treesitter.asd"))
(ql:quickload :cl-treesitter)


(treesitter:include-language "commonlisp")


(cfi:use-foreign-library "/home/l/code/treesitter/tree-sitter-commonlisp/libtree-sitter-commonlisp.so")
(cffi:defcfun "tree_sitter_commonlisp" :pointer)

(defvar *cl* (tree-sitter-commonlisp))

(let* ((parser (treesitter/bindings::ts-parser-new :language *cl*))
       (tree (treesitter/bindings::ts-parser-parse-string parser "(+ 1 2)"))
       (root (treesitter/bindings::ts-tree-root-node tree)))
  (print (treesitter/bindings::ts-node-string root))
  (treesitter/bindings::ts-node-delete root)
  (treesitter/bindings::ts-tree-delete tree)
  (treesitter/bindings::ts-parser-delete parser))


(cffi:use-foreign-library "/home/l/code/treesitter/tree-sitter-commonlisp/libtree-sitter-commonlisp.so")
(cffi:defcfun "tree_sitter_commonlisp" :pointer)
(defvar *cl* (tree-sitter-commonlisp))

(let* ((parser (treesitter/bindings::ts-parser-new :language *cl*))
       (tree (treesitter/bindings::ts-parser-parse-string parser "(+ 1 2)"))
       (root (treesitter/bindings::ts-tree-root-node tree)))

  ;; Print the S-expression structure
  (print (treesitter/bindings::ts-node-string root))

  ;; Get byte positions
  (format t "~%Start byte: ~A" (treesitter/bindings::ts-node-start-byte root))
  (format t "~%End byte: ~A" (treesitter/bindings::ts-node-end-byte root))

  ;; Get line/column positions
  (let ((start-point (treesitter/bindings::ts-node-start-point root))
        (end-point (treesitter/bindings::ts-node-end-point root)))
    (format t "~%Start position - Row: ~A, Column: ~A"
            (treesitter/bindings::ts-point-row start-point)
            (treesitter/bindings::ts-point-column start-point))
    (format t "~%End position - Row: ~A, Column: ~A"
            (treesitter/bindings::ts-point-row end-point)
            (treesitter/bindings::ts-point-column end-point))

    ;; Clean up points
    (treesitter/bindings::ts-point-delete start-point)
    (treesitter/bindings::ts-point-delete end-point))

  ;; Clean up main objects
  (treesitter/bindings::ts-node-delete root)
  (treesitter/bindings::ts-tree-delete tree)
  (treesitter/bindings::ts-parser-delete parser))


(let* ((parser (treesitter/bindings::ts-parser-new :language *cl*))
       (source (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))
       (tree (treesitter/bindings::ts-parser-parse-string parser source))
       (root (treesitter/bindings::ts-tree-root-node tree))
       ;; Get node at position 1
       (node (treesitter/bindings::ts-node-descendant-for-byte-range root 1 3)))

  (format t "Node type: ~A~%" (treesitter/bindings::ts-node-type node))
  (format t "Start byte: ~A~%" (treesitter/bindings::ts-node-start-byte node))
  (format t "End byte: ~A~%" (treesitter/bindings::ts-node-end-byte node))

  ;; Clean up
  (treesitter/bindings::ts-node-delete node)
  (treesitter/bindings::ts-node-delete root)
  (treesitter/bindings::ts-tree-delete tree)
  (treesitter/bindings::ts-parser-delete parser))


;; Using the high-level treesitter interface
(let* ((parser (treesitter:make-parser :language *lang*))
       (source (uiop:read-file-string "/home/l/.lem/src/defs.lisp"))
       (tree (treesitter:parser-parse-string parser source))
       (root (treesitter:tree-root-node tree))
       ;; Get node at position 1 (where the '+' symbol is)
       (node (treesitter:node-descendant-for-range root 4 4)))

  ;; Print information about the node
  (format t "Node type: ~A~%" (treesitter:node-type node))
  (format t "Node text: ~A~%" (treesitter:node-text node source))
  (format t "Start point: ~A~%" (treesitter:node-start-point node))
  (format t "End point: ~A~%" (treesitter:node-end-point node)))


;; Load the library directly
(cffi:use-foreign-library "/home/l/code/treesitter/tree-sitter-commonlisp/libtree-sitter-commonlisp.so")
(cffi:defcfun "tree_sitter_commonlisp" :pointer)

;; Add the constructor to the languages hash table manually
(setf (gethash :commonlisp treesitter:*languages*) 'tree-sitter-commonlisp)

;; Now make-language will work
(defvar *lang* (treesitter:make-language :commonlisp))
