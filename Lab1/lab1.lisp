(defun zero(X L &optional (Result `()) (Position 1))
    (cond
        ((null (car L)) Result)
        ((eq X (car L)) (zero X (cdr L) (append Result (cons Position nil)) (+ 1 Position)))
        (t (zero X (cdr L) Result (+ 1 Position)))
    )
)