(define (rle s)
  (define (rle-helper s result)
  (if (null? s)
  result
    (if (null? result)
        (rle-helper (cdr-stream s) (cons-stream (list (car s) 1) nil))
        (if (= (car s) (car (car result)))
            (rle-helper (cdr-stream s) (cons-stream (list (car (car result)) (+ 1 (car (cdr (car result))))) (cdr-stream result)))
            (rle-helper (cdr-stream s) (cons-stream (car result) (rle-helper (cons-stream (car s) nil) (cdr-stream result))))
        )
    )
  )
  )
  (rle-helper s nil)
)



(define (group-by-nondecreasing s)
 (define (gbn-helper s last lst-num)
  (if (null? s)
    (if (null? last)
        nil
        (cons-stream last nil)
    )
    (if (null? last)
        (gbn-helper (cdr-stream s) (list (car s)) (car s))
        (if (>= (car s) lst-num)
            (gbn-helper (cdr-stream s) (append last (list (car s))) (car s))
            (cons-stream last (gbn-helper (cdr-stream s) (list (car s)) (car s)))
        )
    )
  )
 )
 (gbn-helper s nil nil)
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

