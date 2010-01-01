(defparameter *order* 0.333)

(defun concat (strs)
  (format nil "~{~A~}" strs))

(defun choose-from-stack (stack chaos order)
  (cond
    ((null stack) nil)
    ((< (random 1.0 chaos) order) (car stack))
    (t (choose-from-stack (cdr stack) chaos order))))

(defun random-choice (letters len chaos)
  (elt letters (random len chaos)))

(defun zoboznonikikfal ()
  (concat
   (let* ((chaos (make-random-state t))
          (order (random 1.0 chaos))
          (letters "ABCDEFGHIJKLMNOPQRSTUVWXYZ!*^abcdefghijklmnopqrstuvwxyz") 
          (len (length letters))
          (stack (list (random-choice letters len chaos))))
     (loop for x from 1 to 140 collect 
          (or (let ((stack-choice (choose-from-stack stack chaos *order*)))
                (if (null stack-choice) nil
                    (progn
                      (setq stack (cons stack-choice (remove stack-choice stack)))
                      stack-choice)))
              (let ((letter-choice (random-choice letters len chaos)))
                (setq stack (cons letter-choice stack))
                letter-choice))))))

(defun main ()
  (write-sequence (zoboznonikikfal) *standard-output*))

;; (load "/Users/rspangler/lisp/zoboznonikikfal.lisp")
;; (sb-ext:save-lisp-and-die "zoboznonikikfal" :executable t :toplevel 'main)