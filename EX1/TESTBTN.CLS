
ViewManager subclass: #TestButtonView
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '    !


!TestButtonView class methods ! !



!TestButtonView methods !
   
cancel: aPane
        "Private-Inform the event that Cancel button is pushed 
          via TranscriptWindow"
   Transcript nextPutAll:'Cancel button was pushed ';
                     cr.!
   
ok: aPane
        "Private-Inform the event that OK button is pushed 
          via TranscriptWindow"
   Transcript nextPutAll:'OK button was pushed ';
                     cr.!
   
open
		"Private - Open the window with 2 push buttons"
	| lineHeight charWidth charHeight |

    charHeight := SysFontHeight.
    charWidth := SysFontWidth. 
    lineHeight := charHeight + 5. 

    self
        owner: self;
        label: 'A TEST';
        yourself.
 
	    self addSubpane:
        (Button new
            contents: 'OK';
            defaultPushButton;
            when: #clicked perform: #ok:;
            framingBlock: [:box |
                (box leftBottom rightAndUp: (charWidth * 15) @ (lineHeight * 2))
                    extent: (charWidth * 9) @ lineHeight ] ).

    self addSubpane:
        (Button new
            contents: 'Cancel';
			owner: self;
            when: #clicked perform: #cancel:;
            framingBlock: [:box |
                (box leftBottom rightAndUp: (charWidth * 30) @ (lineHeight * 2))
                    extent: (charWidth * 9) @ lineHeight ] ).

	self openWindow.! !
