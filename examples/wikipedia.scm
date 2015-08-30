
; https://commons.wikimedia.org/wiki/File:Remi_turtlegrafik.png

(import (scheme base)
        (turtle simple))

(define (n-eck ne sz)
  (let loop ((i 0))
    (when (< i ne)
      (rt (/ 360 ne))
      (fd sz)
      (loop (+ i 1)))))

(define (mn-eck ne sz)
  (let loop ((i 0))
    (when (< i ne)
      (rt (/ 360 ne))
      (n-eck ne sz)
      (loop (+ i 1)))))

(bg-color 'darkred)
(mn-eck 36 20)
