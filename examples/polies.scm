
(import (turtle simple)
        (scheme base))

(define poly (lambda (side aangle)
  (forward side)
  (right aangle)
  (poly side aangle)))

(define polystop (lambda l
  (define turn (cond ((< (length l) 2)
                      (error "polystop: Not enough args"))
                     ((= (length l) 2)
                      0)
                     (else
                      (list-ref l 2))))
  (define side (list-ref l 0))
  (define aangle (list-ref l 1))
  (cond ((or (not (= (modulo turn 360) 0)) (= turn 0))
    (forward side)
    (right aangle)
    (polystop side aangle (+ aangle turn))))))

;(poly 100 141.914)
(polystop 150 144 0)
;(polystop 5 5 0)
