(in-package :lem)


(defclass my-list (multi-column-list)
  ((compute-items-function :initarg :compute-items-function
                           :initform nil
                           :reader context-menu-compute-items-function))
  )

(display (make-instance 'my-list :items items)
         :style '(:gravity :cursor)))

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







