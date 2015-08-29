(define-library (turtle turtle3)
  (import (scheme base)
          (scheme load)
          (turtle canvas)
          (turtle vector))
  (export turtle-init pen-up! pen-down! forward!
          yaw!)
  (begin
    (define-record-type type-turtle3
      (turtle pos H L U pen)
      turtle?
      (pos get-pos set-pos!)
      (H get-H set-H!)
      (L get-L set-L!)
      (U get-U set-U!)
      (pen pen-down? set-pen-state!))
    
    (define (turtle-init)
      (turtle #(0 0 0) #(1 0 0) #(0 1 0) #(0 0 1) #t))
    
    (define (set-orient! turt H L U)
      (set-H! turt H)
      (set-L! turt L)
      (set-U! turt U))
    
    (define (pen-up! turt)
      (set-pen-state! turt #f))
    
    (define (pen-down! turt)
      (set-pen-state! turt #t))
    
    (define (forward! turt dist)
      (define start-pos (get-pos turt))
      (define new-pos (add-vectors start-pos
                                   (scale-vector (get-H turt) dist)))
      (if (pen-down? turt)
          (draw-line (vector-ref start-pos 0)
                     (vector-ref start-pos 1)
                     (vector-ref new-pos 0)
                     (vector-ref new-pos 1)))
      (set-pos! turt new-pos))
    
    (define (yaw! turt theta)
      (set-orient! turt
                   (rotate (get-H turt)
                           (get-L turt)
                           theta)
                   (rotate (get-L turt)
                           (negate-vector (get-H turt))
                           theta)
                   (get-U turt)))))
