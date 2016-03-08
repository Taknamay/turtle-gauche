(define-library (turtle syntax)
  (import (scheme base))
  (export repeat)
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
               (lp (+ i 1))))))))))
