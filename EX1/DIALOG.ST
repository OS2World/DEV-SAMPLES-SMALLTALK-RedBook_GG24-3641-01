
      Solutions to exercises on Dialogbox

      "To install the defined dialog boxes simply evaluate:"

        (File pathName: 'ex1\TDAbtDlg.cls') fileIn; close.

      "To install the predefined dialog boxes simply evaluate:"

       (File pathName: 'ex1\TestDlg.cls') fileIn; close.

      "To install the completed dialog boxes simply evaluate:"

       (File pathName: 'ex1\TestDlg2.cls') fileIn; close.


     "Be careful to initialize those class's variable before open it"
     "Evaluate the followings:"
 
       ToDoAboutDialogBox initialize.

       TestDialog initialize.

      "Open it as follows:"

       ToDoAboutDialogBox new open.

       TestDialog new open.

     "Press 'OK' button to close the dialog box."

     "******** END OF EXERCISES ***********"
      
