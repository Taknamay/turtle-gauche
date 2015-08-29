
(import (scheme base))

(define (rotate vec pvec theta-degs)
  (define theta (degrees->radians theta-degs))
  (add-vectors (scale-vector vec
                             (cos theta))
               (scale-vector pvec
                             (sin theta))))

(define (add-vectors . vs)
  (list->vector (apply map + (map vector->list vs))))

(define (scale-vector v k)
  (vector-map (lambda (x)
         (* x k))
       v))

(define (negate-vector v)
  (scale-vector v -1))

(define pi (* 2 (acos 0)))

(define (degrees->radians degs)
  (* degs (/ pi 180)))
