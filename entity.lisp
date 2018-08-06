(defun prompt-read (prompt)
  (format *query-io* "~a: "prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defclass entity ()
    ((name
      :initarg :name
      :accessor name)
     (hp
      :initarg :hp
      :accessor hp)
     (atk
      :initarg :atk
      :accessor atk)))

(defclass player (entity) ())
    
(defun make-entity (name hp atk)
    (make-instance 'entity :name name :hp hp :atk atk))

(defun make-player (hp atk)
    (make-instance 'player :name (prompt-read "What is your name") :hp hp :atk atk))

(defgeneric take-damage (entity amt))
(defmethod take-damage ((e entity) amt)
    (setf (hp e) (- (hp e) amt)))

(defgeneric attack (entity target))
(defmethod attack ((e entity) (target entity))
    (take-damage target (atk e)))


(defmethod attack ((p player) (target entity))
    (print "What do you want to do? (take action based on player input)")
    (take-damage target (atk p)))

(defvar enemy  (make-entity "bad guy" 20 20))
(defvar player (make-player 10 10))

(attack player enemy)
(print (hp enemy))