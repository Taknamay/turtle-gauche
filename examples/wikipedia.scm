
; https://commons.wikimedia.org/wiki/File:Remi_turtlegrafik.png

(import (scheme base)
        (turtle simple))

(define (n-eck ne sz)
  (repeat (ne)
    (rt (/ 360 ne))
    (fd sz)))

(define (mn-eck ne sz)
  (repeat (ne)
    (rt (/ 360 ne))
    (n-eck ne sz)))

(bg-color 'darkred)
(hide)
(mn-eck 36 20)
