
(import (scheme base)
        (tk))

(begin
  (tk-init '())
  (tk-wm 'title "." "turtle")
  (tk-grid (tk-canvas '.canvas '-width 600 '-height 600))
  (define (draw-line x1 y1 x2 y2)
    (tk-call '.canvas
             'create
             'line
             (+ 300 x1)
             (+ 300 y1)
             (+ 300 x2)
             (+ 300 y2))))
