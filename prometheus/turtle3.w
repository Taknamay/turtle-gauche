define-library : turtle prometheus turtle3
;; This is (turtle turtle3) rewritten for Wisp and Prometheus,
;; as an exercise in both.
  import
    scheme base
    scheme load
    scheme inexact
    turtle canvas
    turtle vector
    turtle syntax
    prometheus user
  export turtle repeat
  begin
    define-object <turtle3> : *the-root-object*

      pos set-pos! #(0.0 0.0 0.0)
      ;; H L U describe how the turtle is facing
      ;; Read the turtle geometry book for reference
      -H -set-H! #(1.0 0.0 0.0)
      -L -set-L! #(0.0 1.0 0.0)
      -U -set-U! #(0.0 0.0 1.0)
      down? -set-pen-state! #t
      shown? -set-shown! #f

      : show! self resend
        self '-set-shown! #t

      : hide! self resend
        self '-set-shown! #f

      : up! self resend
        self '-set-pen-state! #f

      : down! self resend
        self '-set-pen-state! #t

      : set-orient! self resend H L U
        self '-set-H! H
        self '-set-L! L
        self '-set-U! U

      : orient self resend
        list
          self '-H
          self '-L
          self '-U

      : forward! self resend dist
        define start-pos : self 'pos
        define new-pos
          add-vectors
            . start-pos
            scale-vector
              self '-H
              . dist
        draw-turtle-line
          vector-ref start-pos 0
          vector-ref start-pos 1
          vector-ref new-pos 0
          vector-ref new-pos 1
          self 'down?
          self 'shown?
        self 'set-pos! new-pos

      : yaw! self resend theta
        self 'set-orient!
          rotate : self '-H
                   self '-L
                   . theta
          rotate : self '-L
                   negate-vector : self '-H
                   . theta
          self '-U

      : pitch! self resend theta
        self 'set-orient!
          rotate : self '-H
                   self '-U
                   . theta
          self '-L
          rotate : self '-U
                   negate-vector : self '-H
                   . theta

      : roll! self resend theta
        self 'set-orient!
          self '-H
          rotate : self '-L
                   self '-U
                   . theta
          rotate : self '-U
                   negate-vector : self '-L
                   . theta

      : nutate! self resend
        self 'pitch! -47.855
        self 'yaw! -11.438
        self 'roll! 43.320

    ;; A procedure to generate a new turtle without exposing the parent
    define : turtle
      <turtle3> 'clone
