(defun zero (n list)

    (cond

        ((equal n 0) list)

        ((eq list nil) nil)

        (t (zero (- n 1) (cdr list)))

    )

)



(print (zero 10 '(a b c d f g)))