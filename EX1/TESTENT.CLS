
ViewManager subclass: #TestEntryFieldView
  instanceVariableNames: 
    'myEntryField '
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants ' !


!TestEntryFieldView class methods ! !



!TestEntryFieldView methods !
   
close:topPane

   " Private-Close TopPane. Before do it, get the contents
      from the EntryField and display it on the TranscriptWindow.
      And clear the contents of the EntryField."

   Transcript nextPutAll:'myEntryField contents was ',
                                       (myEntryField contents)  ;
                                       cr. 
   myEntryField contents: ''.
   self close!
   
myEntryField: aPane
        "Private-Display a text on the entryfield"
 
    aPane contents: 'This is an entryfield'.!
   
open 
		"Private - Open the  window with an entryfield "
	| lineHeight charWidth charHeight |

    charHeight := SysFontHeight.
    charWidth := SysFontWidth. 
    lineHeight := charHeight + 5. 

    self
        owner: self;
        label: 'A TEST';
        yourself.
	 self when: #close perform: #close: . 

	self addSubpane:
        (myEntryField:= EntryField new
			"contents: 'This is an entryfield';"
			when: #getContents perform: #myEntryField:;
			framingBlock: [:box |
				(box leftBottom rightAndUp: (charWidth * 2) @ (lineHeight * 2))
					extent: (charWidth * 40 ) @ (charHeight ) ]).

	self openWindow.! !
