       Exercise 2 - solutions

        ToDoItem ( * This is the step by step instruction file ** )

       "In Class Hierarchy Browser select the class 'Object' 
       and select 'Add Subclass' in  'Classes' menu.
       Write the name of the class (ToDoItem) 
       in the entry field. In the input are, 
       insert four  instance variable names to this new class.
       The variable names are: type, description, 
       deadline ,priority and completed."

       " You should add two methods for every instance variable 
        in ToDoItem: one for setting the value and one for 
        returning the value to the caller. If value is returned, 
        method looks very simple:"

       " To install the following method, evaluate with Do It:"

          (File pathName: 'ex2\typeset.mth') fileIn; close.


          type
               "this method returns the value of 'type'
                instance variable"
               ^type

        "In this case, the method name is same as variable name
        ( it can be something else as well ). The method to set 
        the value of 'type' variable looks like this:"

          type: aType
               "this method sets the value of 'type'
                instance variable to a value passed
                as a parameter ( aType)"
               type := aType.

        "To set values you have to create an instance of the 
        class and assign a variable to it. By using this 
        variable and methods available in ToDoItem  you can 
        modify the instance variables. To set values :"

          |item| 
          item := ToDoItem new.  
          item type: 'Meeting'.  
          item description: 'Output'.  
          item deadline: '91.12.20'.  
          item priority: 'High'.
          item completed: 'false'.
          item type.                                             

        "If you evaluate the previous expressions with show it, 
        you can also see that the last line of code return the 
        value of 'type' variable."

       "The following example creates an ordered collection and 
        two instances of ToDoItem. After setting type-variables 
        these instances are added in collection:"

          |myOC item1 item2| 
          item1 := ToDoItem new.  
          item2 := ToDoItem new.  
          item1 type: 'type1'.  
          item2 type: 'type2'.  
          myOC := OrderedCollection new.  
          myOC add: item1;
                  add: item2. 
          myOC  inspect.                                     

          "In this example values of instance variables are 
          changed after adding ToDoItem instances in collection. 
          The values contained in collection are also changed:"

            |myOC item1 item2|
            item1 := ToDoItem new.
            item2 := ToDoItem new.
            item1 type: 'type1'.
            item2 type: 'type2'.
            myOC := OrderedCollection new.
            myOC add: item1;
                    add: item2.
            item1 type: 'Newtype'.
            myOC  inspect.                                                                   

          "The simplest way of creating a string ( without any 
          formatting ) is to create a method, that creates an 
          empty string and adds all the instance variables to 
          that string. The method can be implemented as follows:"

              
            getItemText
                     | answer |
            
                     answer := WriteStream on: (String new: 120).                          
                     answer  nextPutAll: (type);
                        nextPutAll: '  ';
                        nextPutAll: (description);
                        nextPutAll: '  ';
                        nextPutAll: (deadline);
                        nextPutAll: '  ';
                        nextPutAll: (priority).
                     ^answer contents.                 

        "A method is required to compare two items using a key 
        and return a Boolean result. 
        This method is used ,for example,
         in the following expressions: Evaluate with ShowIt:"


          | tItem1 tItem2 |
          tItem1 := ToDoItem new.
          tItem2 := ToDoItem new.
          tItem1 type:'f'.
          tItem2 type:'z'.
          tItem1 compareTo: tItem2 using:'type'.

       "To install this method,
        you can evaluate the following fiexpression:"
          
         (File pathName: 'ex2\compTo.mth') fileIn; close.


        "To file in all the required methods evaluate with Do It:"

          (File pathName: 'ex2\todoitem.cls') fileIn; close.

        "*** IMPORTANT NOTE ***
         A method in the ToDoItem accesses to 
         the ToDoPriorityList class. 
         If the ToDoPriorityList class dose NOT exist
         in your system, an error occurs at the installation
         process. A dialogbox tells you like this:
                 'Define ToDoPriorityList as Global ?'
         Click 'No' .
         In the next exercises, the ToDoPriorityList class
         will be installed in your system. After that,
         try to install the ToDoItem class.

         When you click 'Yes', the ToDoPriorityList will be
         defined as Global variable. When you install the
         the ToDoPriorityList class, you must remove that
         Global variable from the Small Dictionary.
         To do that, enter the following expression in the
          TranscriptWindow or the WorkspaceWindow.
               'Smalltalk inspect'
          Remove the ToDoPriorityList variable from it.

           ***** END OF NOTE ************" 

          ****** END OF EXERCISE ****** 







