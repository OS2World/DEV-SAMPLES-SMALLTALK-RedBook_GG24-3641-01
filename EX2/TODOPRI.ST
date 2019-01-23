       Exercise 2 - solutions

        ToDoPriorityList ( * This is the step by step instruction file ** )

        In Class Hierarchy Browser select  the class 'Dictionary' and
        select 'Add Subclass' in  'Classes' menu.
       Write the name of the class (ToDoPriorityList)  in the entry field. 
       This class does not have its instance variable.

        This class gives the associations between the priority and the
        assigned values. For example,
              
                    number          priority
                         1                'High'
                         2                'Med'
                         3                'Low'


        A method is required to set as above.
        To install the 'init' method, evaluate with Do It:

          (File pathName: 'ex2\init.mth') fileIn; close.


        This 'init' is a class method. So it is used like the following
        experessions. Evaluate with ShowIt:

       | toDoPriorityList |
         toDoPriorityList := ToDoPriorityList new class init.
         toDoPriorityList keyAtValue: 1.

        To install 'ToDoPriorityList' class, evaluate with Do It:

          (File pathName: 'ex2\todoPri.cls') fileIn; close.



          ****** END OF EXERCISE ****** 


