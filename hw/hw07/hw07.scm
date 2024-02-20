(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)


(define (sign num)
  (cond 
    ((< num 0) -1)
    ((= num 0) 0)
    (else 1)
  )
)


(define (square x) (* x x))

(define (pow x y)
  (cond
    ((= y 0) 1)
    ((= y 1) x)
    ((even? y) (square (pow x (/ y 2))))
    (else (* x (square (pow x (/ (- y 1) 2)))))
  )
)

(define (remove item lst)
  (define (is-equal x)
    (if (equal? x item)
      #f
      #t
    )
  )
  (filter is-equal lst)
)

(define (unique s)
  (if (null? s) nil 
    (cons (car s) (unique (remove (car s) (cdr s))))
  )
)


(define (replicate x n)
  (define (replicate-helper x n result)
    (if (= n 0)
      result
      (replicate-helper x (- n 1) (append (list x) result) )
    )
  )
  (replicate-helper x n ())
)


(define (accumulate combiner start n term)
  (define (accumulate-helper combiner n term result)
    (if (= n 0) 
      result
      (accumulate-helper combiner (- n 1) term (combiner (term n) result))
    )
  )
  (accumulate-helper combiner n term start)
)


(define (accumulate-tail combiner start n term)
  (define (accumulate-helper combiner n term result)
    (if (= n 0) 
      result
      (accumulate-helper combiner (- n 1) term (combiner (term n) result))
    )
  )
  (accumulate-helper combiner n term start)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  (list 'map (list 'lambda (list var) map-expr) (list 'filter (list 'lambda (list var) filter-expr) lst))
)

