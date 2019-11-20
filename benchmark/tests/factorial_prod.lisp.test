(setq maxLimit 1000)
(defun factorial (n)
    (reduce #'* (loop for i from 1 to n collect i)))
(loop for n from 0 below maxLimit
  	   do ((princ (factorial n))(terpri)))
