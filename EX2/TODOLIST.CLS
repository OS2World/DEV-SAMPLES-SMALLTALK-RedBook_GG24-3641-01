
OrderedCollection subclass: #ToDoList
  instanceVariableNames: 
    'sortKey '
  classVariableNames: ''
  poolDictionaries: ''    !


!ToDoList class methods !

template
"12/12 update"
        "Give a template"
    | tempItem tmpList|
      tempItem:= ToDoItem new.
   				tempItem type: 'Personal'.
				tempItem deadline: '99.12.31'.
				tempItem description: 'Celebrate!!'.
				"tempItem priority: 'High'."
				tempItem priority: 1.
				tempItem completed: false.
		tmpList:=OrderedCollection new.
		tmpList add: tempItem .
 ^(self replaceFrom:1 to:(self size) with: tmpList)! !



!ToDoList methods !
 
addItem: anItem

    "Add the item to the list.  "

    self add: anItem .
    self sortList. 
     ^self.!
   
readList

    "Read the ToDo list from disk.
     The list is stored as a binary data using the 
     ObjectFiler. so a new collection
    can be built by loading the contents of the file 
     by using the ObjectFiler.
     This method is used in two places:
    - when ToDo application window is opened.
    - when Open is selected in File-pulldown. "

    | input tmpList testItem |

	input := Disk file: 'TODOFILE.OBJ'.
	input close.
    input := Disk file: 'TODOFILE.OBJ'.
    ((input contents) = '') ifTrue: [			
				tmpList := OrderedCollection new.
				testItem := ToDoItem new.
				testItem type: 'Personal'.
				testItem deadline: '99.12.31'.
				testItem description: 'Celebrate!!'.
				"testItem priority: 'High'."
                testItem priority: 1.
				testItem completed: false.
				5 timesRepeat: [ tmpList add: testItem ].	
	]
	ifFalse: [
		tmpList := ObjectFiler loadFromPathName: 'TODOFILE.OBJ'.
	].
    input close.

 ^(self replaceFrom:1 to:(self size) with: tmpList)!
 
removeAll
      " Remove the contents of the ToDoList"

       ^( super removeAll: self ) .!
 
removeItem:anItemIndex

    "Remove an item.  "

     super removeIndex: anItemIndex .

    ^self.!
   
sortList

    "Resort the list of items and return the list. "

      | tempList returnList |

      ( sortKey isNil ) 
                ifTrue: [ sortKey := 'priority'].

      ( self size  > 0 )
             ifTrue: [ tempList := self asSortedCollection:
                                    [ :a :b | a compareTo: b using: sortKey ] .
                          self replaceFrom:1 to: (self size) with: tempList.
                            ].
      ^ self.!

sortList: aSortKey

    "Update the sortKey "

        sortKey := aSortKey .
        ^ self.!
  
updateItem:anItem at:anIndex

    "Change an item in the list.  "

    self at: anIndex  put: anItem .
    self sortList.
    ^self.!
 
writeList
    "Write the ToDo list on disk. "

	ObjectFiler dump: self newFile: 'TODOFILE.OBJ'.! !
