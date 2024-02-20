(define (reverse lst)
    (if (null? lst)
        lst
        (append (reverse (cdr lst)) (list (car lst)))
    )
)

