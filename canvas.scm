
(define-library (turtle canvas)
  (import (scheme base)
          (scheme inexact)
          (gauche process)
          (tk))
  (export draw-line canvas-line-color canvas-bg-color canvas-line-width
          canvas-image-rotate draw-turtle-line)
  (begin
    (define (canvas-image-rotate x y theta1 delta-theta)
      (define sign (if (negative? delta-theta) - +))
      (let loop ((current-theta 0))
        (when (< current-theta (abs delta-theta))
          (redraw-turtle x y (sign theta1 current-theta) 24)
          (loop (+ current-theta 2)))))

    (define sleep-period 0.01)

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

    (define (draw-turtle-line x1 y1 x2 y2 pen-down shown)
      (define dist (sqrt (+ (square (- x2 x1))
                            (square (- y2 y1)))))
      (define xtrav (if (= x1 x2)
                        0
                        (/ (- x2 x1) dist 0.32)))
      (define ytrav (if (= y1 y2)
                        0
                        (/ (- y2 y1) dist 0.32)))
      (define dtrav (sqrt (+ (square xtrav)
                             (square ytrav))))
      (define theta (* (/ 180 3.1415926)
                       (if (negative? (- x2 x1))
                           (- (atan (/ (- y2 y1) (- x2 x1))) 3.1415)
                           (atan (/ (- y2 y1) (- x2 x1))))))
      (when (> dist 1e-10)
        (if shown
            (redraw-turtle x1 y1 theta 24)
            (tk-call '.canvas 'delete 'turtle))
        (cond
         (shown
          (let loop ((curd 0)
                     (curx x1)
                     (cury y1))
            (when (< curd dist)
              (run-process "sleep" sleep-period :wait #t)
              (tk-call '.canvas 'move 'turtle xtrav (- ytrav))
              (if pen-down
                  (draw-line curx cury (+ curx xtrav) (+ cury ytrav)))
              (loop (+ curd dtrav) (+ curx xtrav) (+ cury ytrav)))))
         (pen-down
          (draw-line x1 y1 x2 y2))
         (else ; Otherwise do nothing
          #f))))

    (define (draw-line x1 y1 x2 y2)
      (tk-call '.canvas
               'create
               'line
               (+ 300 x1)
               (- 300 y1)
               (+ 300 x2)
               (- 300 y2)
               '-fill
               current-line-color
               '-width
               current-line-width))

    (define (redraw-turtle x y-neg theta-deg turtle-size)
      (define y (- y-neg))
      (define theta (- (* theta-deg (/ 3.141592653589792 180))))
      (define (draw-circle x y size tags)
        (tk-call '.canvas
                 'create
                 'oval
                 (- x -300 (/ size 2.0))
                 (- y -300 (/ size 2.0))
                 (+ x  300 (/ size 2.0))
                 (+ y  300 (/ size 2.0))
                 '-tags
                 tags
                 '-fill
                 current-line-color))
      ; Delete any previous turtles
      (tk-call '.canvas 'delete 'turtle)
      ; Create the body
      (draw-circle x y turtle-size "turtle")
      ; Create the head
      (draw-circle (+ x (* 0.75 turtle-size (cos theta)))
                   (+ y (* 0.75 turtle-size (sin theta)))
                   (/ turtle-size 2)
                   "turtle")
      ; Create the front legs
      (draw-circle (+ x (* 0.625 turtle-size (cos (+ theta 0.785))))
                   (+ y (* 0.625 turtle-size (sin (+ theta 0.785))))
                   (/ turtle-size 4)
                   "turtle")
      (draw-circle (+ x (* 0.625 turtle-size (cos (- theta 0.785))))
                   (+ y (* 0.625 turtle-size (sin (- theta 0.785))))
                   (/ turtle-size 4)
                   "turtle")
      ; Create the rear legs
      (draw-circle (+ x (* 0.625 turtle-size (cos (+ theta 2.356))))
                   (+ y (* 0.625 turtle-size (sin (+ theta 2.356))))
                   (/ turtle-size 4)
                   "turtle")
      (draw-circle (+ x (* 0.625 turtle-size (cos (- theta 2.356))))
                   (+ y (* 0.625 turtle-size (sin (- theta 2.356))))
                   (/ turtle-size 4)
                   "turtle"))

    (tk-init '())
    (tk-wm 'title "." "turtle")
    (tk-grid (tk-canvas '.canvas '-width 600 '-height 600 '-bg 'black))))

