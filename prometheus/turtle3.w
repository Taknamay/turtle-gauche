define-library : turtle prometheus turtle3
;; This is (turtle turtle3) rewritten for Wisp and Prometheus,
;; as an exercise in both.
  import
    scheme base
    scheme load
    scheme inexact
    turtle canvas
    turtle vector
    prometheus user
  export turtle
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

      : -set-orient! self resend H L U
        self '-set-H! H
        self '-set-L! L
        self '-set-U! U

      : get-orient self resend
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

    ;; A procedure to generate a new turtle without exposing the parent
    define : turtle
      <turtle3> 'clone
