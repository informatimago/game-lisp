(defun prompt-read (prompt)
  (format       *query-io* "~a: "prompt)
  (force-output *query-io*)
  (read-line    *query-io*))
(defun prnt (s)
  (format t "~a~%" s))

;;; class definitions
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
    

;;;constructors
(defun make-entity (name hp atk)
  (make-instance 'entity :name name :hp hp :atk atk))

;;; should this prompt-read call be placed as an 
;;; initform inside the player defclass?
(defun make-player (hp atk)
  (make-instance 'player :name (prompt-read "What is your name") :hp hp :atk atk))

;;; entity and entity-subclass methods
(defgeneric take-damage (entity amt))
(defmethod  take-damage ((e entity) amt)
  (setf (hp e) (- (hp e) amt)))

(defgeneric attack (entity target))
(defmethod  attack ((e entity) (target entity))
  (take-damage target (atk e)))

;;; the player attack should do something different
;;; eventually reading player input and deiding what
;;; actions to perform
(defmethod attack ((p player) (target entity))
  (prnt "What do you want to do? (take action based on player input)")
  (take-damage target (atk p)))


(defvar *enemy*)
(defvar *player*)

(defun initialize ()
  (setf *enemy*  (make-entity "bad guy" 10 20)
        *player* (make-entity "player"  10 10)))

