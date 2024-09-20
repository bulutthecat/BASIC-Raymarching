' Copyright (C) 2024 Kevin Dalli 

' this program has a bug, where the hex data of the entire image is just 0x00

DECLARE SUB SaveRawImage (filename$)

SCREEN 13

FOR i = 0 TO 200
    LINE (0, i)-(320, i), i MOD 256
NEXT i

SaveRawImage "SCREEN.RAW"
END

SUB SaveRawImage (filename$)
    CONST BufferSize = 1024 ' buffer size
    DIM buffer AS STRING * BufferSize
    buffer = ""

    DEF SEG = &HA000   
    OPEN filename$ FOR BINARY AS #1

    ' read the screen data
    FOR y = 0 TO 199
        FOR x = 0 TO 319
            buffer = buffer + CHR$(PEEK(x + y * 320))
            IF LEN(buffer) = BufferSize THEN
                PUT #1, , buffer
                buffer = ""
            END IF
        NEXT x
    NEXT y

    ' write final data into buffer
    IF LEN(buffer) > 0 THEN
        PUT #1, , buffer
    END IF
    CLOSE #1
    DEF SEG
END SUB
