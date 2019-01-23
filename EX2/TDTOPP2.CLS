
CUATopPane subclass: #ToDoTopPane
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '    !


!ToDoTopPane class methods ! !



!ToDoTopPane methods !
 
addItem

	^owner addItem!
 
buildMenuBar
        "Private - Build menu bar."
	| eachMenu |
	super buildMenuBar.
     (eachMenu := menuWindow menuTitled: '~View') notNil
            ifTrue: [eachMenu disableItem: #list.
                        eachMenu  disableItem: #include.
                        eachMenu  disableItem: #openAsSettings.].
     (eachMenu := menuWindow menuTitled: '~Edit') notNil
            ifTrue: [eachMenu  disableItem: #unDo. 
                        eachMenu  disableItem: #reDo.
                        eachMenu  disableItem: #copyItem.
                        eachMenu  disableItem: #createItem.  
                        eachMenu  disableItem: #pasteItem.  ].
     (eachMenu := menuWindow menuTitled: '~ThingsToDo') notNil
            ifTrue: [eachMenu  disableItem: #openAsSettings.].
    self event: #menuBuilt!
   
clearAll

	^owner clearAll!
   
copyItem
  "Nothing here"
	^nil!
  
createItem
  "Nothing here"
	^nil!

editMenu
        "Private - Answer the SortBy... menu."
    ^Menu new

        appendItem: '~Undo' selector: #unDo;
        appendItem: '~Redo' selector: #reDo;
		appendSeparator;
        appendItem: '~Copy' selector: #copyItem;
        appendItem: 'Cr~eate' selector: #createItem ;
        appendItem: '~Paste' selector: #pasteItem ;
		appendSeparator;
        appendItem: '~New item' selector: #addItem;
        appendItem: '~Delete item' selector: #removeItem ;
		appendSeparator;
        appendItem: 'C~lear all' selector: #clearAll;
        title: '~Edit';
        owner: self.!
 
include

	^nil!
   
list
  "Nothing here"
	^nil!
  
openAsSettings

	^nil!

openToDoList

  owner openToDoList.!
  
pasteItem
  "Nothing here"
	^nil!
 
print
		"Ask the owner (ToDoListView) to print the currently selected
		 item."

		owner printItem.!

printAll
		"Ask the owner (ToDoListView) to print all the items in the list."

		owner printAllItems.!
   
reDo
  "Nothing here"
	^nil!
  
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
  
unDo
  "Nothing here"
	^nil!
  
viewMenu
        "Private - Answer the SortBy... menu."
    ^Menu new

        appendItem: '~List' selector: #list;
        appendItem: '~Settings' selector: #openAsSettings ;
		appendSeparator;
        appendSubMenu: (self sortByMenu owner: self) ;
        appendItem: '~Include ...' selector: #include ;
		appendSeparator;
        appendItem:  '~Refresh now' selector: #refresh ;
        title: '~View';
        owner: self.! !
