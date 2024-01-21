(define (over-or-under num1 num2)
  (if (> num1 num2) 1 (if (= num1 num2) 0 -1))
)

;;; Tests
(over-or-under 1 2)
; expect -1
(over-or-under 2 1)
; expect 1
(over-or-under 1 1)
; expect 0


(define (filter-lst fn lst)
  (define (filter-lst-helper fn lst result)
    (if (null? lst) 
      result 
      (if (fn (car lst))     
        (filter-lst-helper fn (cdr lst) (append result (list (car lst))))
        (filter-lst-helper fn (cdr lst) result))))
  (filter-lst-helper fn lst nil)
)


;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (make-adder num)
  (define (make-adder-helper other-num)
    (+ num other-num)
  )
  make-adder-helper
)

;;; Tests
(define adder (make-adder 5))
(adder 8)
; expect 13


(define lst
  (list (list 1) 2 (list 3 4) 5)
)


(define (composed f g)
  (define (composed-helper x)
    (f (g x))
  )
  composed-helper
)


(define (remove item lst)
  (define (is-equal x)
    (if (= x item)
      #f
      #t
    )
  )
  (filter-lst is-equal lst)
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)


(define (no-repeats s)
  (if (null? s) nil 
    (cons (car s) (no-repeats (remove (car s) (cdr s))))
  )
)


(define (substitute s old new)
 (define (filter-lst-helper fn lst result)
    (if (null? lst) 
      result 
      (if (fn (car lst))     
        (filter-lst-helper fn (cdr lst) (append result (list new)))
        (if (pair? (car lst))
          (filter-lst-helper fn (cdr lst) (append result (list (substitute (car lst) old new))))
          (filter-lst-helper fn (cdr lst) (append result (list (car lst))))
        )
      )
    )
  )
  (filter-lst-helper (lambda (x) (eq? x old)) s nil)
)


(define (sub-all s olds news)
  (if (null? olds)
    s
    (sub-all (substitute s (car olds) (car news)) (cdr olds) (cdr news))
  )
)

