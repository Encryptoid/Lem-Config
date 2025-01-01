;; Fullscreens on monitor 2 via python script (can't really copy)
(let ((output (uiop:run-program
               (concatenate 'string python-exe
                            " "
                            "/home/l/code/python/winman.py Lem 2") :output :string)))
  (lem:message "Captured: ~a~%" output))
