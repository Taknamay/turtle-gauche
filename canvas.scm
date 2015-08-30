(define-library (turtle canvas)
  (import (scheme base)
          (tk))
  (export draw-line canvas-line-color canvas-bg-color)
  (begin
    (define canvas-line-color #f)
    (define canvas-bg-color #f)
    (define (draw-line x1 y1 x2 y2)
      (tk-call '.canvas
               'create
               'line
               (+ 300 x1)
               (+ 300 y1)
               (+ 300 x2)
               (+ 300 y2)
               '-fill
               'white))
    (tk-init '())
    (tk-wm 'title "." "turtle")
    (tk-grid (tk-canvas '.canvas '-width 600 '-height 600 '-bg 'black))))
