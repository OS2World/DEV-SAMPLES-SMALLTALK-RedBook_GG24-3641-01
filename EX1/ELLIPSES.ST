
"Create a window and a graphpane in it"

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






