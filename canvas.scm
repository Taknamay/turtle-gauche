
(define-library (turtle canvas)
  (import (scheme base)
          (scheme inexact)
          (tk))
  (export draw-line canvas-line-color canvas-bg-color canvas-line-width
          canvas-image-rotate)
  (begin
    (define canvas-image-rotate #f)

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

    (define current-line-width 1)

    (define (canvas-line-width width)
      (set! current-line-width width))

    (define current-line-color 'white)

    (define valid-colors 
      '(white black red yellow green cyan blue magenta
        grey darkred darkgreen darkblue violet))

    (define (draw-line x1 y1 x2 y2)
      (tk-call '.canvas
               'create
               'line
               (+ 300 x1)
               (+ 300 y1)
               (+ 300 x2)
               (+ 300 y2)
               '-fill
               current-line-color
               '-width
               current-line-width))

    (define (redraw-turtle x y theta-deg turtle-size)
      (define theta (* theta-deg (/ 3.141592653589792 180)))
      (define (draw-circle x y size)
        (tk-call '.canvas
                 'create
                 'oval
                 (- x (/ size 2.0))
                 (- y (/ size 2.0))
                 (+ x (/ size 2.0))
                 (+ y (/ size 2.0))
                 '-tags
                 "turtle"
                 '-fill
                 current-line-color))
      ; Create the body
      (draw-circle x y turtle-size)
      ; Create the head
      (draw-circle (+ x (* 0.75 turtle-size (cos theta)))
                   (+ y (* 0.75 turtle-size (sin theta)))
                   (/ turtle-size 2))
      ; Create the front legs
      (draw-circle (+ x (* 0.625 turtle-size (cos (+ theta 0.785))))
                   (+ y (* 0.625 turtle-size (sin (+ theta 0.785))))
                   (/ turtle-size 4))
      (draw-circle (+ x (* 0.625 turtle-size (cos (- theta 0.785))))
                   (+ y (* 0.625 turtle-size (sin (- theta 0.785))))
                   (/ turtle-size 4))
      ; Create the rear legs
      (draw-circle (+ x (* 0.625 turtle-size (cos (+ theta 2.356))))
                   (+ y (* 0.625 turtle-size (sin (+ theta 2.356))))
                   (/ turtle-size 4))
      (draw-circle (+ x (* 0.625 turtle-size (cos (- theta 2.356))))
                   (+ y (* 0.625 turtle-size (sin (- theta 2.356))))
                   (/ turtle-size 4)))

    (tk-init '())
    (tk-wm 'title "." "turtle")
    (tk-grid (tk-canvas '.canvas '-width 600 '-height 600 '-bg 'black))
    (redraw-turtle 300 300 0 16)))
