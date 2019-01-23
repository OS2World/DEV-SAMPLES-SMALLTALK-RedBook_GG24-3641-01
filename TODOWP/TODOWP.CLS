
TopPane subclass: #TrashTopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '  !
TopPane subclass: #PrinterTopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '   !
ViewManager subclass: #ToDoPrinter
  instanceVariableNames: 
    'ctlWindow prtField '
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants ' !
ViewManager subclass: #ToDoTrash
  instanceVariableNames: 
    'trashField ctlWindow '
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants ' !
Object subclass: #ToDoWP
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: ''  !


!TrashTopPane class methods ! !



!PrinterTopPane class methods ! !



!ToDoPrinter class methods ! !



!ToDoTrash class methods ! !



!ToDoWP class methods ! !



!TrashTopPane methods !
   
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
        idResources: 260
        phwndClient: (self asParameter)).
    handle = NullHandle ifTrue: [^nil].
    parent parent: parentWindow.
    parent child: self.
    handle containedIn: self.! !



!PrinterTopPane methods !
  
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
        idResources: 261
        phwndClient: (self asParameter)).
    handle = NullHandle ifTrue: [^nil].
    parent parent: parentWindow.
    parent child: self.
    handle containedIn: self.! !



!ToDoPrinter methods !
 
addPrt

| dragProtocol |

	    self addSubpane: ( (prtField := GraphPane new)
        owner: self;
		style: FcfNobytealign;
        when: #dropComplete perform: #dropComplete:;

        framingRatio:( (0@0)
			extent: (1@1))).

    dragProtocol := DragDrop for: prtField.
    dragProtocol 
        container: 'dummy';
        mechanisms: ( Array with: DragString new ).

    prtField dragDrop: dragProtocol.

	self mainView dragDrop: dragProtocol.!

ctlWindow: aWin

	ctlWindow := aWin!
  
dropComplete: aPane

	ctlWindow printItem.!
   
initWindowSize
        "Private - Answer the initial size of the receiver."

	^(Display width * 1//20) @ (Display height * 1// 10)!
  
open

	self labelWithoutPrefix: 'Things To-Do Printer';
		owner: self.
	self addPrt.
	self openWindow.!

topPaneClass

	"Private - set the default toppane class "

    ^PrinterTopPane! !



!ToDoTrash methods !
   
addTrash

| dragProtocol |

	    self addSubpane: ( (trashField := GraphPane new)
        owner: self;
		style: FcfNobytealign;
        when: #dropComplete perform: #dropComplete:;

        framingRatio:( (0@0)
			extent: (1@1))).

    dragProtocol := DragDrop for: trashField.
    dragProtocol 
        container: 'dummy';
        mechanisms: ( Array with: DragString new ).

    trashField dragDrop: dragProtocol.

	self mainView dragDrop: dragProtocol.!

ctlWindow: aWin

	ctlWindow := aWin!
  
dropComplete: aPane

	ctlWindow removeItem.

" if you want to print the item , do this: 

    aPane dragDrop items do: [ :item | item printYourself ].

"!
  
initWindowSize
        "Private - Answer the initial size of the receiver."

	^(Display width * 1//20) @ (Display height * 1// 10)!
  
open

	self labelWithoutPrefix: 'Things To-Do Trash';
		owner: self.
	self addTrash.
	self openWindow.!

topPaneClass

	"Private - set the default toppane class "

    ^TrashTopPane! !



!ToDoWP methods !

open

| top win|

top := TextWindow windowLabeled: ' '
	frame: (Display boundingBox).

top labelWithoutPrefix:'Things To-Do Workplace - Contents View'.
top := top pane.

	(win := ToDoListView new )
		parent: top;
		open.

	(ToDoTrash new 
		parent: top;
		open) ctlWindow: win.

	(ToDoPrinter new 
		parent: top;
		open) ctlWindow: win.! !
