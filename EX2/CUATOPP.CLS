
TopPane subclass: #CUATopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'CharacterConstants PMConstants ' !


!CUATopPane class methods !
  
fileMenu
        "Private - Answer the File menu."
    ^Menu new
        appendItem: '~Open as ToDo List' selector: #openToDoList;
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
