"In the following exercises all expressions
 should be evaluated with ShowIt after
 selecting the text to be executed"


"A new instance of Dictionary is created
 by evaluating the following expression
 with DoIt or ShowIt"


Dictionary new.                      


"If an instance variable is to be assigned
 to this new object, it can be done by
 evaluating the following expression:"


| myDict |
myDict := Dictionary new.



"To insert key/value pairs we can use
 'at: put: method"



| myDict |
myDict := Dictionary new.
myDict at: 'James Bond' put: 007.
myDict at: 'Mr Devil' put: 666.
myDict at: 'Maggie' put: 10.
myDict at: 'Myself' put: 552936.
                                                                           


"If you want to query the values inserted,
 'at:' method can be used as follows:
 ( evaluate with ShowIt )"



| myDict |
myDict := Dictionary new.
myDict at: 'James Bond' put: 007.
myDict at: 'Mr Devil' put: 666.
myDict at: 'Maggie' put: 10.
myDict at: 'Myself' put: 552936.
"now let's query something"
myDict at: 'Maggie'.                        


"To query the value of the key 'keyAtValue'-
 method can be used:"

| myDict |
myDict := Dictionary new.
myDict at: 'James Bond' put: 007.
myDict at: 'Mr Devil' put: 666.
myDict at: 'Maggie' put: 10.
myDict at: 'Myself' put: 552936.
"now let's query something"
myDict keyAtValue: 007.     

"Now let's remove some value/key pair
 using 'removeKey:' method "


| myDict |
myDict := Dictionary new.
myDict at: 'James Bond' put: 007.
myDict at: 'Mr Devil' put: 666.
myDict at: 'Maggie' put: 10.
myDict at: 'Myself' put: 552936.
myDict removeKey: 'James Bond'.
myDict keyAtValue: 007.                                              


"To change a value associated with
 a key simply overwrite the old one"


| myDict |
myDict := Dictionary new.
myDict at: 'James Bond' put: 007.
myDict at: 'Mr Devil' put: 666.
myDict at: 'Maggie' put: 10.
myDict at: 'Myself' put: 552936.
"now let's replace something"
myDict at: 'Maggie' put: 11.
myDict at: 'Maggie'.



" Activate the Smalltalk inspector to display
the contents of the collection (Evaluate    
with DoIt)."

| myDict |
myDict := Dictionary new.
myDict at: 'James Bond' put: 007.
myDict at: 'Mr Devil' put: 666.
myDict at: 'Maggie' put: 10.
myDict at: 'Myself' put: 552936.     
myDict inspect.


