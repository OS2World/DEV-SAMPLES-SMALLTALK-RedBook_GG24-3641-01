
ViewManager subclass: #ToDoListView
  instanceVariableNames: 
    'sortKey toDoList toDoPriorityList preListFont deadline description type priority completed listLineHeight todoListBox prevSelection errorField statusField '
  classVariableNames: ''
  poolDictionaries: 
    'CharacterConstants PMConstants '  !


!ToDoListView class methods !

startUp

	^super new open! !



!ToDoListView methods !
   
aCheck: aCheckBox

        "aCheckBox has been clicked"

	^nil!
 
aChoice: aLBox
"12/12 Update "
	"A new selection has been made in the listbox.
	Check if the contents of the edit fields have been changed.
	If they have, update the todo list."

  | tmpToDoItem |

   self clrStatusFields.

  (toDoList size > 0) ifTrue:[
             tmpToDoItem :=(toDoList at: (todoListBox selection)).
             deadline contents:  (tmpToDoItem deadline) .
             description contents:  (tmpToDoItem description) .
             type selection:  ( tmpToDoItem type) .
            " priority selection:  ( tmpToDoItem priority) .   "
            priority selection:  ( toDoPriorityList keyAtValue: (tmpToDoItem priority)) .  
            completed selection:  ( tmpToDoItem completed) .
             ].!

addButtons
   "Add some Button controls in ToDoTopPane "
   "12/9 update ochiai , changeButton added!!"
   
    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #saveButton: ;
        contents: 'Save';
	             framingBlock: [:box|
		           box origin + ( 4*listLineHeight @ ( listLineHeight) )
      			corner: 7@
                    2*listLineHeight ]).

    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #newButton: ;
        contents: 'New item';
	             framingBlock: [:box|
  	        box origin + ( 8*listLineHeight @ ( listLineHeight) )
      			corner: 12@
                    2*listLineHeight ]).

    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #changeButton: ;
        contents: 'Change item';
	             framingBlock: [:box|
  	        box origin + (13*listLineHeight @ ( listLineHeight) )
      			corner: 18@
                    2*listLineHeight ]).
    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #refreshButton: ;
        contents: 'Refresh';
	             framingBlock: [:box|
  	        box origin + (19*listLineHeight @ ( listLineHeight) )
      			corner: 22@
                    2*listLineHeight ]).!
  
addFields

	((Display extent) = (640@480)) ifTrue: [ self addVgaFields ]
		ifFalse: [ self addXgaFields  ].!
 
addHeaders 
    "Add header on the ToDoTopPane "
    | hPane |
    self 
        addSubpane: 
             ( ( hPane := GroupPane new )
	            owner: self;
				style: GroupPane noBorderFrameStyle;
    	        framingBlock: [:box|
        	        box origin x @ (
					box height - listLineHeight) corner:
               		box width  @  box height]).
    hPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Deadline';
	            owner: self;
		        framingRatio: ((4/100) @ (1/10) 
				extent: (10/100) @ (8/10))).
    hPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Type';
	            owner: self;
		        framingRatio: ((15/100) @ (1/10) 
				extent: (15/100) @ (8/10))).
    hPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Description';
	            owner: self;
		        framingRatio: ((35/100) @ (1/10) 
				extent: (20/100) @ (8/10))).

    hPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Priority';
	            owner: self;
		        framingRatio: ((80/100) @ (1/10) 
				extent: (8/100) @ (8/10))).

    hPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Done';
	            owner: self;
		        framingRatio: ((89/100) @ (1/10) 
				extent: (11/100) @ (8/10))).!

addItem
   "Get current Item in the field and put the ListBox "

    toDoList add: self currentItem.
	todoListBox contents: toDoList.
	todoListBox selection: (toDoList size).
	self aChoice: nil.

	statusField backColor: ClrYellow;
		contents: 'New item added!!'!
 
addListBox

    "Private- Adding a simple ListBox ."

	self addSubpane:
			((todoListBox := ListBox new)
                 owner: self;
                 itemHeight: listLineHeight;
                 when: #getContents perform: #toDo:;
                 when: #select perform: #aChoice:;
				 when: #getMenu perform: #menu:;

                framingBlock: [:box | (box leftTop down:(  listLineHeight  ) )
                       extentFromLeftTop:(box width @ (box height // 2))]).!
   
addStatus
   "Add  two status line on the ToDoTopPane"

    self addSubpane: (statusField := StaticText new
        owner: self;
        contents: 'Status messages displayed here';
	             framingBlock: [:box|
			box origin + (0 @ 0)
			corner: ((box width) // 2)@20 ]).

    self addSubpane: (errorField := StaticText new
        owner: self;
        contents: 'Error messages displayed here';
	             framingBlock: [:box| 
				box origin +  (((5*(box width)) // 9) @ 0)
			corner: (box width)@20 ]).!
   
addTemplateItem
        "Put a template ToDoItem on the Field"
    | tmpToDoItem |

    tmpToDoItem :=ToDoItem new  template.
    deadline contents:  (tmpToDoItem deadline) .
    description contents:  (tmpToDoItem description) .
    type selection:  ( tmpToDoItem type) .
    priority selection:  ( tmpToDoItem priority) .
    completed selection:  ( tmpToDoItem completed) .!
  
addVgaFields

| fld fieldList  |

	fieldList := OrderedCollection new.

	self addSubpane:
		((deadline :=  EntryField new)
			owner: self;
			framingRatio: ((3/100) @ (30/100) 
				extentFromLeftTop: (11/100) @ (7/100))).

	fieldList add: deadline.

  self
	 addSubpane: 
			( (type := SpinButton leftJustifiedText )
                 owner: self;
                 contents: #( 'Personal' 'Meeting'  'Phone'  'Report' );
                  framingRatio: ((15/100) @ (29/100) 
				extentFromLeftTop: (19/100) @ (7/100))).

	fieldList add: type.

	self addSubpane:
        ((description :=  EntryField new)
			owner: self;          
			framingRatio: ((35/100) @ (30/100) 
				extentFromLeftTop: (45/100) @ (7/100))).

	fieldList add: description.

 self addSubpane:
        ((priority := SpinButton leftJustifiedText )
			owner: self;
			contents: #('High' 'Med' 'Low');		
			framingRatio: ((81/100) @ (29/100)  
					extentFromLeftTop: (10/100) @ (7/100) )).

	fieldList add: priority.

	self
         addSubpane: 
			((completed :=  CheckBox new)
                 owner: self;
                 contents: '';
                 when: #clicked perform: #aCheck: ;
					framingRatio: ((93/100) @ (30/100)  
					extentFromLeftTop: (8/100) @ (7/100) )).
	fieldList  add: completed.!
 
addXgaFields
      "Add a field containg some entryfields, spinbuttons,and checklist"
| fld fieldList  highPri medPri  lowPri  tmpCol|

	fieldList := OrderedCollection new.

	self addSubpane:
		((deadline :=  EntryField new)
			owner: self;
			framingRatio: ((3/100) @ (30/100) 
				extentFromLeftTop: (11/100) @ (7/100))).

	fieldList add: deadline.

  self
	 addSubpane: 
			( (type := SpinButton leftJustifiedText )
                 owner: self;
                 contents: #( 'Personal' 'Meeting'  'Phone'  'Report' );
                  framingRatio: ((15/100) @ (29/100) 
				extentFromLeftTop: (19/100) @ (7/100))).

	fieldList add: type.

	self addSubpane:
        ((description :=  EntryField new)
			owner: self;          
			framingRatio: ((35/100) @ (30/100) 
				extentFromLeftTop: (45/100) @ (7/100))).

	fieldList add: description.

  self addSubpane:
        ((priority := SpinButton leftJustifiedText )
			owner: self;
			 contents: #('High' 'Med' 'Low'); 	
            framingRatio: ((81/100) @ (29/100)  
					extentFromLeftTop: (10/100) @ (7/100) )).

	fieldList add: priority.

	self
         addSubpane: 
			((completed :=  CheckBox new)
                 owner: self;
                 contents: '';
                 when: #clicked perform: #aCheck: ;
					framingRatio: ((93/100) @ (30/100)  
					extentFromLeftTop: (8/100) @ (7/100) )).
	fieldList  add: completed.!

changeButton: aButton
   "call changeItem method "
	self changeItem.!
 
changeItem
  "Update the ToDoItem"
  (toDoList size > 0) ifTrue:[
       toDoList updateItem:(self currentItem) at:( todoListBox selection ).
       todoListBox contents: toDoList.
       todoListBox selection: 1.
     	self aChoice: nil.

     	statusField backColor: ClrYellow;
		contents: 'The item changed!!' 
      ].!
   
clearAll
   "Save ToDoList and clear the display of the listbox "

    toDoList writeList.

    self clearAllItems. "clear ToDo list "
	todoListBox contents: nil.
	"self aChoice: nil."

    self addTemplateItem.

	statusField backColor: ClrYellow;
		contents: 'All Item cleared'!
 
clearAllItems
        "Clear all ToDo list"

    toDoList removeAll. 
   ( toDoList size > 0) ifTrue:[
      self clearAllItems. "** retry **"
     ].!
   
close: aWin 
     "before closing the window, save the ToDoList" 

     toDoList writeList. 	
     ListFont := preListFont.
	^super close!
 
clrStatusFields
   "Clear the status field "

	statusField backColor: ClrWhite;
		contents: ''.
	errorField backColor: ClrWhite;
		contents: ''.!
 
currentItem
"12/12 Update "
  "Get the current item from the field"
	| item |

	item := ToDoItem new.

	item deadline: deadline contents.
	item description: description contents.
	item type: type selection.
    item priority: (toDoPriorityList at: (priority selection )).
	item completed: completed getValue.
	^item!

dummy

	^nil!
 
initWindowSize
        "Private - Answer the initial size of the receiver."
	(Display extent = (640@480)) ifTrue: [
	^(Display width * 19 //20) @ (Display height * 4 // 7)]
	ifFalse: [
		^(Display width * 15 //20) @ (Display height * 4 // 7)]!

menu: aPane

    "Private - Set the To Do pane menu. Sets the option menu
     up.  Notice this method gets called whenever there is a 
	getMenu event and that this menu pops up when mouse 
	button 2 is pressed in the listPane."

    todoListBox  setMenu: (( self menuWindow menuTitled: '~Edit' ))!
   
newButton: aButton

	self addItem.!
   
newItem: anItem
   "            "

	deadline contents: anItem deadline.
	description contents: anItem description.
	type selection: anItem type.
	priority selection: anItem priority.
	completed selection: anItem completed.!
  
open
"12/12 update"
    "Open the ToDoList application window"


	self setItemHeight.
    self setListFont.
    self
        owner: self;
        label: 'To-Do List'.
	self when: #close perform: #close: .

	self addHeaders. 
    self addListBox.     

    toDoList:= ToDoList new.    
    toDoList readList.  

    toDoPriorityList := ToDoPriorityList new class init.
    self addFields.  
	self addButtons.
	self addStatus.

	HelpManager for: (self mainView) title: 'Help' file: 'c:\stvpm13\ex2\todo.hlp'  dialogs:#() aboutDlgClass: (ToDoAboutDialogBox initialize). 

    self openWindow.
	(toDoList size > 0 ) ifTrue:[
            prevSelection := 1.
	        self sortBy:  sortKey.
             ] 
       ifFalse:[
             self addTemplateItem.
              ].!
  
openToDoList
        "called by TopPane menu"

    toDoList readList.

    (toDoList size > 0 )  ifTrue: [
                  self sortBy: sortKey . ].!
   
printAllItems
		"Prints every item in the list."

		toDoList do: [ :item | item printYourself].!
 
printItem

	(toDoList at: (todoListBox selection)) printYourself.

	statusField backColor: ClrRed;
		contents: 'Item printed'!
 
printLines: lines
        "Private - Print the text lines."
    | aHandle |
    CursorManager execute change.
    aHandle := FileHandle openDevice: 'LPT1'.
    lines do: [ :line |
        aHandle deviceWrite: line.
        aHandle deviceWrite: (String with: Lf with: Cr)].
    aHandle close.
    CursorManager normal change!
   
refreshButton: aButton
  "refresh the display of the listbox"

    (toDoList size > 0 )  ifTrue: [
                  self sortBy: sortKey . ].!
 
removeItem
   "Remove the item from toDoList"

	toDoList remove: (toDoList at: (todoListBox selection)).
    self newItem: (toDoList at: 1).
	todoListBox contents: toDoList.
	prevSelection := 1.
	todoListBox selection: 1.
	self aChoice: nil.

	statusField backColor: ClrYellow;
		contents: 'Item deleted'!

saveButton: aButton
  "Save the ToDoList"

    toDoList writeList. 
	statusField backColor: ClrYellow;
		contents: 'List saved!!'!
 
setItemHeight
    "Set the proper height of the  listbox line"

    | vga bga|
    vga := 640 @ 480.
    bga := 1024 @ 768.

    "Check the size of the display. If it is an 8514 with adaptor,
	  or an XGA display,
     use a higher height. (Display is a special class pertinent to the
     monitor in use)."

    (Display extent = bga)
      ifTrue: [
             listLineHeight := 30 ]
      ifFalse: [ listLineHeight := 25   ] .!
 
setListFont
    "Set listFont    "

    | vga bga|
    vga := 640 @ 480.
    bga := 1024 @ 768.

    preListFont:= ListFont.

    (Display extent = bga)
      ifTrue: [
                  ListFont :=Font face:'Courier'
                                    size: 12 @ 20
                                     fixedWidth: true
                                     attributes: FattrTypeFixed.   ]
      ifFalse: [ 
                  ListFont :=Font face:'Courier'
                                    size:   9 @ 16
                                     fixedWidth: true
                                     attributes: FattrTypeFixed.   ]!
 
sortBy: aKey
  "Sort the ToDOList using the sort key "

 	(aKey isNil) ifTrue: [ 
                     sortKey:='priority' .
                     toDoList sortList:  'priority' .
                     ] 
		ifFalse: [    
                     sortKey:=aKey .
                      toDoList sortList: aKey. 
                      ].

    toDoList sortList. 

	todoListBox contents: toDoList.
	todoListBox selection: 1.

	statusField backColor: ClrYellow;
		contents: 'List updated, sortkey: ' , sortKey.!
 
toDo: aPane
  "Get the contents of the ToDoList to the listbox"
    | returnList    |

    returnList := OrderedCollection new.

    ( (toDoList size) > 0)
        ifTrue: [
                toDoList  do: [ :aToDoItem | returnList add: (aToDoItem getItemText )
                              ]
                ].    

"Return the collection of strings for display."

aPane contents: returnList!
  
topPaneClass

	"Private - set the default toppane class "

    ^ToDoTopPane! !
