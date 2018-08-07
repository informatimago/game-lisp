;;; GENERIC HELPERS
(defun prompt-read (prompt)
  (format *query-io* "~a: "prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun display-stats (p)
  (format t "~{~{~a: ~a~%~}~%~}" p))

(defun get-keys (obj)
  (loop for (key val) on obj by #'cddr collect key))
;;; END GENERIC HELPERS

;;; CHARACTER DEFS
(defvar *enemies* nil)
(defvar *players* nil)

(defun make-ent (hp atk name)
  (list :name name :hp hp :atk atk))

(defun make-player (hp atk)
  (make-ent hp atk (prompt-read "What is your name")))
;;; END CHARACTER DEFS

;;; BEGIN GAME
(defun main ()
  (loop
    do
      (game)
    while (y-or-n-p "Play again?")))

(defun game ()
  (if (eq *players* nil) (push (make-player 20  20) *players*) nil)
  (push (make-ent 100 5 "bad guy") *enemies* )
  (setf player (nth 0 *players*))
  (setf enemy (nth 0 *enemies*))
  (loop
    do
      (attack enemy player)
      (display-stats (list player enemy))
      (get-player-action *actions* player enemy)
    while (and (is-alive player) (is-alive enemy)))
  (format t (if (is-alive player) "YOU WIN!" "YOU LOSE!")
  (if (is-alive player) player enemy)))
;;; END GAME


;;;COMBAT FUNCTIONS
(defun is-alive (target)
  (> (getf target :hp) 0))

(defun take-damage (target amt)
  (let ((hp (getf target :hp)))
      (setf (getf target :hp) (- hp amt))))

(defun heal (target e &optional (amt 20))
  (let ((hp (getf target :hp)))
      (setf (getf target :hp) (+ hp amt))))

(defun attack (attacker defender)
  (take-damage defender (getf attacker :atk)))

(defun nothing (p e)
  (format t "You chose to do nothing..."))
;;; END COMBAT FUNCTIONS

;;; PLAYER ACTION DEFS
(defun display-player-actions (prompt actions)
  (setf action-names (get-keys actions))
  (loop for action in action-names
        for n from 1 do
    (format t "~a.~a~%" n action))
  (nth (1- (parse-integer (prompt-read prompt))) action-names))

(defvar *actions* (list
  :attack  #'attack
  :heal    #'heal
  :nothing #'nothing))

(defun get-player-action (actions player target)
  (funcall (getf actions
      (display-player-actions "What would you like to do" actions)
      actions) player target))

;; Instead of:

(defvar *actions* (list
                   :attack  #'attack
                   :heal    #'heal
                   :nothing #'nothing))


;; with:

(defclass action ()
  ((name :initarg :name :reader action-name)
   (function :initarg :function :reader action-function)))

(defmethod print-object ((action action) stream)
  (print-unreadable-object (action stream :identity t :type t)
    (format stream "~S" (action-name action)))
  action)

(defclass action-dictionary ()
  ((actions :initform '() :accessor action-dictionary-entries)))

(defmethod print-object ((dict action-dictionary) stream)
  (print-unreadable-object (dict stream :identity t :type t)
    (format stream "~{~&    ~s~}~&" (action-dictionary-entries dict)))
  dict)

(defun make-action-dictionary ()
  (make-instance 'action-dictionary))

(defun add-action (action-dict name function)
  (push (make-instance 'action :name name :function function)
        (action-dictionary-entries action-dict)))

(defun get-action-function (action-dict name)
  (action-function (find name (action-dictionary-entries action-dict)
                         :key (function action-name))))

;; ;; or
;;
;; (defun make-action-dictionary ()
;;   (cons :actions . nil))
;;
;; (defun add-action (action-list name function)
;;   (push (cons name function) (cdr action-list)))
;;
;; (defun get-action-function (action-list name)
;;   (cdr (assoc name (cdr action-list))))


;; write:

(defparameter *actions* (make-action-dictionary))

(add-action *actions* :attack #'attack)
(add-action *actions* :heal #'heal)
(add-action *actions* :nothing #'nothing)


;; (get-action-function *actions* :attack)
;; (funcall (get-action-function *actions* :attack) attacker victim)



;;; end player action defs

