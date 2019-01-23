
"Now, let's create an instance of 
 OrderedCollection:"


| myOC | 
myOC := OrderedCollection new.
   

"Method used to add objects is 'add:'.
 If objects to be added are strings, it can 
 be done as follows ( DoIt) : "


| myOC |
myOC := OrderedCollection new.
myOC add: 'Some text'.
myOC add: 'And still some more ...'.
myOC add: 'Now that is enough!'.
          


"To display the contents of your collection
 you can use 'inspect' like this ( DoIt ): "


| myOC |
myOC := OrderedCollection new.
myOC add: 'Some text'.
myOC add: 'And still some more ...'.
myOC add: 'Now that is enough!'.
myOC inspect.

"You can see that by default there are 12
 elements in the collection"

"To add something to the first indexposition
 'addFirst' method can be used ( use ShowIt ): "

 
| myOC |
myOC := OrderedCollection new.
myOC add: 'Some text'.
myOC add: 'And still some more ...'.
myOC add: 'Now that is enough!'.
myOC addFirst: 'I am the King!!!'.
myOC                                                                        


"Display the contents of the collection
 sorted alphabetically ( use ShowIt ):"


| myOC |
myOC := OrderedCollection new.
myOC add: 'Some text'.
myOC add: 'And still some more ...'.
myOC add: 'Now that is enough!'.
myOC addFirst: 'I am the King!!!'.
myOC asSortedCollection.                      

 
"Now let's add some integers ( ShowIt ):"


| myOC |
myOC := OrderedCollection new.
myOC add: 'Some text'.
myOC add: 'And still some more ...'.
myOC add: 'Now that is enough!'.
myOC addFirst: 'I am the King!!!'.
myOC add: 12345.
myOC asSortedCollection. 


"It seems that strings and integers cannot 
 be sorted by default. You can however define 
 a SortBlock that compares objects just
 the way that you like it. This is implemented
 in To-Do application"


"Now let's add some OrderedCollections to
 our collection ( use DoIt ):" 


| myOC |
myOC := OrderedCollection new.
myOC add: 'Some text'.
myOC add: OrderedCollection new.
myOC add: myOC.
myOC inspect.

 
"Here we add a string, a new collection
 and ourselves in our collection.
 When you get the first inspect-window,
 doubleclick the contents field so that
 you can really see the contents "


"*** END OF EXERCISE ***"

