(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (x) (append (list first) x)) rests)
)

(define (zip pairs)
  (append (list (map (lambda (x) (car x)) pairs)) (list (map (lambda (x) (cadr x)) pairs)))
)

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  (define (enumerate-helper s result index)
    (if (not (null? s))
      (enumerate-helper (cdr s) (append result (list (list index (car s)))) (+ index 1))
      result
    )
  )
  (enumerate-helper s () 0)
  )
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
    
      (cond 
        (
          (< total (car denoms)) 
          ( 
            if (null? (cdr denoms))
            ()
            (list-change total (cdr denoms))
          )
        )
        (
          (= total (car denoms)) 
          (
            if (null? (cdr denoms))
            (list (list (car denoms)))
            (append (list (list (car denoms))) (list-change total (cdr denoms)))
          )
        )
        (
          (> total (car denoms))
            (if (null? (cdr denoms))
            (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
            (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms))(list-change total (cdr denoms))))
          
        )
      )
  )
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (cons form (cons params (map let-to-lambda body)))
           
            ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (append (list (cons 'lambda (cons (map let-to-lambda (car (zip values))) (map let-to-lambda body)))) (map let-to-lambda (cadr (zip values))))
           ; END PROBLEM 18
           ))
        (else
         ; BEGIN PROBLEM 18
          (cons (car expr) (map let-to-lambda (cdr expr)))
         ; END PROBLEM 18
         )))