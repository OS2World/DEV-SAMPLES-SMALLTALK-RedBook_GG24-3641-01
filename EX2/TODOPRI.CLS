
Dictionary subclass: #ToDoPriorityList
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: 
    'PMConstants '   !


!ToDoPriorityList class methods !

init
    "Create a Dictionary containing all allowed priorities.
     An instance of this class is created in ToDoItem ."

    | pDict |
     pDict:= Dictionary new.

     pDict at: 'Low' put: 3.
     pDict at: 'Med' put: 2.
     pDict at: 'High' put: 1.

    ^pDict.! !



!ToDoPriorityList methods ! !
