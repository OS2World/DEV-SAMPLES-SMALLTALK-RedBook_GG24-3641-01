
TopPane subclass: #CUATopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'CharacterConstants PMConstants ' !
CUATopPane subclass: #SimpleTopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants ' !
CUATopPane subclass: #ToDoTopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '   !
ListBox subclass: #ListBoxODraw
  instanceVariableNames: 
    'bMap tickBmap startPoint '
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '  !
Object subclass: #ToDoItem
  instanceVariableNames: 
    'type description priority deadline completed '
  classVariableNames: 
    'Defaults '
  poolDictionaries: 
    'CharacterConstants ' !
Dictionary subclass: #ToDoPriorityList
  instanceVariableNames: ''
  classVariableNames: 
    'Priorities '
  poolDictionaries: ''   !
OrderedCollection subclass: #ToDoList
  instanceVariableNames: 
    'sortKey sortOrder '
  classVariableNames: ''
  poolDictionaries: '' !
Object subclass: #ToDoSettings
  instanceVariableNames: 
    'sortKey sortOrder country codePage includeCriterion defaultItem '
  classVariableNames: ''
  poolDictionaries: ''  !
ViewManager subclass: #ToDoRowDisplay
  instanceVariableNames: 
    'fieldList deadline priority description type completed ctlWindow '
  classVariableNames: ''
  poolDictionaries: 
    'CharacterConstants PMConstants ' !
ViewManager subclass: #ToDoSettingsView
  instanceVariableNames: 
    'notebook nbControls sortPage defaultsPage countryPage includePage topPage ctlView ctlSettings '
  classVariableNames: ''
  poolDictionaries: 
    'PMNotebookConstants PMConstants CharacterConstants '  !
ViewManager subclass: #ToDoListView
  instanceVariableNames: 
    'settings itemList listLineHeight todoListBox rowDisp prevSelection statusField undoItem '
  classVariableNames: ''
  poolDictionaries: 
    'CharacterConstants PMConstants '    !
DragTransfer subclass: #DragString
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMDragConstants PMConstants '  !


!CUATopPane class methods !
  
fileMenu
        "Private - Answer the File menu."
    ^Menu new
        appendItem: '~Open as ToDo List' selector: #openAsToDoList;
        appendItem: 'Open as ~Settings' selector: #openAsSettings;
        appendSeparator ;
        appendItem: '~Save	' selector: #accept  ;
        appendSeparator ;
        appendItem: '~Print	' selector: #print  ;
		appendItem: 'Print~All	' selector: #printAll  ;
        title: '~ThingsToDo'!
   
supportedEvents
        "Answer the Set of events that SubPanes can notify
         their owners about."
    ^Set new
        add: #close;
        add: #opened;
        add: #timer;
        add: #menuBuilt;
        add: #validated;
        add: #activate;
        add: #help;
		add: #getMenu;
        add: #getPopupMenu;
        yourself! !



!SimpleTopPane class methods ! !



!ToDoTopPane class methods ! !



!ListBoxODraw class methods !

ownerDraw
        "Answer an instance of the receiver where
         the owner will be notified to draw each item."
    | lb startPoint |
    lb := self new. 
    lb	style: lb ownerDrawFixed.
	lb initStartPoint.
    ^lb.! !



!ToDoItem class methods !
 
defaults
	"set the default item settings as an array"

	^Defaults!
   
defaults: anArray
	"set the default item settings as an array"

	Defaults := anArray.!
   
new
	
	^super new!

newItem
	"create and initalize a new item"
	^super new initialize.!
   
typesAvailable

	"Returns a collection of the available values for Type"

^#('Phone' 'Meeting' 'Report' 'Personal').! !



!ToDoPriorityList class methods !

new

	^super new initialize.!
 
priorities
	"return the priority descriptions as an array"

	^Priorities!

priorities: anArray
	"set the priority descriptions to the contents of the array"

	Priorities := anArray.! !



!ToDoList class methods ! !



!ToDoSettings class methods !

new

^super new initialise! !



!ToDoRowDisplay class methods ! !



!ToDoSettingsView class methods ! !



!ToDoListView class methods !

startUp

	^super new open! !



!DragString class methods ! !



!CUATopPane methods !

buildMenuBar
        "Private - Create the menus that make up the menu bar."
    | textPane eachMenu |
    menuWindow addMenu: self fileMenu owner: self.
    (self class canUnderstand: #saveAs) ifFalse: [
        (eachMenu := menuWindow menuTitled: '~File') notNil
            ifTrue: [eachMenu disableItem: #saveAs]].
    textPane := self searchForDefaultTextPane.
    textPane notNil ifTrue: [
        menuWindow addMenu: (textPane class editMenu allOwners: textPane).
        menuWindow addMenu: (textPane class smalltalkMenu allOwners: textPane).
        ].
    children do: [ :subpane |
        eachMenu := subpane menu.
        eachMenu notNil ifTrue: [
            menuWindow addMenu: eachMenu.
            ]].
    menuWindow systemMenu
        insertItem: '~Zoom Text	Alt+Z'
        selector: #zoom
        accelKey: $z
        accelBits: AfChar | AfAlt
        after: 5.
    menuWindow systemMenu
        insertItem: 'Fonts...'
        selector: #setFonts
        accelKey: nil
        accelBits: nil
        after: 6.

	menuWindow addMenu: self editMenu.
	menuWindow addMenu: self viewMenu.

    self helpManager notNil
        ifTrue: [self helpManager buildMenuBar].!
   
controlKeyInput: aCharacter
        "Private - A control key was pressed by the user,
         e.g. Backspace, Enter, Tab.  aCharacter contains
         the ascii code for the key."

	(aCharacter = Tab) ifTrue: [
		owner tabToNextField ].
	^super controlKeyInput: aCharacter!
  
openWindow: aRect
        "Open the receiver on a desired position and size

		Author: Jouko Ruuskanen
		16.10.1991 "

    ^self openIn: aRect.!
  
virtualKeyInput: anInteger
        "Private - The user pressed a virtual (i.e. non-alphanumeric) key.
         anInteger is a VkConstant from the PMConstants pool
         dictionary."

	(anInteger = 7) ifTrue: [ owner tabToPrevField ].
	^super virtualKeyInput: anInteger! !



!SimpleTopPane methods !

buildMenuBar

	^nil!
  
defaultFrameStyle
        "Private - Answer the default PM frame style for the receiver."
    ^FcfIcon!
   
virtualKeyInput: anInteger
        "Private - The user pressed a virtual (i.e. non-alphanumeric) key.
         anInteger is a VkConstant from the PMConstants pool
         dictionary."

	(anInteger = 22) ifTrue: [ owner rowUp ].
	(anInteger = 24) ifTrue: [ owner rowDown ].
	(anInteger = VkF10) ifTrue: [ owner jumpToBar ].
	^super virtualKeyInput: anInteger! !



!ToDoTopPane methods !
 
addItem

	^owner addItem!
 
buildMenuBar
        "Private - Build menu bar."
	| eachMenu empty|
	super buildMenuBar.
    (self owner respondsTo: #dummy) ifTrue: [
        (eachMenu := menuWindow menuTitled: '~View') notNil
            ifTrue: [eachMenu disableItem: #dummy]].
    (self owner respondsTo: #dummy) ifTrue: [
        (eachMenu := menuWindow menuTitled: '~Edit') notNil
            ifTrue: [eachMenu disableItem: #dummy]].

	PMWindowLibrary openClipbrd: handle.
	empty := PMWindowLibrary queryClipbrdData: handle fmt: 1.		"CF_TEXT = 1"
	(empty = 0)
		ifTrue:[ (self menuTitled:'Edit') disableItem:'~Paste' ].
	PMWindowLibrary closeClipbrd: handle.

    self event: #menuBuilt!
   
copyItem

	"Copy an item to the clipboard"

^owner copyItem: handle.!
   
create: parentWindow
    title: aTitleString
    frameStyle: aFrameStyle
    frameCreateFlags: fcfConstants
    clientStyle: aClientStyle
        "Private - Create a PM window whose parent is
         parentWindow with aTitleString as the title, and
         aFrameStyle as the pCtlData.
         The receiver's handle is set to the
         resulting client window.  The receiver's parent
         is set to the frame window."
    | fcfParam |
    (fcfConstants isInteger)
        ifTrue: [fcfParam := PMLong fromInteger: fcfConstants]
        ifFalse: [fcfParam := fcfConstants].
    parent := FrameWindow fromBytes: (PMWindowLibrary createStdWindow: parentWindow asParameter
        flStyle: aFrameStyle
        pCtlData: (fcfParam asParameter)
        pszClientClass: ('VPM' asParameter)
        pszTitle: (aTitleString asParameter)
        styleClient: aClientStyle
        hmod: (DynamicLinkLibrary open: 'RES')
        idResources: 262
        phwndClient: (self asParameter)).
    handle = NullHandle ifTrue: [^nil].
    parent parent: parentWindow.
    parent child: self.
    handle containedIn: self.!
 
cutItem

	"Copy an item to the clipboard and then delete it."

self copyItem.
self removeItem.!

dummy

	^nil!
 
editMenu
        "Private - Answer the SortBy... menu."

    ^Menu new

        appendItem: '~Undo' selector: #dummy;
        appendItem: '~Redo' selector: #dummy;
		appendSeparator;
        appendItem: '~Copy' selector: #copyItem;
        appendItem: 'C~ut' selector: #cutItem;
        appendItem: '~Paste' selector: #pasteItem;
		appendSeparator;
        appendItem: '~New item' selector: #addItem;
        appendItem: '~Delete item' selector: #removeItem ;
        title: '~Edit';
        owner: self.!

openAsSettings

	owner openAsSettings!

openAsToDoList

"	owner openDataBase "!
   
pasteItem

	"Paste an item from the clipboard into the list."

^owner pasteItem: handle!

print
		"Ask the owner (ToDoListView) to print the currently selected
		 item."

		owner printItem.!

printAll
		"Ask the owner (ToDoListView) to print all the items in the list."

		owner printAllItems.!
   
redo

^owner redo!

refresh

	owner refreshButton: nil!
   
removeItem

	^owner removeItem!
   
sortByDeadline
	
	owner sortBy: 'deadline'.!
  
sortByDescription
	
		owner sortBy: 'description'.!
   
sortByMenu
        "Private - Answer the SortBy... menu."
    ^Menu new

        appendItem: '~Type' selector: #sortByType;
        appendItem: '~Description' selector: #sortByDescription ;
        appendItem: 'Dead~line' selector: #sortByDeadline ;
        appendItem: '~Priority' selector: #sortByPriority ;
        checkItem: '~Priority' ;
        title: '~Sort By';
        owner: self.!
   
sortByPriority
	
		owner sortBy: 'priority'.!
 
sortByType
	
	owner sortBy: 'type'.!
  
undo

^owner undo!

viewMenu
        "Private - Answer the SortBy... menu."
    ^Menu new

        appendItem: '~List' selector: #dummy;
        appendItem: 'Se~ttings' selector: #openAsSettings ;
		appendSeparator;
        appendItem: '~Sort...' selector: #dummy;
        appendItem: '~Include...' selector: #dummy;
		appendSeparator;
        appendItem:  '~Refresh now' selector: #refresh;
        title: '~View';
        owner: self.!
   
wmSize: mp1 with: mp2

    self resize:
        (rectangle origin extent: (mp2 lowHalf @ mp2 highHalf)).
 	owner sized. "Inform the owner"
    ^nil! !



!ListBoxODraw methods !
  
drawBmap
	
	graphicsTool 
		copyBitmap: bMap
        from: bMap boundingBox
        at: graphicsTool location.!

drawLine2: anItemlist
    | penHeight str|

    penHeight := graphicsTool  location y + startPoint.
	self drawBmap.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) deadline) at: 
		(((handle rectangle) width )// (100/4)) @ penHeight.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) type) at: 
		(((handle rectangle) width )// (100/15)) @ penHeight.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) description) at: 
		(((handle rectangle) width )// (100/35)) @ penHeight.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) priority) at: 
		(((handle rectangle) width )// (100/80)) @ penHeight.
	(((anItemlist at: itemBeingDrawn) completed)  = true ) ifTrue: [
		str := 'OK'.
	    graphicsTool  lineDisplay: str at: 
			(((handle rectangle) width )// (100/90)) @ penHeight.
	].

	itemWasDrawn := true.

    ^self.!
  
drawLine: anItemlist
    | penHeight |

    penHeight := graphicsTool  location y + startPoint.
	self drawBmap.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) deadline) at: 
		(((handle rectangle) width )// (100/4)) @ penHeight.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) type) at: 
		(((handle rectangle) width )// (100/15)) @ penHeight.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) description) at: 
		(((handle rectangle) width )// (100/35)) @ penHeight.
    graphicsTool  lineDisplay: ((anItemlist at: itemBeingDrawn) priority) at: 
		(((handle rectangle) width )// (100/80)) @ penHeight.
	(((anItemlist at: itemBeingDrawn) completed)  = true ) ifTrue: [
	    graphicsTool  place: (((handle rectangle) width )// (100/91)) @ penHeight.
		self drawTick.
	].

	itemWasDrawn := true.

    ^self.!
   
drawTick
	
	graphicsTool 
		copyBitmap: tickBmap
        from: bMap boundingBox
        at: graphicsTool location.!

initStartPoint

	(Display extent = (640@480)) ifTrue: [ startPoint := 3 ]
		ifFalse: [ startPoint := 6 ].

	bMap := Bitmap fromModule: 'TODO\RES.DLL' id: 258.
	tickBmap := Bitmap fromModule: 'TODO\RES.DLL' id: 259.

	^self! !



!ToDoItem methods !

asParameter

	^(' ' asAsciiZ)!

asPercentDelimitedString

	| compStr |
	compStr := ''.
	(completed = true)  ifTrue: [ compStr := 'true' ].
	(completed = false) ifTrue: [ compStr := 'false' ].
	^'%%',type,'%',description,'%',deadline,'%',priority,'%',compStr,'%%'!
   
asString

	| compStr |
	compStr := ''.
	(completed = true)  ifTrue: [ compStr := 'true' ].
	(completed = false) ifTrue: [ compStr := 'false' ].
	^type,description,deadline,priority,compStr!
 
compareTo: aToDoItem using: aSortKey

    "Returns true if the receiver ToDoItem is less than or equal
     to the argument ToDoItem, using the SortKey as the element
     to be compared.

     This method was originally four IF statements. After working
     with Smalltalk for a while longer it was obvious that this
     case statement-like processing wasn't necessary in OO, if we
     could work out how to do it otherwise.

     What happens here is that aSortKey (which has the value priority
     or deadline etc, is converted into a symbol (unique occurance in
     the system, like PM Atoms) which can then be used as the name of
     a method. The perform: method executes the argument it is given
     by sending it as a message to self (ie the item). So this one-liner
     sets up the sort block as being a comparison between the two items'
     values of one of their instance variables (like type or description).

     If aSortKey was equal to type then the expression would be

     ^self type <= aToDoItem type                                      "

^(self perform: (aSortKey asSymbol)) <= (aToDoItem perform: (aSortKey asSymbol))!
  
compareTo: aToDoItem using: aSortKey order: aSortOrder

    "Returns true if the receiver ToDoItem is less than or equal (LTE)
     to the argument ToDoItem, using the SortKey as the element
     to be compared.    aSortOrder modifies the LTE to GTE.

     This method was originally four IF statements. After working
     with Smalltalk for a while longer it was obvious that this
     case statement-like processing wasn't necessary in OO, if we
     could work out how to do it otherwise.

     What happens here is that aSortKey (which has the value priority
     or deadline etc, is converted into a symbol (unique occurance in
     the system, like PM Atoms) which can then be used as the name of
     a method. The perform: method executes the argument it is given
     by sending it as a message to self (ie the item). So this one-liner
     sets up the sort block as being a comparison between the two items'
     values of one of their instance variables (like type or description).

     If aSortKey was equal to type then the expression could be translated 
     as:	 ^self type <= aToDoItem type  "

	aSortOrder = 'descending' 			"default is thus 'ascending' "
		ifTrue: [
			^(self perform: (aSortKey asSymbol)) 
				>= (aToDoItem perform: (aSortKey asSymbol)) ]
		ifFalse: [ 
			^(self perform: (aSortKey asSymbol)) 
				<= (aToDoItem perform: (aSortKey asSymbol)) ].!
 
completed
    "returns the value of completed"

    ^completed!
  
completed: aValue
    "Sets the value of completed"

    completed := aValue.!
   
copyYourself: aHandle

        "Copy the item to our clipboard"
		|clipMgr|

    CursorManager execute change.

	clipMgr := ClipboardManager new.
	clipMgr setString: (self asPercentDelimitedString).
	clipMgr close.

   CursorManager normal change.!
 
deadline

    "Returns the value of deadline. Provided so that the instance
     variables values can be seen by other objects."

^deadline!
   
deadline: aDeadline

    "Sets the value of deadline to the argument aDeadline. Allows
     other objects to alter the value of deadline. In the ideal OO
     world this is the only place where a change in the structure
     of deadline means any changes have to be made to the access
     routines. Every object that is interested in setting deadline
     has to come through here so one change is all you need."

deadline := aDeadline.!
 
description
    "returns the value of description"

    ^description!

description: aDescription
    "sets the value of description"

    description := aDescription.!
 
initialize

	|days aStream aString field1 field2 field3 |
	days:=((Date today) addDays: (self class defaults at: 1)) formPrint.
	aStream := days asStream.
    field1 := aStream nextWord asLowerCase.
    field2 := aStream nextWord asLowerCase.
    field3 := aStream nextWord asLowerCase.
	aString := WriteStream on: (String new: 8).
	aString nextPutAll: field3; nextPutAll:'.'; nextPutAll: field1;nextPutAll:'.'; nextPutAll: field2. 
	self deadline: aString contents. 
	self type: (self class defaults at: 2).
	self priority: (self class defaults at: 3).
	self description:'new'.
	self completed: false.
	^self.!
  
pdsAsItem: aString

		"Takes a Percent delimited string (from the clipboard paste operation)
		  and returns a ToDoItem. Uses verifyItem to make sure it is a valid item
		  being returned."

		|anArray loop |

"Loop through string, checking it is percent delimited. If so, change any
  blanks into right-brackets. Then change all percents into blanks. If it wasn't
  a valid pdstring, return error."

loop := 1.
((aString at: 1) = $%) & ((aString at: 2) = $%)							"Is it a pasted item ?"
	ifTrue:[ aString do: [ :char | (char = $ )
												ifTrue:[ aString at: loop put: ${].
				   loop := loop + 1
				   ].
		loop := 1.
		aString do: [ :char | (char = $%)
									ifTrue:[ aString at: loop put: $ ].
			loop := loop + 1
			].

		"Get an array of substrings from aString (split at each blank (or blanks) occurance."
		anArray := aString asArrayOfSubstrings.
		
		"Fill in the item."
		self type: (anArray at: 1).
		self deadline: (anArray at: ((anArray size) - 2)).
		self priority: (anArray at: ((anArray size) - 1)).
		(anArray at: (anArray size)) = 'true'
			ifTrue:[self completed:true]
			ifFalse:[self completed:false].

		"If there was a non-blank description field, assign it and reconvert the right brackets
		  back to blanks."
		(anArray size) = 5
			ifTrue:[ loop := 1.
				self description: ((anArray at: 2) do:[ :char | (char = ${)
																											ifTrue:[ (anArray at: 2) at: loop put: $ ].
																							loop := loop + 1
																						])
						]
			ifFalse:[anArray at: 5 put: 'new'.].
			^nil]
		ifFalse:[^'error - clipboard does not contain a valid item: ',aString ].!
   
printYourself

        "Print the text lines."
    | aHandle |
    CursorManager execute change.
    aHandle := FileHandle openDevice: 'LPT1'.
	aHandle deviceWrite: '***************************'.
    aHandle deviceWrite: (String with: Lf with: Cr).
    aHandle deviceWrite: (deadline, '  ',  type, '  ', description, '  ', priority).
    aHandle deviceWrite: (String with: Lf with: Cr).
"	aHandle deviceWrite: 'ToDo item printed'."
    aHandle deviceWrite: (String with: Lf with: Cr).
    aHandle close.
    CursorManager normal change!
   
priority
    "returns the value of priority"
    ^priority!
   
priority: aPriority
    "takes a string value and sets the value of priority using integers"

    priority := aPriority!
 
type
    "returns the value of type"
    ^type!
   
type: aType
    "sets the value of type"
    type := aType.!
  
verifyItem

	"Checks that an item contains allowable values for priority and type."
	|errorType errorPriority|

((ToDoItem typesAvailable) includes: (self type))
	ifFalse:[ errorType := self type.
					^'Type: ', errorType, ' incorrect - item not pasted'].

((ToDoPriorityList new prioritiesAvailable) includes: (self priority))
	ifFalse:[ errorPriority := self priority.
					^'Priority: ', errorPriority, ' incorrect - item not pasted'].

^nil! !



!ToDoPriorityList methods !

initialize
	|loop|
	loop :=1.
	self class priorities do: [ :a | self at: loop put: a.  
															loop := loop+1 ].

^self.!
 
prioritiesAvailable

	^self class priorities.! !



!ToDoList methods !
   
addItem: anItem

    "Add the item to the list.  "

    self add: anItem .
"    self sortList.
	^(self indexOf: anItem)."
	^endPosition.!

readList

    "Read the ToDo list from disk.
     The list is stored as a Smalltalk collection
     (using the ObjectFiler).  It is read, then sorted.
     This method is used  when ToDoList view is opened."

   |input tempList |

    input := Disk file: 'TODO\TODOFILE.OBJ'.
    ((input contents) = '') 
		ifFalse: [ tempList := ObjectFiler loadFromPathName: 'TODO\TODOFILE.OBJ'.
			(self replaceFrom:1 to:(self size) with: tempList).
		].
    input close.
^self.!

removeAll
      " Remove the contents of the ToDoList"

       ^( super removeAll: self ) .!
 
removeItem:anItemIndex

    "Remove an item.  "

     super removeIndex: anItemIndex .

    ^self.!
   
sortList

    "Resort the list of items and return the list. "

      | tempList |

      ( self size  > 1 )
             ifTrue: [ tempList := self asSortedCollection:
                                    [ :a :b | a compareTo: b using: sortKey order: sortOrder] .
                          self replaceFrom:1 to: (self size) with: tempList.
                            ].
      ^ self .!
 
sortList: aSortKey order: aSortOrder

    "Update the sortKey and Order "

	|pDict|

    sortKey := aSortKey .
	sortOrder := aSortOrder.

	"Priority is stored as a string. To allow sorting, an integer value is put into priority for 
	  the sort. The value is based on ToDoPriorityList's entry for each priority value."

 	 (sortKey = 'priority')
		ifTrue:[ pDict := ToDoPriorityList new initialize.
		 	self do:[ :eachItem| eachItem priority: (pDict keyAtValue: ( eachItem priority))].
 			self sortList.
		 	self do:[ :eachItem| eachItem priority: (pDict at: ( eachItem priority))].
		]
		ifFalse:[ self sortList.].
^ self.!

updateItem:anItem at:anIndex

    "Change an item in the list.  "

    self at: anIndex  put: anItem .
"    self sortList."
	^(self indexOf: anItem).!

writeList
    "Write the ToDo list on disk using ObjectFiler. "

| saveFileName |

	saveFileName := 'TODO\TODOFILE.OBJ'.
	ObjectFiler dump: self newFile: saveFileName.
^saveFileName.! !



!ToDoSettings methods !
 
codePage
	^codePage!
   
codePage: aCodePage

		"Values harcoded in ToDoSettingsView class (openCountry method)."
	codePage := aCodePage!
 
country
	^country!
 
country: aCountry

		"Values harcoded in ToDoSettingsView class (openCountry method)."

	country := aCountry!
   
deadlineDefault: aDay

	defaultItem at: 1 put: aDay.!
 
defaultItem

^defaultItem!

defaultItem: aCollection
	"Sets the value of the currently held default Item"

	defaultItem := aCollection.
	ToDoItem defaults: aCollection.!
   
defaultSettings

	"private - only used if no object stored on disk."

	self sortKey: 'priority';
		sortOrder: 'ascending';
		codePage: '850';
		country:'UK';
		includeCriterion: 'all'.
		self setDefaultPriorities.!
 
exchangeWithSavedSettings: savedSettings

		"Exchange values so that this object has the values from the
		  disk-saved settings. Did this because you cannot assign self 
		  to an object."

self sortKey: savedSettings sortKey;
	codePage: savedSettings codePage;
	sortOrder: savedSettings sortOrder;
	country: savedSettings country;
	includeCriterion: savedSettings includeCriterion.

	(savedSettings defaultItem isNil)
		ifTrue:[self setDefaultItem]
		ifFalse:[self defaultItem: (savedSettings defaultItem)].!

includeCriterion
	^includeCriterion!
   
includeCriterion: anIncludeCriterion

		"Values possible are all, completed or uncompleted"

	includeCriterion := anIncludeCriterion!
   
initialise	

	"called from class method new, here we check for a previous
	 saved settings object; if we find one, we tell the view the 
	 settings it needs to display, else it comes up blank."

	self readSettings.!
   
priorityDefault: aPriority

	defaultItem at: 3 put: aPriority.!
   
readSettings

		"Here is where the settings get read from disk (using the ObjectFiler).
		  The defaults are hardwired in below. Other Jingoists may set their own!!
		
		  Note that the order, country and code page are not implemented in the
		  ListView so it is only affected by the sortKey settings."

    | input tempSettings|
    input := Disk file: 'TODO\TODOFILE.SET'.
	input close.
    input := Disk file: 'TODO\TODOFILE.SET'.
    ((input contents) = '') ifTrue: [			
				self defaultSettings; 
					setDefaultItem.
               ] 
	ifFalse: [
		tempSettings := ObjectFiler loadFromPathName: 'TODO\TODOFILE.SET'.
        self exchangeWithSavedSettings: tempSettings.
		self setDefaultPriorities.
	].

    input close.!
  
setDefaultItem

	"private - only used if no object stored on disk."
	| coll |
	coll := OrderedCollection new.
	coll add: 1; add: 'Phone'; add: 'High'.
	self defaultItem: coll.
	^self.!
 
setDefaultPriorities
	"private - only used if no object stored on disk."

	ToDoPriorityList priorities: #('High' 'Medium' 'Low').
	^self.!
  
settings
		"If asked, return ourselves ie a Settings object"

	^self.!
   
sortKey

	^sortKey!
   
sortKey: aKey

	sortKey := aKey!
  
sortOrder
	^sortOrder!
 
sortOrder: aSortOrder
	sortOrder  := aSortOrder!
   
typeDefault: aType

	defaultItem at: 2 put: aType.!
   
writeSettings

	"Here is where the settings get written to disk (using the ObjectFiler)."

	|saveFileName|

	saveFileName := 'TODO\TODOFILE.SET'.
	ObjectFiler dump: self newFile: saveFileName.

^saveFileName.! !



!ToDoRowDisplay methods !
   
aCheck: aCheckBox

        "aCheckBox has been clicked"

	^nil!
 
addFields

	((Display extent) = (640@480)) ifTrue: [ self addVgaFields ]
		ifFalse: [ self addXgaFields  ].!
 
addVgaFields

| fld |

	fieldList := OrderedCollection new.

	self addSubpane:
		((deadline :=  EntryField new)
			owner: self;
			framingRatio: ((4/100) @ (82/100) 
				extentFromLeftTop: (10/100) @ (64/100))).

	fieldList add: deadline.

  self
	 addSubpane: 
			( (type := SpinButton leftJustifiedText )
                 owner: self;
                 contents: ToDoItem typesAvailable;
                  framingRatio: ((15/100) @ (11/10) 
				extentFromLeftTop: (20/100) @ 1)).

	fieldList add: type.

	self addSubpane:
        ((description :=  EntryField new)
			owner: self;          
			framingRatio: ((36/100) @ (82/100) 
				extentFromLeftTop: (45/100) @ (64/100))).

	fieldList add: description.

 self addSubpane:
        ((priority := SpinButton leftJustifiedText )
			owner: self;
			contents: (ToDoPriorityList new prioritiesAvailable);		
			framingRatio: ((82/100) @ (11/10)  
					extentFromLeftTop: (10/100) @ 1 )).

	fieldList add: priority.

	self
         addSubpane: 
			((completed :=  CheckBox new)
                 owner: self;
                 contents: '';
                 when: #clicked perform: #aCheck: ;
					framingRatio: ((94/100) @ 1  
					extentFromLeftTop: (7/100) @ 1 )).
	fieldList  add: completed.!
 
addXgaFields

| fld |

	fieldList := OrderedCollection new.

	self addSubpane:
		((deadline :=  EntryField new)
			owner: self;
			framingRatio: ((4/100) @ (75/100) 
				extentFromLeftTop: (10/100) @ (65/100))).

	fieldList add: deadline.

  self
	 addSubpane: 
			( (type := SpinButton leftJustifiedText )
                 owner: self;
                 contents: ToDoItem typesAvailable;
                  framingRatio: ((15/100) @ 1 
				extentFromLeftTop: (19/100) @ 1)).

	fieldList add: type.

	self addSubpane:
        ((description :=  EntryField new)
			owner: self;          
			framingRatio: ((35/100) @ (75/100) 
				extentFromLeftTop: (45/100) @ (65/100))).

	fieldList add: description.

 self addSubpane:
        ((priority := SpinButton leftJustifiedText )
			owner: self;
			contents: (ToDoPriorityList new prioritiesAvailable);		
			framingRatio: ((81/100) @ 1  
					extentFromLeftTop: (8/100) @ 1 )).

	fieldList add: priority.

	self
         addSubpane: 
			((completed :=  CheckBox new)
                 owner: self;
                 contents: '';
                 when: #clicked perform: #aCheck: ;
					framingRatio: ((93/100) @ 1  
					extentFromLeftTop: (8/100) @ 1 )).
	fieldList  add: completed.!
  
checkDate

	"check that the date is valid"
	| aStream field1 field2 field3 day month year |

    aStream := (deadline contents) asStream.
    field1 := aStream nextWord asLowerCase.
    field2 := aStream nextWord asLowerCase.
    field3 := aStream nextWord asLowerCase.
	((field2 asInteger) > 12) | ((field3 asInteger) < 1)
				ifTrue: [^false]
				ifFalse: [ 
						month := Date nameOfMonth: (field2 asInteger).
					    year := field1 asInteger.
					    year < 100 ifTrue: [year := year + 1900].
								].
	day := field3 asInteger.
	day > (Date daysInMonth: month forYear: year)
				ifTrue: [^false].
	^true.!
   
close: aWin

	^super close!
   
ctlWindow: aWindow

	ctlWindow := aWindow!

currentItem

	| item |

	item := ToDoItem new.

	item deadline: deadline contents.
	item description: description contents.
	item type: type selection.
	item priority: priority selection.
	item completed: completed getValue.
	^item!
 
displayItem: anItem

	deadline contents: anItem deadline.
	description contents: anItem description.
	type selection: anItem type.
	priority selection: anItem priority.
	completed selection: anItem completed.!
 
hide

	(views at: 1) hideWindow.
	((views at: 1) parent ) hideWindow.!
   
initWindow

	self 
		labelWithoutPrefix: 'ToDo Row Display';
		owner: self;
		when: #close perform: #close: ;
		addFields.
	HelpManager for: (self mainView) title: 'Help' file: 'todo\todo.hlp'.

	^self!
 
initWindow: anOwner

	^self labelWithoutPrefix: 'Row Display';
		owner: anOwner;
		when: #close perform: #close: ;
		addFields.!
   
initWindowSize
        "Private - Answer the initial size of the receiver."

	^(Display width * 19 //20) @ (Display height * 1 // 18).!
  
moveAbsolute: aRect
	
	| rect |

	rect := aRect.
	PMWindowLibrary setWindowPos: (((views at: 1) parent) handle)
        hwndInsertBehind: HwndTop
        x: rect origin x
        y: rect origin y 
        cx: rect width
        cy: rect height
        fs: SwpMove | SwpSize | SwpZorder!
   
newItem
	"this is the method we would change if we wanted to 
	change any of the default ToDoItem settings in the settings view.
	Today, this method simply copies the selected item."

	^ToDoItem newItem.!
   
newItem: anItem

	deadline contents: anItem deadline.
	description contents: anItem description.
	type selection: anItem type.
	priority selection: anItem priority.
	completed selection: anItem completed.!
 
open
self halt.
	self initWindow.

	self openWindow.!
   
openWindow: aRect

	^((views at: 1) openWindow: aRect )!
  
rowDown

	ctlWindow rowDown!
  
rowUp

	ctlWindow rowUp!
  
show

	(views at: 1) showWindow.

	((views at: 1) parent ) showWindow.!
 
tabToNextField
| index |

	index := 0.

	fieldList do: 
		[ :field |
			index := index + 1.
			(field haveFocus) ifTrue: [
				((index+1) = 5) ifTrue: [ index := 0 ].
				(fieldList at: (index+1)) setFocus.
				^ nil ].				
		]!

tabToPrevField

	^nil!

topPaneClass
        "Private - Answer the default top pane class."
    ^SimpleTopPane! !



!ToDoSettingsView methods !
  
addCountryPage
| page |

	page := NotebookPage new
					window: countryPage. 
	page
		minor
		tab: ('Country').
	notebook appendPage: page.!

addDefaultPage
| page |

	page := NotebookPage new
					window: defaultsPage. 
	page
		minor
		tab: ('Sorting').
	notebook appendPage: page.
	topPage := page.!

addDefaultsPage
| page |

	page := NotebookPage new
					window: defaultsPage. 
	page
		minor
		tab: ('Defaults').
	notebook appendPage: page.
	topPage := page.!
  
addIncludePage
| page |

	page := NotebookPage new
					window: includePage. 
	page
		minor
		tab: ('Include').
	notebook appendPage: page.!

addSortPage
| page |

	page := NotebookPage new
					window: sortPage. 
	page
		minor
		tab: ('Sorting').
	notebook appendPage: page.
	topPage := page.!
   
allPress: aButton
	
		"User pressed the radio button that includes all items in the
		  list view. "

	ctlSettings includeCriterion: 'all'.!
   
applyButton: aButton

		"When the apply button is pressed, this view finds which settings
		  are currently selected and tells the settings model. It then informs
		  the ListView that things have changed ie do a refresh. To get back
		  to the previous settings, the user needs to do a RESET."

	"ctlSettings "
	ctlView refreshButton: nil.!
   
ascendingPress: aButton
	
		"User pressed the radio button that chooses an ascending sort order in the
		  list view. "

	ctlSettings sortOrder: 'ascending'.!
 
close: aView

 "	ctlView showRow."
	^super close.!
   
codePageChanged: aComboBox

		"A different value has been choosen for the codePagesetting -
		  this is where it gets updated."

	ctlSettings codePage: ( aComboBox text ).!
   
compPress: aButton
	
		"User pressed the radio button that includes only completed items in the
		  list view. "

	ctlSettings includeCriterion: 'completed'.!
 
countryChanged: aComboBox

		"A different value has been choosen for the country setting -
		  this is where it gets updated."

	ctlSettings country: ( aComboBox text ).!
 
ctlView: aView andSettings: aToDoSettings


		"aView - This is the ToDoListView that opened this SettingsView,
		  and aToDoSettings is the Settings object in force (opened by
		  ToDoListView)."

	ctlView := aView. 
	ctlSettings := aToDoSettings.

		"The SettingsView (this object) then gets its setting info from
		  the ToDoSetting object previously saved on disk."

	self initialiseControls.!
   
deadlineDefaultChange: aSpinButton

ctlSettings deadlineDefault: aSpinButton selection.!
  
deadlinePress: aButton
	
| settings |

	settings := ctlView settings.
	settings sortKey: 'deadline'.
	ctlView settings: settings.!

descendingPress: aButton
	
		"User pressed the radio button that chooses an descending sort order in the
		  list view. "

	ctlSettings sortOrder: 'descending'.!
  
descriptionPress: aButton
	
| settings |

	settings := ctlView settings.
	settings sortKey: 'description'.
	ctlView settings: settings.!
  
initialiseControls

		"Get the settings from the saved version and initialise the buttons
		  and fields to reflect the settings. If no saved version available,
		  put in some defaults.

		  Warning: Implementation kludge!! All the notebook's controls are
		  saved in a Dictionary when created - this is how  we get
		  to them to set the initial state. We used a Dictionary rather than
		  many instance variables cluttering up the class. The location of 
		  each control in the Dictionary is dependant on the order of adding 
		  them. "

	"First the sortField radioButtons"
	"Next the sortOrder radioButtons"
	"Next the includeCriterion radioButtons"
	"Next the defaultItem settings for when a new item is added to the list."
	"Finally the country and codePage combo boxes"

	(nbControls at: (ctlSettings sortKey)) selection: true.
	(nbControls at: (ctlSettings sortOrder)) selection: true.
	(nbControls at: (ctlSettings includeCriterion)) selection: true.
 	(nbControls at: 'deadlineDefault') selection: (ctlSettings defaultItem at:1).
 	(nbControls at: 'priorityDefault') selection: (ctlSettings defaultItem at:3).
 	(nbControls at: 'typeDefault') selection: (ctlSettings defaultItem at:2).
	(nbControls at: 'codePage') selectItem: (ctlSettings codePage).
	(nbControls at: 'country') selectItem: (ctlSettings country).!
   
initWindowSize
        "Private - Answer the initial size of the receiver."

	^(Display width * 3//5) @ (Display height * 4//7).!

menuSetup

	(self menuTitled:'ThingsToDo') disableItem:'Open as ~Settings'. 
	(self menuTitled:'Edit') disableItem:'~Undo'. 
	(self menuTitled:'Edit') disableItem:'~Redo'. 
	(self menuTitled:'View') disableItem:'Se~ttings'.!
   
open

    self labelWithoutPrefix: ' Things To-Do Settings View';
		owner: self.
	self when: #close perform: #close: .
   
     self addSubpane: ( notebook := Notebook new
        owner:self;
		pageButtonExtent: 30 @ 30;
		majorTabExtent: 10 @ 20;
		minorTabExtent: 70 @ 20;
 		style: BksPolygontabs;
        framingRatio: ((1/20) @ (19/20)
			extentFromLeftTop: (18/20) @ (4/5))).

    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #applyButton: ;
        contents: '~Apply';
        framingRatio: ((1/15) @ (1/40) 
				extent: (1/4) @ (1/10))).

     self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #saveButton: ;
        contents: '~Save';
        framingRatio: ((11/32) @ (1/40) 
				extent: (1/4) @ (1/10))).

    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #resetButton: ;
        contents: '~Reset';
        framingRatio: ((5/8) @ (1/40) 
				extent: (1/4) @ (1/10))).

		"At some point we must fill in the settings that have been retrieved
		  from the ctlSettings object. nbControls is the dictionary that accesses
		  the controls used in the notebook. It is set up in the following methods:
		  sortGroup, OrderGroup, IncludeGroup & CountryWindow. Here we just
		  instantiate the object. The actual settings are done in initialiseControls,
		  which is called from ctlView:andSettings:."

	nbControls := Dictionary new.
	

	self openSortWindow;
		openIncludeWindow;
		openCountryWindow;
		openDefaultsWindow;
		addCountryPage;
		addIncludePage;
		addDefaultsPage;
		addSortPage.

	notebook selection: topPage.
	HelpManager for: (self mainView) title: 'Help' file: 'todo\todo.hlp'.
	self 	openWindow.

	"Since we opened as a ToDoSetting (rather than a List) grey out the
	  inappropriate menu options."
	self menuSetup.!

openCountryWindow

	| mainWindow |
    notebook addSubpane: (countryPage := GroupPane new
        owner: self).
    countryPage style: (countryPage frameStyle - FcfBorder).

	countryPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Codepage';
		            framingRatio: ((1/2) @ 1 
				extentFromLeftTop: (1/4) @ (1/7))).

	countryPage addSubpane: (nbControls at: 'codePage' put:  (ComboBox new "dropDown" 
                owner: self;
                contents: #( '850' '437'  '285'  '007'  );
          	when: #textChanged perform: #codePageChanged:; 
                framingRatio: ((1/2) @ (2/3) 
		  extentFromLeftTop: (1/3) @ (1/2)))).

	countryPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Country';
		            framingRatio: ((1/16) @ 1 
				extentFromLeftTop: (1/4) @ (1/7))).

	countryPage addSubpane: (nbControls at: 'country' put:  (ComboBox new "dropDown"
                owner: self;
                contents: #( 'UK' 'Japan' 'Belgium' 'Finland' 'South Africa'  'Germany'  'Italy'  );
          	when: #textChanged perform: #countryChanged:; 
                framingRatio: ((1/16) @ (2/3) 
		  extentFromLeftTop: (1/3) @ (1/2)))).

"Authors: 6/12/91 ITSC Boca

	Jouko Ruuskanen
	Giffin Lorimer
	Osamu Ochiai
	Raj Singh"!
  
openDefaultsWindow

	| mainWindow |
    notebook addSubpane: (defaultsPage := GroupPane new
        owner: self).
    defaultsPage style: (defaultsPage frameStyle - FcfBorder).

	defaultsPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Application Defaults';
		            framingRatio: ((1/4) @ 1 
				extentFromLeftTop: (1/2) @ (1/7))).

	defaultsPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Deadline - Today plus';
		            framingRatio: ( ( ( Rectangle leftTopUnit right: ( 1/32 ) ) down: 1/5)
                     extentFromLeftTop: 6 @ 3/16 )).

	defaultsPage
		addSubpane:  (nbControls at: 'deadlineDefault' put: (SpinButton numeric
			minimum: 0;
			maximum: 31;
			when: #textChanged perform: #deadlineDefaultChange: ;	
            framingRatio: ( ( (Rectangle leftTopUnit right: ( 7/16 ) ) down: 1/5)
                     extentFromLeftTop: 3/4@ 1/8 ))).

defaultsPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'days';
		            framingRatio: ( ( ( Rectangle leftTopUnit right: ( 9/16 ) ) down: 1/5)
                     extentFromLeftTop: 3/2 @ 3/16 )).

	defaultsPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Type';
		            framingRatio: ( ( ( Rectangle leftTopUnit right: ( 1/32 ) ) down: 2/5)
                     extentFromLeftTop: 3/2 @ 3/16 )).

	defaultsPage
		addSubpane:  (nbControls at:'typeDefault' put: (SpinButton leftJustifiedText
			contents: (ToDoItem typesAvailable) ;
			when: #textChanged perform: #typeDefaultChange: ;	
            framingRatio: ( ( (Rectangle leftTopUnit right: ( 7/16 ) ) down: 2/5)
                     extentFromLeftTop: 5/2 @ 1/8 ))).

	defaultsPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Priority';
		            framingRatio: ( ( ( Rectangle leftTopUnit right: ( 1/32 ) ) down: 3/5)
                     extentFromLeftTop: 3/2 @ 1/4 )).

	defaultsPage
		addSubpane:  (nbControls at: 'priorityDefault' put: (SpinButton leftJustifiedText
			contents: (ToDoPriorityList new prioritiesAvailable);
			when: #textChanged perform: #priorityDefaultChange: ;	
            framingRatio: ( ( (Rectangle leftTopUnit right: ( 7/16 ) ) down: 3/5)
                     extentFromLeftTop: 2 @ 1/8 ))).

"Authors: 6/12/91 ITSC Boca

	Jouko Ruuskanen
	Giffin Lorimer
	Osamu Ochiai
	Raj Singh"!
 
openIncludeGroup: groupPane 
	| height inset |
	inset := 1/16.
	height := 1/5.
	groupPane
		addSubpane:
			(
			GroupBox new
				owner: self;
				style: GroupPane noBorderFrameStyle;
				contents: 'Sort field:';
				framingRatio: ( 0@0 extent: 1@1 );
				yourself
			);
		addSubpane: 
			( nbControls at: 'all' put: (RadioButton new		
              		owner: self;   
             		contents: 'All Items';   
             		when: #clicked perform: #allPress:; 
			framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 1/4 )
			  extentFromLeftTop: 7/8  @ height )
			));
		addSubpane: 
			( nbControls at: 'completed' put: (RadioButton new
               		owner: self;   
	                contents: 'Completed Items only';    
        	        when: #clicked perform: #compPress:;
			framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 2/4 )
			  extentFromLeftTop: 7/8  @ height )
			));
	addSubpane: 
			( nbControls at: 'uncompleted' put: (RadioButton new
  		       	owner: self;   
              		contents: 'Uncompleted Items only';    
		        when: #clicked perform: #uncompPress:;
			framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 3/4 )
			  extentFromLeftTop: 7/8  @ height )
			)).!

openIncludeWindow

	| mainWindow group |
    notebook addSubpane: (includePage := GroupPane new
        owner: self).
    includePage style: (includePage frameStyle - FcfBorder).

	includePage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Include defaults';
		            framingRatio: ((1/4) @ 1 
				extentFromLeftTop: (1/2) @ (1/7))).

	includePage addSubpane:
			(
			group := GroupPane new
"			style: GroupPane noBorderFrameStyle;"
			framingRatio: 
				( ( ( Rectangle leftTopUnit right: (1/16) ) down: 1/6 )
				  	extentFromLeftTop: ( 1/2 ) @ ( 3/4 ) );
			yourself
			).
		self openIncludeGroup: group.!
   
openOrderGroup: groupPane 
	| height inset |
	inset := 1/16.
	height := 1/5.
	groupPane
		addSubpane:
			(
			GroupBox new
				owner: self;
"				style: GroupPane noBorderFrameStyle;"
				contents: 'Sort order:';
				framingRatio: ( 0@0 extent: 1@1 );
				yourself
			);
		addSubpane: 
			( nbControls at: 'ascending' put: (RadioButton new		
                        owner: self;   
                        contents: 'Ascending';    
                 	when: #clicked perform: #ascendingPress:; 
			framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 1/4 )
			  extentFromLeftTop: 7/8  @ height )
			));
	addSubpane: 
		( nbControls at: 'descending' put: (RadioButton new
                owner: self;   
                contents: 'Descending';    
          	when: #clicked perform: #descendingPress:; 
		framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 1/2 )
  		  extentFromLeftTop: 7/8  @ height )
		)).!
  
openSortGroup: groupPane 

		"This is where the controls in the sort field of the default (sort) page of the 
		  notebook control  are set up. The dimensions of the group first, then the 
		  controls themselves inside the group pane."
		
	| height inset|
	inset := 1/16.
	height := 1/5.
	groupPane
		addSubpane:
			(
			GroupBox new
				owner: self;
"				style: GroupPane noBorderFrameStyle;"
				contents: 'Sort field:';
				framingRatio: ( 0@0 extent: 1@1 );
				yourself
			).		

	groupPane	
	  addSubpane: 
	    ( nbControls at: 'description' put: (RadioButton new		
            owner: self;   
            contents: 'Description';
            when: #clicked perform: #descriptionPress:; 
	    framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 1/8 )
	      extentFromLeftTop: 7/8  @ height )
	    )).


	groupPane
	  addSubpane: 
	    ( nbControls at: 'deadline' put: (RadioButton new		
            owner: self;   
            contents: 'Deadline';   
            when: #clicked perform: #deadlinePress:; 
	    framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 5/16 )
	      extentFromLeftTop: 7/8  @ height )
	    )).

	groupPane
	  addSubpane: 
	    ( nbControls at: 'type' put: (RadioButton new
            owner: self;   
            contents: 'Type';    
            when: #clicked perform: #typePress:;
	    framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 1/2 )
	      extentFromLeftTop: 7/8  @ height )
	    )).

	groupPane
	  addSubpane: 
	    ( nbControls at: 'priority' put: (RadioButton new
            owner: self;   
            contents: 'Priority';    
            when: #clicked perform: #priorityPress:;
	      framingRatio: ( ( ( Rectangle leftTopUnit right: inset ) down: 11/16 )
		extentFromLeftTop: 7/8  @ height )
  	     )).!
  
openSortWindow

	| mainWindow group |
    notebook addSubpane: (sortPage := GroupPane new
        owner: self).
    sortPage style: (sortPage frameStyle - FcfBorder).

	sortPage 
        addSubpane: 
             ( ( StaticText new )
					contents: 'Application Sorting';
		            framingRatio: ((1/4) @ 1 
				extentFromLeftTop: (1/2) @ (1/7))).

	sortPage addSubpane:
			(
			group := GroupPane new
			style: GroupPane noBorderFrameStyle ;
			framingRatio: 
				( ( ( Rectangle leftTopUnit right: (1/16) ) down: 1/6 )
				  	extentFromLeftTop: ( 2/5 ) @ ( 3/4 ) );
			yourself
			).
		self openSortGroup: group.

	sortPage addSubpane:
			(
			group := GroupPane new
			style: GroupPane noBorderFrameStyle;
			framingRatio: 
				( ( ( Rectangle leftTopUnit right: (1/16 + 1/2) ) down: (1/6) )
				  	extentFromLeftTop: ( 2/5 ) @ ( 3/4 ) );
			yourself
			).
		self openOrderGroup: group.!

priorityDefaultChange: aSpinButton

ctlSettings priorityDefault: aSpinButton selection.!
  
priorityPress: aButton
	
| settings |

	settings := ctlView settings.
	settings sortKey: 'priority'.
	ctlView settings: settings.!

readUserSelections

		"This method checks all the controls in the notebook, notes their settings
		  and returns a settings object that can be used to update the ctlSettings
		  object when the apply button is pushed."!
 
resetButton: aButton

		"When reset is pressed, this view asks the Settings model to return
		  the last saved settings. It then gives thses settings to the ListView
		  so that it may return to those settings."

    	ctlView settings: (ctlSettings readSettings).
	self initialiseControls.
	ctlView refreshButton: nil.!
 
saveButton: aButton 

		"When save is pressed, tell the ToDoSettings object (ctlSettings) to save
		  itself on disk."

	ctlSettings writeSettings.!
   
sized

	^nil!
 
topPaneClass

	^ToDoTopPane!
  
typeDefaultChange: aSpinButton

ctlSettings typeDefault: aSpinButton selection.!
  
typePress: aButton
	
| settings |

	settings := ctlView settings.
	settings sortKey: 'type'.
	ctlView settings: settings.!

uncompPress: aButton
	
		"User pressed the radio button that includes only uncompleted items in the
		  list view. "

	ctlSettings includeCriterion: 'uncompleted'.! !



!ToDoListView methods !
  
aChoice: aLBox

	"A new selection has been made in the listbox.
	Check if the contents of the edit fields have been changed.
	If they have, update the todo list."

	self clrStatusFields.

	(rowDisp checkDate) 
		ifFalse: [ (statusField backColor: ClrRed;  contents: 'Error in date - change not accepted').
						 todoListBox selection: prevSelection.
						 ^self displayItem ].
	self changedItem.
	self displayItem.!
  
addButtons

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
  	        box origin + ( 9*listLineHeight @ ( listLineHeight) )
      			corner: 12@
                    2*listLineHeight ]).
    self addSubpane: (Button new
        owner: self;
        when: #clicked perform: #refreshButton: ;
        contents: 'Refresh';
	             framingBlock: [:box|
  	        box origin + ( 14*listLineHeight @ ( listLineHeight) )
      			corner: 17@
                    2*listLineHeight ]).!
   
addHeaders: aPane
    aPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Deadline';
	            owner: self;
		        framingRatio: ((4/100) @ (1/10) 
				extent: (10/100) @ (8/10))).
    aPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Type';
	            owner: self;
		        framingRatio: ((15/100) @ (1/10) 
				extent: (15/100) @ (8/10))).
    aPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Description';
	            owner: self;
		        framingRatio: ((35/100) @ (1/10) 
				extent: (20/100) @ (8/10))).

    aPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Priority';
	            owner: self;
		        framingRatio: ((80/100) @ (1/10) 
				extent: (8/100) @ (8/10))).

    aPane 
        addSubpane: 
             ( ( StaticText new )
				contents: 'Done';
	            owner: self;
		        framingRatio: ((89/100) @ (1/10) 
				extent: (11/100) @ (8/10))).!
   
addItem

	| tempItem |
	self changedItem.
	tempItem := ToDoItem newItem.	
	itemList add: tempItem.

	self addUndoItem: tempItem atValue: ''.
	self undoToRedo.

	todoListBox contents: itemList.
	todoListBox selection: (itemList size).
	self aChoice: nil.

	statusField backColor: ClrYellow;
		contents: 'New item added!! - use Defaults page in Settings to alter new item defaults'!
 
addOwnerDragListBox

	| dragProtocol |

	self addSubpane:
			((todoListBox := ListBoxODraw ownerDraw)
                 owner: self;
                 itemHeight: listLineHeight;
                 when: #select perform: #aChoice:;
				 when: #getMenu perform: #menu:;
 				 when: #drawItem perform: #drawLine: ;
	            when: #startDrag perform: #startDragLBox:;
	            when: #dragComplete perform: #dragCompleteLBox:;

	             framingBlock: [:box|
    	        box origin + ( 0 @ (2*listLineHeight) )
        	        corner: (box width ) @
                    (box height- (listLineHeight))]).

    dragProtocol := DragDrop for: todoListBox.
    dragProtocol 
        container: 'dummy';
        mechanisms: ( Array with: DragString new ).

    todoListBox dragDrop: dragProtocol.!
   
addStatus


    self addSubpane: (statusField := StaticText new
        owner: self;
        contents: 'Status messages displayed here';
	             framingBlock: [:box|
			box origin + (0 @ 0)
			corner: box width @20 ]).!
   
addUndoItem: aKey  atValue:aValue                  
                                                                  
        "store the new and original ToDoItemsfor undo"  
                                                                             
         undoItem key: aKey; value: aValue.
       ^self.                                               
                                                                  
       "The following items may be stored:                  
            if new,          save key + '' (nil)                  
            if changed,  save key + original value                
            if deleted,    save nil + original value  .           
        This allows us to test for each, and perform              
        adds, deletes and changes as required"!
  
calcRowPos2: aRow
	"Calculate the new location of the row display window.
		Created: 	November 6, 1991
		Author:		Jouko Ruuskanen "

	|diff  rect rect2  yMax  xRight |

	rect := ((views at: 1) parent) rectangle.   "Frame rectangle "
	rect2 := todoListBox rectangle.                "Listbox rect"

	yMax := rect rightBottom y + rect2 leftTop y -  rect2 leftBottom y.
	xRight := rect rightBottom x - 24.

	diff := listLineHeight*(aRow -  (todoListBox getTopIndex) ).
	^rect := (rect  leftTop x @ (yMax+ (2*listLineHeight) + 3 - diff )) 
			rightBottom: (xRight @ ((yMax - diff + listLineHeight) - 2)).!
 
calcRowPos: aRow
	"Calculate the new location of the row display window.
		Created: 	October 17, 1991
		Author:		Jouko Ruuskanen "

	|diff  rect  |

	rect := todoListBox rectangle.                "Listbox rect"

	diff := listLineHeight*(aRow -  (todoListBox getTopIndex) ).
	^rect := (rect leftTop x @ (rect leftTop y   - diff + 2)) 
			rightBottom: ((rect rightBottom x - listLineHeight + 7) @ ((rect leftTop y) - diff - listLineHeight - 3)).!
 
changedItem
	(((itemList at: prevSelection) asString) = ((rowDisp currentItem) asString))
	ifFalse: [
		itemList at: prevSelection put: rowDisp currentItem.
	 ].!
  
close: aWin 

"	itemList writeList."
"  	rowDisp close."
	^super close!
 
clrStatusFields

	statusField backColor: ClrWhite;
		contents: ''.!
  
copyItem
		
	"This method eliminates the problem caused by the pop-up context menu
		which gets called from ToDoListView, and the menu structure, which
		comes from ToDoTopPane."

self copyItem: (views at: 1) handle.!
 
copyItem: aHandle

	"Copy an Item to the Clipboard"

	(itemList at: (todoListBox selection)) copyYourself: aHandle.

	statusField backColor: ClrYellow;
		contents: 'Item copied to Clipboard'!
  
cutItem

(views at: 1) cutItem.!
  
displayItem
	rowDisp hide.
	rowDisp moveAbsolute: (self calcRowPos: todoListBox selection).
	rowDisp newItem: (itemList at: (todoListBox selection)).
	prevSelection := todoListBox selection.
	rowDisp show.!
 
dragCompleteLBox: aPane

"    inform todoListBox of the end of drag/drop operation 
"!
   
drawLine: aListBoxODraw	
	(( todoListBox selection ) isNil ) ifFalse: [
	aListBoxODraw drawLine: itemList ]!
  
dropCompletePrt: aPane

	self printItem.
" if you want to print the item (a more sophisticated way) , do this: 

    aPane dragDrop items do: [ :item | (item userInfo) printYourself ].

"!
 
dropCompleteTrash: aPane

	self removeItem.
" if you want to print the item , do this: 

    aPane dragDrop items do: [ :item | item printYourself ].

"!

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
   
menuSetup

	(self menuTitled:'ThingsToDo') disableItem:'~Open as ToDo List'. 
	(self menuTitled:'Edit') disableItem:'~Undo'. 
	(self menuTitled:'Edit') disableItem:'~Redo'. 
	(self menuTitled:'View') disableItem:'~List'.
	(self menuTitled:'Edit') changeItem:'~Undo' selector:#undo.
	(self menuTitled:'Edit') changeItem:'~Redo' selector:#redo.!
  
newButton: aButton

	self addItem.!
   
open
    "Open a ToDoListView which contains a list of the items."

| hPane tempToDoTopPane |

	self setItemHeight.

    self
        owner: self;
        labelWithoutPrefix: 'Things To-Do List View'.

	self when: #close perform: #close: .

    self 
        addSubpane: 
             ( ( hPane := GroupPane new )
	            owner: self;
				style: GroupPane noBorderFrameStyle;
    	        framingBlock: [:box|
        	        box origin x @ (
					box height - listLineHeight) corner:
               		box width  @  box height]).

	self addHeaders: hPane.

	self addOwnerDragListBox.

	"Open up the ToDoSettings object and retrieve the default settings."
    	settings := ToDoSettings new.
	settings settings.

	self addStatus.
	self addButtons.

	"Open a ToDoList and read contents into it."
	self openList.

	"Set up the undoItem"
	undoItem := Association new.

	HelpManager for: (self mainView) title: 'Help' file: 'todo\todo.hlp'.
    self openWindow.

	"Since we opened as a ToDoList (rather than settings) grey out the
	  inappropriate menu options."
	self menuSetup.

	"Open up the secondary window that sits on top of the list box and
	  allows direct changes to be made to the list."
	((itemList size) = 0)
		ifFalse:[	self openRow: (itemList at: 1)].!
   
openAsSettings

	| aView |
	
	aView := ToDoSettingsView new.
	aView parent: ((views at: 1) parent).
	aView open.	
	aView ctlView: self andSettings: settings.
	rowDisp hide.!
   
openList

	itemList := ToDoList new readList.
	(itemList size = 0)
		ifTrue:[ itemList add: (ToDoItem newItem).
					  statusField backColor: ClrRed;
					  contents: 'Could not find a ToDoList - default list created'.
					].!
  
openRow: aToDoItem

	rowDisp := ToDoRowDisplay new
		parent: (views at: 1).
	rowDisp initWindow.
	rowDisp openWindow: ((1000@1000) rightBottom: ( 1001@999)).
	rowDisp ctlWindow: self.	
	prevSelection := 1.

	rowDisp newItem: aToDoItem.

	self refreshButton: nil.!
  
pasteItem
		
	"This method eliminates the problem caused by the pop-up context menu
		which gets called from ToDoListView, and the menu structure, which
		comes from ToDoTopPane."

self pasteItem: (views at: 1) handle.!
   
pasteItem: aHandle

        "Paste the item from the clipboard"
		| clipMgr newItem itemString errMsg|

	self changedItem.
    CursorManager execute change.
	clipMgr := ClipboardManager new.
	itemString := clipMgr getString.
	clipMgr close.

	newItem := ToDoItem new.
	errMsg := newItem pdsAsItem: itemString.
	(errMsg isNil)
		ifFalse:[ statusField backColor: ClrRed;
						contents: errMsg.
						CursorManager normal change.
					    ^nil]
		
		"Call verifyItem. If an error is returned, print error."
		ifTrue:[errMsg := newItem verifyItem.
						(errMsg isNil)
							ifTrue:[self addUndoItem: newItem atValue: ''.
										  self undoToRedo. 
										  itemList add: newItem.
										  self refresh.										
										  statusField backColor: ClrYellow;
											contents: 'Item pasted from Clipboard'.
										]
							ifFalse:[statusField backColor: ClrRed;
											contents: errMsg.
										]
					].

    CursorManager normal change.!
  
printAllItems
		"Prints every item in the list."

		itemList do: [ :item | item printYourself].!
 
printItem

	(itemList at: (todoListBox selection)) printYourself.

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
   
redo
		"redo last change."
	|oldItem newItem |

	oldItem := undoItem key.
	newItem := undoItem value.
	oldItem = '' ifTrue: [ itemList addItem: newItem. ]
						ifFalse: [ (newItem = '') 
											ifTrue: [ itemList removeItem: (itemList indexOf: oldItem).
															prevSelection := 1.
															]
											ifFalse: [ itemList updateItem: oldItem 
																			at: (itemList indexOf: newItem)
															]
										].
	self refresh.
	self addUndoItem: newItem atValue: oldItem.
	self undoToRedo.
	^self.!

refresh

"1. check if current item has changed; if so write it out to itemList
  2. sort itemList
  3. check if itemList has finished its sort
  4. when finished, get itemList into todoListBox,
  5. that forces a refresh
  6. select an item (here we always select the first item after a sort)
  7. display the secondary window (rowDisp) over the selected item."

	self changedItem.
	itemList sortList: (settings sortKey) order: (settings sortOrder).

	todoListBox contents: itemList.
	todoListBox selection: 1.
	self displayItem.

	statusField backColor: ClrYellow;
		contents: 'List refreshed, sortkey: ' , settings sortKey,' sortOrder: ',settings sortOrder.

	"and then use country, codePage, includeCriterion etc"!
   
refreshButton: aButton

^self refresh.!
   
removeItem
	((itemList size) = 1)
		ifTrue:[ statusField backColor: ClrRed;
						contents: 'Cannot delete last Item in list'
						]
		ifFalse:[	self addUndoItem: '' atValue: (itemList at: (todoListBox selection)).
						self undoToRedo. 
						itemList remove: (itemList at: (todoListBox selection)).
		
						rowDisp newItem: (itemList at: 1).
						todoListBox contents: itemList.
						prevSelection := 1.
						todoListBox selection: 1.
						self aChoice: nil.

						statusField backColor: ClrYellow;
												contents: 'Item deleted'.
						].
	^self.!
  
removeItem: anItem
self halt.
itemList remove: anItem.

			undoItem itemCopy: (itemList at: (todoListBox selection)) action: 'remove'.
			self undoToRedo. 
		
			rowDisp newItem: (itemList at: 1).
			todoListBox contents: itemList.
			prevSelection := 1.
			todoListBox selection: 1.
			self aChoice: nil.

			statusField backColor: ClrYellow;
				contents: 'Item deleted'.!

rowDown

	((todoListBox selection) = (itemList size)) ifTrue: [ ^nil ].
	todoListBox selection: (todoListBox selection + 1).
	self aChoice: nil.!
   
rowUp

	((todoListBox selection) = 1) ifTrue: [ ^nil ].
	todoListBox selection: (todoListBox selection - 1).
	self aChoice: nil.!
   
saveButton: aButton

	| saveFileName |

	saveFileName := itemList writeList.

	statusField backColor: ClrYellow;
		contents: 'List saved!! - in file ', saveFileName!

setItemHeight
    "Set the proper height of the Ownerdraw listbox line"

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

settings

	^settings!
 
settings: aSetting

	settings := aSetting!

showRow

	rowDisp show!
   
sized
	"Our window is sized, so redisplay the child"
	| savedSel |

	(todoListBox selection notNil) ifTrue: [
		rowDisp hide.
		rowDisp show.
"
		savedSel := todoListBox selection.
		todoListBox selection: nil.
		todoListBox selection: savedSel.
		self aChoice: nil.	
"	]



"
	((todoListBox contents) notNil) ifTrue: [
		self calcRowPos: (todoListBox selection)].
"!
  
sortBy: aSortKey

	self changedItem.
	itemList sortList: (aSortKey) order: (settings sortOrder).
   
	rowDisp newItem: (itemList at: 1).
	prevSelection := 1.
	todoListBox contents: itemList.
	todoListBox selection: 1.

	statusField backColor: ClrYellow;
		contents: 'List updated, sortkey: ' , settings sortKey.

	^self displayItem.!
  
startDragLBox: aPane
        "Initiate a drag drop session."

    | dragList dragItems listName dragObject|


    "Build a list of items to export to the desktop."
	dragItems := OrderedCollection new.
    dragItems add: (itemList at: aPane selection). 
	dragList := dragItems
        collect: [ :item | 
            ( DragItem new ) 
                name: item description; 
                type: #( 'Unknown' ); 
                format: #( 'DRF_UNKNOWN' );
				userInfo: item;     "Store every item in userInfo"
                container: 'dummy'
        ].

    "Initiate a drag operation with the system."
    aPane dragDrop drag: dragList.!

tabToNextField
	"This method can be called if focus is on list window.
	We are not doing anything here at the moment."

	^nil!
  
topPaneClass

	"Private - set the default toppane class "

    ^ToDoTopPane!

undo
		"undo last change."
	|oldItem newItem |

	oldItem := undoItem key.
	newItem := undoItem value.
	oldItem = '' ifTrue: [ itemList addItem: newItem. ]
						ifFalse: [ (newItem = '') 
											ifTrue: [ itemList removeItem: (itemList indexOf: oldItem).
															prevSelection := 1.
															]
											ifFalse: [ itemList updateItem: oldItem 
																			at: (itemList indexOf: newItem)
															]
										].
	self refresh.
	self addUndoItem: newItem atValue: oldItem.
	(self menuTitled:'Edit') disableItem:'~Undo'. 
	(self menuTitled:'Edit') enableItem:'~Redo'.
	^self.!
   
undoToRedo

	(self menuTitled:'Edit') enableItem:'~Undo'. 
	(self menuTitled:'Edit') disableItem:'~Redo'.! !



!DragString methods !

renderingMechanism
        "Answer a string which describes the rendering
        mechanism implemented."
    ^'DRM_OS2FILE'!

sourceTransfer: item
        "Private - The source will render the item."
    | dragTransfer |
    dragTransfer := PMDragTransfer size: 1.
    dragTransfer
        cb: PMDragTransfer sizeInBytes;
        hwndClient: owner owner handle;
        pditem: item pmItem contents contents;
        selectedRMF: ( '<', self renderingMechanism, ',', item format first, '>' );
        renderToName: ( owner target, item pmItem targetName );
        ulTargetInfo: 0;
        usOperation: owner operation;
        fsReply: 0.

    ( dragTransfer sendMsg: DmRender to: item pmItem hwndItem with: 0 )
        ifTrue: [ ^nil ]
        ifFalse: [
            item pmItem 
                sendTransferMsg: DmEndconversation
                response: DmflTargetfail.
            owner freeTransferItem: item
        ]!
   
targetTransfer: item
        "Private - The target will perform the rendering
        operation without the direct involvement of the source."
    ( self transfer: item to: ( owner target, item name ) )
        ifTrue: [
            item pmItem
                sendTransferMsg: DmEndconversation
                response:  DmflTargetsuccessful.
        ]
        ifFalse: [
            item pmItem
                sendTransferMsg: DmEndconversation
                response:  DmflTargetfail.
        ].
    owner freeTransferItem: item!
  
transfer: item
        "Private - Begin the direct manipulation operation."
    | hstrSrc |
    hstrSrc := PMHandle fromBytes: item pmItem hstrSourceName.
    ( hstrSrc = NullHandle or: [ ( owner isNativeFormat: item ) not ] )
        ifTrue: [ self sourceTransfer: item ]
        ifFalse: [ self targetTransfer: item ]!
  
transfer: item to: dest
        "Private - Perform the actual operation and return true if successful."
    | src operation transItem |
    operation := owner operation.
    src := item pmItem containerName, item pmItem sourceName.
    ( src  = dest  )
        ifTrue: [ ^true ].
    ( ( operation = DoDefault ) or: [ operation = DoMove ] )
        ifTrue: [			
"            File copy: src to: dest.
            File remove: src
"        ].
    operation = DoCopy
        ifTrue: [
"            File copy: src to: dest.
"        ].
    ^true! !
