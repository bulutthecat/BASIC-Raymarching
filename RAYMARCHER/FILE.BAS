DECLARE SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE, rotX AS SINGLE, rotY AS SINGLE, rotZ AS SINGLE)
DECLARE SUB ReadCubesFromFile (filename AS STRING, cubes() AS SINGLE, edges() AS INTEGER, numCubes AS INTEGER)

' Copyright (C) Kevin Dalli 2024

'OPEN "A:\\RAYMARCHER\\BUILD\\EXAMPLE.CSV" FOR INPUT AS #1
'LINE INPUT #1, header$
'DO WHILE NOT EOF(1)
'    LINE INPUT #1, line$
'    ' Parse the CSV line
'    x = VAL(PARSE$(line$, 1))
'    y = VAL(PARSE$(line$, 2))
'    z = VAL(PARSE$(line$, 3))
'    rotx = VAL(PARSE$(line$, 4))
'    roty = VAL(PARSE$(line$, 5))
'    rotz = VAL(PARSE$(line$, 6))
'    height = VAL(PARSE$(line$, 7))
'    length = VAL(PARSE$(line$, 8))
'    width = VAL(PARSE$(line$, 9))
'    ' Call your rendering function here with the parsed values
'    ' RenderCube x, y, z, rot_x, rot_y, rot_z, height, length, width
'    PRINT "Cube at "; x; ", "; y; ", "; z; " with rotation "; rotx; ", "; roty; ", "; rotz; " and dimensions "; height; ", "; length; ", "; width
'LOOP
'CLOSE #1
'
'' Function to parse CSV line
'FUNCTION PARSE$(line$, index)
'    ' Split the line by commas and return the index-th element
'    DIM parts$(9)
'    count = 0
'    FOR i = 1 TO LEN(line$)
'        char$ = MID$(line$, i, 1)
'        IF char$ = "," THEN
'            count = count + 1
'        ELSE
'            parts$(count) = parts$(count) + char$
'        END IF
'    NEXT i
'    PARSE$ = parts$(index)
'END FUNCTION

SUB ReadCubesFromFile (filename AS STRING, cubes() AS SINGLE, edges() AS INTEGER, numCubes AS INTEGER)
    DIM readline AS STRING
    DIM fileHandle AS INTEGER
    DIM cubeLocX AS INTEGER, cubeLocY AS INTEGER, cubeLocZ AS INTEGER
    DIM cubeRotX AS SINGLE, cubeRotY AS SINGLE, cubeRotZ AS SINGLE
    DIM cubeSclX AS SINGLE, cubeSclY AS SINGLE, cubeSclZ AS SINGLE
    DIM startPos AS INTEGER, endPos AS INTEGER, fieldNum AS INTEGER
    DIM rfield AS STRING
    DIM RtempCube(8, 3) AS SINGLE ' avoid redefenition

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
           
            rfield = MID$(readline, startPos, endPos - startPos)
           
            SELECT CASE fieldNum
                CASE 0
                    cubeLocX = VAL(rfield)
                CASE 1
                    cubeLocY = VAL(rfield)
                CASE 2
                    cubeLocZ = VAL(rfield)
                CASE 3
                    cubeRotX = VAL(rfield)
                CASE 4
                    cubeRotY = VAL(rfield)
                CASE 5
                    cubeRotZ = VAL(rfield)
                CASE 6
                    cubeSclX = VAL(rfield)
                CASE 7
                    cubeSclY = VAL(rfield)
                CASE 8
                    cubeSclZ = VAL(rfield)
            END SELECT

            IF endPos > LEN(readline) THEN EXIT DO
            startPos = endPos + 1
            fieldNum = fieldNum + 1
        LOOP WHILE startPos <= LEN(readline)

        IF fieldNum = 8 THEN  ' Make sure we have exactly 9 fields (0-8)
            numCubes = numCubes + 1
            CALL GenCube(RtempCube(), edges(), cubeLocX, cubeLocY, cubeLocZ, cubeSclX, cubeSclY, cubeSclZ, cubeRotX, cubeRotY, cubeRotZ)

            FOR v = 1 TO 8
                FOR c = 1 TO 3
                    cubes(numCubes, v, c) = RtempCube(v, c)
                NEXT c
            NEXT v
        END IF
    LOOP

    CLOSE #fileHandle
END SUB

