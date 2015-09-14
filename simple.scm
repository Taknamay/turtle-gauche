
(define-library (turtle simple)
  (import (turtle turtle3)
          (scheme case-lambda)
          (scheme base))
  (export forward back right left up down
          fd bk rt lt pu pd
          pos set-pos tilt set-tilt
          bg-color line-color line-width
          show hide draw-line home reset-tilt
          repeat xcor ycor)
  (begin
    (define current-tilt 0)
    (define (tilt)
      current-tilt)
    (define (set-tilt theta)
      (image-rotate current-tilt (- current-tilt theta))
      (yaw! t current-tilt)
      (set! current-tilt theta)
      (yaw! t (- theta)))
    (define t (turtle-init))
    (show! t)
    (define (home)
      (set-pos 0 0))
    (define (reset-tilt)
      (set-tilt 0))
    (define (show)
      (show! t))
    (define (hide)
      (hide! t))
    (define (forward dist)
      (forward! t dist))
    (define (back dist)
      (forward! t (- dist)))
    (define (right theta)
      (image-rotate current-tilt theta)
      (set! current-tilt (+ current-tilt theta))
      (yaw! t (- theta)))
    (define (left theta)
      (image-rotate current-tilt theta)
      (set! current-tilt (- current-tilt theta))
      (yaw! t theta))
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
       ((x y) (set-pos (vector x y)))))

    (define (xcor)
      (vector-ref (pos) 0))

    (define (ycor)
      (vector-ref (pos) 1))))
