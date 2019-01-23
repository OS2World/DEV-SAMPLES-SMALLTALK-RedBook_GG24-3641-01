       Exercise 2 - solutions

        ToDoList ( * This is the step by step instruction file ** )

       " In Class Hierarchy Browser select  
        the class 'OrderedCollection' and
        select 'Add Subclass' in  'Classes' menu.
        Write the name of the class (ToDoList)  in the entry field. 
        In the input are, insert one  instance variable names to
        this new class. The variable name is sortKey."

       " You should create a method to add the To-Do item.
        Name it 'addItem:'. The 'addItem' method has a parameter,
        that is an item to be add."

        "To install the following method, evaluate with Do It:"

          (File pathName: 'ex2\addItem.mth') fileIn; close.


     "This is a test case for the addItem:anItem method 
      of ToDoList class"

      | tmpList tmpItem|
        tmpItem:= ToDoItem new.
        tmpItem type:'personal';
              deadline:'99.12.31';
              description:'something';
              priority:1;
              completed: false .
       tmpList:= ToDoList new.
       tmpList addItem:tmpItem.
       tmpList inspect.


    "This is a test case for saving and loading the object
     using the ObjectFiler"

      "Save the To-Do List object
       Evaluate these expressions with DoIt
       After doing this, a dialog box comes out.
       You can select the name of file to save the object
       using the dialog box"

   | tmpList tmpItem|
       tmpItem:= ToDoItem new.
       tmpItem type:'personal';
              deadline:'99.12.31';
              description:'something';
              priority: 1;
              completed: false .
       tmpList:= ToDoList new.
       tmpList addItem:tmpItem.
       ObjectFiler dump: tmpList.

      "Load the To-Do List object.
       Evaluate these expressions with DoIt
       After doing this, a dialog box comes out.
       You can select the name of file to load the object
       using the dialog box"
   
           (ObjectFiler load) inspect.

      "Next is to load the object to the To-Do List object."

      | tmpList|
          tmpList := ObjectFiler load  .
          tmpList inspect.

       "If you know where the file is, 
        for example 'FILEDOBJ.OBJ',
        you can do as follows.
        In this case, a dislog box doesn't come out"

       | tmpList|
        tmpList := ObjectFiler 
           loadFromPathName:'C:\STVPM13\EX2\FILEDOBJ.OBJ'.
        tmpList inspect.

   "To install the readList method, 
    evaluate the following with DoIt:"

    (File pathName: 'ex2\readList.mth') fileIn; close.

   "To install the writeLst method, 
     evaluate the following with DoIt:"

    (File pathName: 'ex2\writeLst.mth') fileIn; close.

   "This is a test case for the sortList method 
    of ToDoList class"

   | tmpList tmpItem1 tmpItem2|
      tmpItem1:= ToDoItem new.
      tmpItem2:= ToDoItem new.
      tmpItem1 type:'personal';
              deadline:'99.12.31';
              description:'something';
              priority: 2;
              completed: false .
      tmpItem2 type:'meeting';
              deadline:'91.12.31';
              description:'something';
              priority: 1;
              completed: false .
     tmpList:= ToDoList new.
     tmpList addItem:tmpItem1.
     tmpList addItem:tmpItem2.
     tmpList sortList:'type'.
     tmpList sortList;
                inspect.

   "To install the ToDoList class, 
     evaluate the following with DoIt:"

    (File pathName: 'ex2\todolist.cls') fileIn; close.

"************ end of exercises ***********************"
  