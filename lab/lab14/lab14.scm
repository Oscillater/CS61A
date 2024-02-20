(define (split-at lst n)
  (define (split-at-helper first last n)
	(if (null? last)
		(cons first nil)
		(if (= n 0)
			(cons first last)
			(split-at-helper (append first (list (car last))) (cdr last) (- n 1))
		)
	)
  )
  (split-at-helper () lst)
)


(define-macro (switch expr cases)
	(cons 'cond
		(map (lambda (case) (cons (eq? (eval expr) (car case)) (cdr case)))
    			cases)
	)
)

