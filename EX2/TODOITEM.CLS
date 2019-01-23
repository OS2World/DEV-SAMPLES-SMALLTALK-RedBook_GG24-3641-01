
Object subclass: #ToDoItem
  instanceVariableNames: 
    'type description priority deadline completed '
  classVariableNames: ''
  poolDictionaries: 
    'CharacterConstants ' !


!ToDoItem class methods !

new
	
	^super new! !



!ToDoItem methods !
   
asParameter

	^(' ' asAsciiZ)!

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
  
completed
    "returns the value of completed"

    ^completed!
  
completed: aValue
    "Sets the value of completed"

    completed := aValue.!
   
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
 
getItemText
   "*********** Added 12/9 ochiai ************"
        "Return a string containing all the fields
         of a ToDoItem ( type, decription, deadline and priority).
         Priority value is replaced by corresponding value in
         ToDoPriorityList dictionary. A new instance of this
         dictionary is created before using it."

         | answer 	  compStr |

        "Here a new string is initialised and accessed as a stream
         so that nextPutAll can be used. This is similar to writing
         to a file."

        answer := WriteStream on: (String new: 120).

        "The string is filled with the instance variables' values.
         The leftOf: method is an addition to String class. We should
         not really have hardcoded numbers here, they are dependant on
         the text limits set in ToDoAddDialogBox and in textHeader."

	compStr := ''.
	(completed = true)  ifTrue: [ compStr := 'Done' ].
	(completed = false) ifTrue: [ compStr := '        ' ].

        answer   nextPutAll: ((self deadline) leftOf:8);
            nextPutAll: '  ';
            nextPutAll: ((self type) leftOf: 8);
            nextPutAll: '  ';
            nextPutAll: ((self description) leftOf: 30);
            nextPutAll: '  '; 
            nextPutAll: (((ToDoPriorityList new class init) keyAtValue:  priority) leftOf: 4); 
           " nextPutAll: ((self priority) leftOf: 4); "
            nextPutAll: '  '; 
            nextPutAll: ( compStr).


"The contents of the string are returned."

^answer contents!

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
    "sets the value of priority"

    priority := aPriority!
 
template
        "Give a template"

   				self type: 'Personal'.
				self deadline: '99.12.31'.
				self description: 'Celebrate!!'.
				self priority: 'High'.
				self completed: false.!
 
type
    "returns the value of type"
    ^type!
   
type: aType
    "sets the value of type"
    type := aType.! !
