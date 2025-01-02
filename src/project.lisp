(in-package lem-core/commands/project)

;; Look into checking if the root-files are in the dir, rather than just you being in the root file.
; (defun file-root-p (pathname)
;   "Overwites the base function to check if one of the root-files are in the dir"
;   (when (and (probe-file pathname) (directory-pathname-p pathname))
;     (let ((files (list-file-names pathname)))
;       (when (intersection *root-files* files :test #'equalp) t))))

(define-key *global-keymap* "C-c p" 'project-switch)
(define-key *global-keymap* "C-c C-p" 'project-switch)
(define-key *global-keymap* "C-c P" 'project-save-prompt)
