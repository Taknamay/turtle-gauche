
(import (scheme base)
        (tk))

(begin
  (tk-init '())
  (tk-wm 'title "." "turtle")
  (tk-grid (tk-canvas '.canvas))
  (define (draw-line x1 y1 x2 y2)
    (tk-call '.canvas 'create 'line x1 y1 x2 y2)))
