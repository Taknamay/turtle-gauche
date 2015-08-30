
(define-library (turtle canvas)
  (import (scheme base)
          (tk))
  (export draw-line canvas-line-color canvas-bg-color)
  (begin
    (define (canvas-bg-color color)
      (if (memq color valid-colors)
          (tk-call '.canvas
                   'configure
                   '-bg
                   color)
          (error "bg-color" "Not a valid color")))
    (define (canvas-line-color color)
      (if (memq color valid-colors)
          (set! current-line-color color)
          (error "bg-color" "Not a valid color")))
    (define current-line-color 'white)
    (define valid-colors '(white black red yellow green cyan blue magenta))
    (define (draw-line x1 y1 x2 y2)
      (tk-call '.canvas
               'create
               'line
               (+ 300 x1)
               (+ 300 y1)
               (+ 300 x2)
               (+ 300 y2)
               '-fill
               current-line-color))
    (tk-init '())
    (tk-wm 'title "." "turtle")
    (tk-grid (tk-canvas '.canvas '-width 600 '-height 600 '-bg 'black))))
