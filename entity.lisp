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

(defun make-entity (name hp atk)
    (make-instance 'entity :name name :hp hp :atk atk))

(defgeneric attack (entity target))
(defgeneric take-damag (entity target))
(defmethod attack ((e entity) (target entity))
    (let ((thp (hp target))
        (atk (atk e)))
        (setf (hp target) (- thp atk))))

(defvar *enemy*)
(defvar *player*)

(defun initialize ()
  (setf *enemy*  (make-entity "bad guy" 10 20)
        *player* (make-entity "player"  10 10)))



