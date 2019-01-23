


!String methods !
 
leftOf:stringSize
        "comment"
    | index aStream aString  |
    index:=self size.
    aStream:= ReadWriteStream on:self.
    aStream nextPutAll:self.
    [ index <= stringSize]
        whileTrue:[ aStream nextPut: Space.
                           index:= index + 1].
    aString:= aStream copyFrom:1 to: stringSize.
    ^aString! !
