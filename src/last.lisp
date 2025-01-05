;; This file is last so it doesn't break other files as easily.

(asdf:load-asd (probe-file "/home/l/code/treesitter/cl-treesitter/cl-treesitter.asd"))
(ql:quickload :cl-treesitter)

;(asdf:load-asd (probe-file "/home/l/code/lisp/lem/lem-treesitter/lem-treesitter.asd"))
;(ql:quickload :lem-treesitter)

(asdf:load-asd (probe-file "/home/l/.plugins/lem/lem-treesitter-mode/lem-treesitter-mode.asd"))
(ql:quickload :lem-treesitter-mode)
