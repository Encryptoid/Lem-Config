(in-package #:cl-user)

(asdf/parse-defsystem:defsystem "lem-site-init"
  :depends-on ("lem-trailing-spaces")
  :components ((:module "src"
                :components (
                             (:file "windows")
                             (:file "lem")
                             (:file "vi-mode")
                             (:file "paredit")
                             (:file "minibuffer")
                             (:file "multiplexer")
                             (:file "project")
                             (:file "last")
                             ))))
