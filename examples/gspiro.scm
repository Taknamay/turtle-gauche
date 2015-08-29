(import (turtle simple)
        (scheme base))

(define spiro (lambda (side aangle maxi)
  (subspiro side aangle maxi 1)
  (spiro side aangle maxi)))

(define subspiro (lambda (side aangle maxi count)
  (cond
    ((<= count maxi)
      (forward (* side count))
      (right aangle)
      (subspiro side aangle maxi (+ count 1))))))

(define gspiro (lambda (side aangle maxi listi)
  (subgspiro side aangle maxi listi 1)
  (gspiro side aangle maxi listi)))

(define subgspiro (lambda (side aangle maxi listi count)
  (cond
    ((<= count maxi)
      (forward (* side count))
      (cond
        ((member count listi)
          (left aangle))
        (else
          (right aangle)))
      (subgspiro side aangle maxi listi (+ count 1))))))

;(spiro 4 60 10)
;(gspiro 10 60 10 '(1 3 5))

