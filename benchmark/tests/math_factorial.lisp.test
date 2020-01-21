(setq maxLimit 1000)
(defun factorial (n)
  (if (zerop n) 1 (* n (factorial (1- n)))))
(loop for n from 0 below maxLimit
  	   do ((princ (factorial n))(terpri)))
