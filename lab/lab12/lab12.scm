
(define-macro (def func args body)
    `(define ,func (lambda ,args ,body))
)


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (cons-stream 3 (map-stream (lambda (x) (+ 3 x)) all-three-multiples))
)


(define (compose-all funcs)
  (define (compose num)
    (if (null? funcs)
      num
      ((compose-all (cdr funcs)) ((car funcs) num))
    )
  )
  compose
)


(define (partial-sums stream)
  (define (add-stream stream1 stream2)
    (if (null? stream1)
    nil
    (cons-stream (+ (car stream1) (car stream2)) (add-stream (cdr-stream stream1) (cdr-stream stream2)))
    )
  )
  (if (null? stream)
    nil
    (cons-stream (car stream) (add-stream (cdr-stream stream) (partial-sums stream)))
  )
)

