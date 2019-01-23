
ViewManager subclass: #TestView
  instanceVariableNames: 
    'myOdCollection myEntryField myListBox '
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '  !


!TestView class methods ! !



!TestView methods !
   
cancel: aPane
        "Private-Clear the contents of the EntryField and reset it."
  
     myEntryField contents:  (myListBox lineAt: myListBox selection).!
 
close:topPane

   " Private-Close TopPane. Before do it, 
      And clear the contents of the EntryField."

   myEntryField contents: ''.
   self close!
  
myEntryField: aPane
        "Private-Display a text on the entryfield,initially."
 
    aPane contents: 'This is an entryfield'.!

myMenu
        "Private - Answer the File menu."
    ^Menu new
        appendItem: '~My Choice' selector: #myMenuMethod ;
      title: '~My Menu'!
  
myMenuMethod
         "This method is activated when 'MyChoice'
          is selected in the pulldown 'My Menu'"

         MessageBox
                    titled: 'Gotcha!!!!!!'
                    withText: 'My menu WORKS !!!!!!'
                    style: MbOk | MbIconexclamation.!
  
mySelect: aListBox


         "This method is activated when a new
          selection in made in listbox"

        "Private-Display a text on the entryfield"
 
    myEntryField contents:  (aListBox lineAt: aListBox selection).!

myTextList: aListBox
      "Private- Display the contents of myOdCollection on the ListBox"

      aListBox contents: myOdCollection.!
   
newItem: aPane
        "Private-Add a new item at myOdCollection."
 
    myOdCollection add:(myEntryField contents).
    myListBox selection:1.!

open
        "Open an window containing a ListBox and an EntryField,
          two PushButtons."

   | lineHeight charWidth charHeight |

    charHeight := SysFontHeight.
    charWidth := SysFontWidth. 
    lineHeight := charHeight + 5. 
    
   "Create an instance of TestOdCollection Class and initialize it."
    myOdCollection:= TestOdCollection new.
    myOdCollection readList.

    self
        owner: self;
        label: 'A TEST';
        yourself.
	 self when: #close perform: #close: . 
 
    self addSubpane:
        (myListBox:=ListBox new
            owner: self;
            when: #getContents perform: #myTextList: ;
            when: #select perform: #mySelect:;
            framingBlock: [:box | box leftTop
                       extentFromLeftTop:(box width @ (box height // 2))]).
 
	self addSubpane:
        (myEntryField:= EntryField new
		   when: #getContents perform: #myEntryField:; 
			framingBlock: [:box |
				(box leftBottom rightAndUp: (charWidth * 2) @ (lineHeight * 4))
					extentFromLeftTop: (charWidth * 40 ) @ (charHeight ) ]).
 
	    self addSubpane:
        (Button new
            contents: 'NewItem';
            defaultPushButton;
            when: #clicked perform: #newItem:;
            framingBlock: [:box |
                (box leftBottom rightAndUp: (charWidth * 15) @ (lineHeight * 2))
                    extentFromLeftTop: (charWidth * 9) @ lineHeight ] ).

    self addSubpane:
        (Button new
            contents: 'Cancel';
			owner: self;
            when: #clicked perform: #cancel:;
            framingBlock: [:box |
                (box leftBottom rightAndUp: (charWidth * 30) @ (lineHeight * 2))
                    extentFromLeftTop: (charWidth * 9) @ lineHeight ] ).


     self openWindow.
     self menuWindow addMenu: self myMenu owner: self.

     "Default selection of the item at the first place on the ListBox."
     myOdCollection size > 0
           ifTrue:[    myListBox selection:1.
                      ].! !
