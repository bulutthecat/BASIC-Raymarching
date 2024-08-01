DECLARE SUB SaveRawImage (filename$)

SCREEN 13  ' Set the graphics mode to 320x200 with 256 colors

' Draw some graphics to save (for demonstration)
FOR i = 0 TO 200
    LINE (0, i)-(320, i), i MOD 256
NEXT i

' Save the screen to a raw file
SaveRawImage "SCREEN.RAW"

' End of program
END

SUB SaveRawImage (filename$)
    CONST BufferSize = 1024  ' Size of the buffer to use for writing data
    DIM buffer AS STRING * BufferSize
    buffer = ""

    DEF SEG = &HA000   ' Set the segment address for video memory in SCREEN 13

    ' Open the file for binary output
    OPEN filename$ FOR BINARY AS #1

    ' Read the screen data and write in chunks
    FOR y = 0 TO 199
        FOR x = 0 TO 319
            buffer = buffer + CHR$(PEEK(x + y * 320))

            ' If the buffer is full, write it to the file and clear it
            IF LEN(buffer) = BufferSize THEN
                PUT #1, , buffer
                buffer = ""  ' Clear the buffer
            END IF
        NEXT x
    NEXT y

    ' Write any remaining data in the buffer
    IF LEN(buffer) > 0 THEN
        PUT #1, , buffer
    END IF

    ' Close the file
    CLOSE #1

    DEF SEG  ' Reset the default segment
END SUB
