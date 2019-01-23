       Exercise 2 - solutions

        ToDoListView & ToDoTopPane class
      ( * This is the step by step instruction file ** )

"To install the two toppane class, evaluate the following with DoIt:"

  (File pathName: 'ex2\CUATopP.cls') fileIn; close.
  (File pathName: 'ex2\TDTopP1.cls') fileIn; close.

"Test the new toppane.  Evaluate the following expression
  with DoIt to open the window "

   ToDoTopPane new open

"To go on the exercises, install the following classes"

  (File pathName: 'ex2\TDlistV1.cls') fileIn; close.
  (File pathName: 'ex2\ToDoItem.cls') fileIn; close.
  (File pathName: 'ex2\ToDoPri.cls') fileIn; close.
  (File pathName: 'ex2\ToDoList.cls') fileIn; close.
  (File pathName: 'ex1\TDAbtDlg.cls') fileIn; close.
  (File pathName: 'ex2\ToDoApp1.cls') fileIn; close.

"Run the ToDoList Application.
  Evaluate the following expression:"

  ToDoListView new open

"In the following exercises, the sort function will be
  implemented."

"(1). Update the 'sortByType', 'sortByPriority',
        'sortByDescription' and 'sortByDeadline 
         in the ToDoTopPane class"

"To install the those methods, evaluate the following:"

  (File pathName: 'ex2\sortBy1.mth') fileIn; close.

"(2). Update the 'sortBy in the ToDoListView class"

"To install the method, evaluate the following:"

  (File pathName: 'ex2\sortBy2.mth') fileIn; close.

"In the following exercise, the 'Help' function will be
  implemented. To do that, the 'open' method must be
  updated."
"Add the following expression to the 'open' method.
 That must be put before the line of 'self openWindow' "

	HelpManager for: (self mainView) 
                           title: 'Help' 
                           file: 'todo.hlp' 
                           dialogs:#()
             aboutDlgClass: (ToDoAboutDialogBox initialize). 

"To install the completed classes, 
                  evaluate the following with DoIt:"

  (File pathName: 'ex2\TDTopP2.cls') fileIn; close.
  (File pathName: 'ex2\TDListV2.cls') fileIn; close.

"**************** END OF EXERECISES **************"

