
      "Panes - Solutions to exercises

      "Create a window and a graphpane in it. Draw a few lines:"

        | test myPen x y|
        test := GraphPane openWindow: 'My'.
        myPen := test pen.
        myPen goto: 100 @ 100.
        myPen goto: 200 @ 100.
        myPen goto: 200 @ 200.
        myPen goto: 100 @ 200.
        myPen goto: 100 @ 100.

      "The same result can be achieved by evaluating the 
      following ( Do It ):"

        | test myPen x y|
        test := GraphPane openWindow: 'My'.
        myPen := test pen.
        myPen goto: 100 @ 100.
        myPen box: 200 @ 200.

      "Pen can also be 'lifted up' like this:"

        | test myPen x y|
        test := GraphPane openWindow: 'My'.
        myPen := test pen.
        myPen up.
        myPen goto: 150 @ 150.
        myPen down.
        myPen circle: 100.

      "Since Pen is a subclass of TextTool, we can also write 
      some text like this:"

        | test myPen x y|
        test := GraphPane openWindow: 'My'.
        myPen := test pen.
        myPen up.
        myPen goto: 150 @ 150.
        myPen down.
        myPen circle: 100.
        myPen displayText: 'My circle!'.

      "Finally, let's draw a series of ellipses:"

        | test myPen x y|
        test := GraphPane openWindow: 'My'.
        myPen := test pen.
        myPen up.
        myPen goto: 160 @ 160.
        y:= 150.
        x := 50.
        myPen down.
        60 timesRepeat: [
                myPen ellipse: x minor:y.
                x := x + 2.
                y := y - 2.]
        

      "***** END OF EXERCISE *****"
      
      
      
      
      
