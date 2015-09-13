(define-library (turtle turtle3)
  (import (scheme base)
          (scheme load)
          (scheme inexact)
          (turtle canvas)
          (turtle vector))
  (export turtle-init pen-up! pen-down! forward!
          yaw! pitch! roll! nutate! set-pos!
          get-pos set-orient! get-orient
          line-color bg-color line-width
          image-rotate show! hide! shown?
          draw-line repeat)
  (begin
    (define-syntax repeat
      (syntax-rules (forever)
        ((_ (forever) exps ...)
         (let lp ()
           exps ...
           (lp)))
        ((_ (i forever) exps ...)
         (let lp ((i 0))
           exps ...
           (lp (+ i 1))))
        ((_ (n) exps ...)
         (let ((stop n))
           (let lp ((i 0))
             (when (< i stop)
               exps ...
               (lp (+ i 1))))))
        ((_ (i n) exps ...)
         (let ((stop n))
           (let lp ((i 0))
             (when (< i stop)
               exps ...
               (lp (+ i 1))))))))

    (define (image-rotate theta1 theta2)
      (if canvas-image-rotate
          (canvas-image-rotate theta1 theta2)
          #f))

    (define (line-color color)
      (if canvas-line-color
          (canvas-line-color color)
          (error "line-color" "Not supported by the implementation")))

    (define (bg-color color)
      (if canvas-bg-color
          (canvas-bg-color color)
          (error "bg-color" "Not supported by the implementation")))

    (define (line-width width)
      (if canvas-line-width
          (canvas-line-width width)
          (error "line-width" "Not supported by the implementation")))

    (define-record-type type-turtle3
      (turtle pos H L U pen shown)
      turtle?
      (pos get-pos set-pos!)
      (H get-H set-H!)
      (L get-L set-L!)
      (U get-U set-U!)
      (pen pen-down? set-pen-state!)
      (shown shown? set-shown!))

    (define (show! t)
      (set-shown! t #t))

    (define (hide! t)
      (set-shown! t #f))

    (define (turtle-init)
      (turtle #(0.0 0.0 0.0) #(1.0 0.0 0.0) #(0.0 1.0 0.0) #(0.0 0.0 1.0) #t #f))
    
    (define (set-orient! turt H L U)
      (set-H! turt H)
      (set-L! turt L)
      (set-U! turt U))

    (define (get-orient turt)
      (list (get-H turt)
            (get-L turt)
            (get-U turt)))
    
    (define (pen-up! turt)
      (set-pen-state! turt #f))
    
    (define (pen-down! turt)
      (set-pen-state! turt #t))
    
    (define (forward! turt dist)
      (define start-pos (get-pos turt))
      (define new-pos (add-vectors start-pos
                                   (scale-vector (get-H turt) dist)))
      (draw-turtle-line (vector-ref start-pos 0)
                        (vector-ref start-pos 1)
                        (vector-ref new-pos 0)
                        (vector-ref new-pos 1)
                        (pen-down? turt)
                        (shown? turt))
      (set-pos! turt new-pos))
    
    (define (yaw! turt theta)
      (set-orient! turt
                   (rotate (get-H turt)
                           (get-L turt)
                           theta)
                   (rotate (get-L turt)
                           (negate-vector (get-H turt))
                           theta)
                   (get-U turt)))

    (define (pitch! turt theta)
      (set-orient! turt
                   (rotate (get-H turt)
                           (get-U turt)
                           theta)
                   (get-L turt)
                   (rotate (get-U turt)
                           (negate-vector (get-H turt))
                           theta)))

    (define (roll! turt theta)
      (set-orient! turt
                   (get-H turt)
                   (rotate (get-L turt)
                           (get-U turt)
                           theta)
                   (rotate (get-U turt)
                           (negate-vector (get-L turt))
                           theta)))

    (define (nutate! turt)
      (pitch! turt -47.85)
      (yaw! turt -11.43)
      (roll! turt 43.32))))
