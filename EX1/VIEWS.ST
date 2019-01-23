
      Solutions to exercises on ViewManager

      "The following expression ( evaluate with Do It ) results 
      in an empty window with a single choice in action bar ( 
      File -option ):"

        TopPane new open.

      "To find out where the action bar is defined, we 
      have to look at the 'open' method. When you find it in that class, 
      try to do it in the its superclass. It uses 'openWindow'
      method, which uses 'openIn' method and 'openIn' uses 
      the 'buildMenuBar' method.    

      In the last  method there is a line:"                                        
    

        menuWindow addMenu: self fileMenu owner: self.

      "The 'addMenu: owner:' method of MenuWindow is used to add 
      menus to the action bar. The method where the menu is 
      defined in this case is 'fileMenu', which in turn calls 
      'fileMenu' class method. If you select the 'class' 
      radiobutton in Class Hierarchy Browser, you can see the 
      final 'fileMenu' method."

      
      "New subclasses a created by first selecting the parent 
      class in Class Hierarchy Browser and then selecting 'Add 
      Subclass...' option in 'Classes' pulldown. "

      "Create a subclass  of ViewManager (call it 'TestView').
      Don't change  the default 'Indexed' and 'Contains' values!            
      Before saving (Alt s) the class definition add a variable called   
      PMConstants  to the poolDictionaries.                         
     You can use  this new class the same way that  you use any other   
      class. A new instance is created like this ( with a variable assigned 
      to it ):"                                           

      "Check the TestView class is defined before DoIt !!! "

        | myView |
        myView := TestView new open.

      "Did you find any error? Does the 'TestView' class have the 'open'       
        method? How about its superclass?
       So you need to add the 'open' method
       to make an instance of the 'TestView' class. "
      "The  'open' method should look something like 
      this:"

        open
        
            self
                owner: self;
                label: 'My Window'.
            self openWindow

      "You can also install  'open1.mth' file. 
      or 'open2.mth' file."
      "To install the those methods simply evaluate:"

        (File pathName: 'ex1\open1.mth') fileIn; close.

       "or"
 
       (File pathName: 'ex1\open2.mth') fileIn; close.

      "The result is just the same as in previous exercise, 
      because your new class 'TestView' opens the window by using
      the 'TopPane' class by default!"

      "Let's install your own menu in the window."
      "The new 'myMenu' method should look like this:"

        myMenu
                "Our own menu"
            ^Menu new
                appendItem: '~My Choice' selector: #myMenuMethod ;
              title: '~My Menu'

      "You can also install  'mymenu.mth' file."

      "The modified 'open' method should look something like 
      this:"

        open
        
            self
                owner: self;
                label: 'My Window'.
            self openWindow
        
            menuWindow addMenu: self myMenu owner: self.

      "You can also evaluate the following to redefine this 
      method without having to write the text above:"

        (File pathName: 'ex1\openmenu.mth') fileIn; close.       
        

      "To install the 'myMenuMethod' method simply evaluate:"

        (File pathName: 'ex1\mymnmthd.mth') fileIn; close.

      "****** END OF EXERCISE ******"
      


