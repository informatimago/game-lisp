(defclass entity ()
    ((name
      :initarg :name)
     (hp
      :initarg :hp)
     (atk
      :initarg :atk)))
    
(defun make-entity (name hp atk)
    (make-instance 'entity :name name :hp hp :atk atk))

(defgeneric attack (entity target))
(defmethod attack ((e entity) (target entity))
    (let ((thp (slot-value target 'hp))
        (atk (slot-value e 'atk))))
        (setf (slot-value target 'hp) (- thp atk))))

(defvar enemy  (make-entity "bad guy" 10 10))
(defvar player (make-entity "player"  10 10))

(attack player enemy)
(print (slot-value enemy 'hp))