DECLARE SUB ReadCubesFromFile (filename AS STRING, numCubes AS INTEGER)

CONST MAXCUBES = 10
DIM numCubes AS INTEGER

DIM readline AS STRING
DIM fileHandle AS INTEGER
DIM cubeLocX AS INTEGER, cubeLocY AS INTEGER, cubeLocZ AS INTEGER
DIM cubeRotX AS SINGLE, cubeRotY AS SINGLE, cubeRotZ AS SINGLE
DIM cubeSclX AS SINGLE, cubeSclY AS SINGLE, cubeSclZ AS SINGLE

' Check for command line arguments
filename$ = COMMAND$

IF LEFT$(filename$, 2) = "/F" THEN
    filename$ = MID$(filename$, 4)
ELSE
    PRINT "No file specified with /f flag."
    END
END IF

CALL ReadCubesFromFile(filename$, numCubes)

PRINT "Number of cubes read: "; numCubes
PRINT "Cube Details:"

IF numCubes > 0 THEN
    FOR i = 1 TO numCubes
        PRINT "Cube "; i; ":"
        PRINT "  Location: ("; cubeLocX; ", "; cubeLocY; ", "; cubeLocZ; ")"
        PRINT "  Rotation: ("; cubeRotX; ", "; cubeRotY; ", "; cubeRotZ; ")"
        PRINT "  Scale: ("; cubeSclX; ", "; cubeSclY; ", "; cubeSclZ; ")"
    NEXT i
END IF

SUB ReadCubesFromFile (filename AS STRING, numCubes AS INTEGER)
    DIM readline AS STRING
    DIM fileFields(8) AS STRING
    DIM fileHandle AS INTEGER
    DIM cubeLocX AS INTEGER, cubeLocY AS INTEGER, cubeLocZ AS INTEGER
    DIM cubeRotX AS SINGLE, cubeRotY AS SINGLE, cubeRotZ AS SINGLE
    DIM cubeSclX AS SINGLE, cubeSclY AS SINGLE, cubeSclZ AS SINGLE
    DIM startPos AS INTEGER, endPos AS INTEGER, fieldNum AS INTEGER
    DIM testfield AS STRING

    fileHandle = FREEFILE
    OPEN filename FOR INPUT AS #fileHandle
    numCubes = 0

    DO WHILE NOT EOF(fileHandle)
        LINE INPUT #fileHandle, readline
        
        startPos = 1
        fieldNum = 0
        
        ' Parsing the line for CSV fields
        DO
            endPos = INSTR(startPos, readline, ",")
            IF endPos = 0 THEN
                endPos = LEN(readline) + 1  ' Handle the last field
            END IF
            
            testfield = MID$(readline, startPos, endPos - startPos)
            
            SELECT CASE fieldNum
                CASE 0
                    cubeLocX = VAL(testfield)
                CASE 1
                    cubeLocY = VAL(testfield)
                CASE 2
                    cubeLocZ = VAL(testfield)
                CASE 3
                    cubeRotX = VAL(testfield)
                CASE 4
                    cubeRotY = VAL(testfield)
                CASE 5
                    cubeRotZ = VAL(testfield)
                CASE 6
                    cubeSclX = VAL(testfield)
                CASE 7
                    cubeSclY = VAL(testfield)
                CASE 8
                    cubeSclZ = VAL(testfield)
            END SELECT

            IF endPos > LEN(readline) THEN EXIT DO
            startPos = endPos + 1
            fieldNum = fieldNum + 1
        LOOP WHILE startPos <= LEN(readline)

        IF fieldNum = 8 THEN  ' Make sure we have exactly 9 fields (0-8)
            numCubes = numCubes + 1

            ' Debugging prints
            PRINT "Cube "; numCubes; ":"
            PRINT "  Location: ("; cubeLocX; ", "; cubeLocY; ", "; cubeLocZ; ")"
            PRINT "  Rotation: ("; cubeRotX; ", "; cubeRotY; ", "; cubeRotZ; ")"
            PRINT "  Scale: ("; cubeSclX; ", "; cubeSclY; ", "; cubeSclZ; ")"
        END IF
    LOOP

    CLOSE #fileHandle
END SUB

