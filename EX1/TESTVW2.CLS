
ViewManager subclass: #TestView
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '  !


!TestView class methods ! !



!TestView methods !
   
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
          selection in made in listpane"

         MessageBox
                    titled: 'Line selected'
                    withText: (aListBox lineAt: aListBox selection)
                    style: MbOk | MbIconexclamation.!
 
myTextList: aListBox

      | myCollection |

      myCollection := OrderedCollection new.
      myCollection add: 'Row 1';
                   add: 'Row 2';
                   add: 'Row 3'.
      aListBox contents: myCollection.!
   
open
        "Open an window containing a ListBox"

 
    self
        owner: self;
        label: 'A TEST';
        yourself.
 
    self addSubpane:
        (ListBox new
            owner: self;
            when: #getContents perform: #myTextList: ;
            when: #select perform: #mySelect:;
            framingBlock: [:box | box]).

     self openWindow.
     self menuWindow addMenu: self myMenu owner: self.! !
