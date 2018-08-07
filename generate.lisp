
(load (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname)))

(push (make-pathname :defaults (or *load-pathname*
                                   (error "this file must be loaded, not compiled."))
                     :name nil :type nil :version nil)
      asdf:*central-registry*)
;; (push #P"./" asdf:*central-registry*)

(ql:quickload :game)


(defun test-main (arguments)
  (map nil 'print arguments)
  (initialize)
  (attack *player* *enemy*)
  (attack *enemy* *player*)
  (format t "hp of enemy  = ~A~%" (hp *enemy*))
  (format t "hp of player = ~A~%" (hp *player*))
  0)


(ext:saveinitmem "game"
                 :executable t
                 :quiet t
                 :verbose t
                 :norc t
                 :init-function (lambda ()
                                  (handler-case
                                      (unwind-protect
                                           (ext:exit (test-main ext:*args*))
                                        (finish-output *standard-output*))
                                    (error (err)
                                      (format *error-output* "~A~%" err)
                                      (finish-output *error-output*)
                                      (ext:exit 1)))))
