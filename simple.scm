
(define-library (turtle simple)
  (import (turtle turtle3)
          (scheme case-lambda)
          (scheme base))
  (export forward back right left up down
          fd bk rt lt pu pd
          pos set-pos
          bg-color line-color line-width)
  (begin
    (define t (turtle-init))
    (define (forward dist)
      (forward! t dist))
    (define (back dist)
      (forward! t (- dist)))
    (define (right theta)
      (yaw! t theta))
    (define (left theta)
      (yaw! t (- theta)))
    (define (up)
      (pen-up! t))
    (define (down)
      (pen-down! t))
    (define fd forward)
    (define bk back)
    (define lt left)
    (define rt right)
    (define pu up)
    (define pd down)

    (define (pos)
      (get-pos t))

    (define set-pos
      (case-lambda
       ((v) (set-pos! t (vector-append v #(0))))
       ((x y) (set-pos (vector x y)))))))
