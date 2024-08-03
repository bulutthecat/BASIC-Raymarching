' Copyright (C) Kevin Dalli 2024

DECLARE SUB RenderCubes (cubes() AS SINGLE, edges() AS INTEGER, numCubes AS INTEGER, camX AS SINGLE, camY AS SINGLE, camZ AS SINGLE, camRotX AS SINGLE, camRotY AS SINGLE)
DECLARE SUB Project3DTo2D (x AS SINGLE, y AS SINGLE, z AS SINGLE, px AS SINGLE, py AS SINGLE, camX AS SINGLE, camY AS SINGLE, camZ AS SINGLE, camRotX AS SINGLE, camRotY AS SINGLE)
DECLARE SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE, rotX AS SINGLE, rotY AS SINGLE, rotZ AS SINGLE)

SCREEN 12


CONST MAXCUBES = 10

DIM cubes(MAXCUBES, 8, 3) AS SINGLE
DIM edges(12, 2) AS INTEGER

DIM numCubes AS INTEGER
numCubes = MAXCUBES

DIM locX AS INTEGER
DIM locY AS INTEGER
DIM locZ AS INTEGER
DIM sclX AS SINGLE
DIM sclY AS SINGLE
DIM sclZ AS SINGLE

DIM i AS INTEGER
DIM LX AS INTEGER
DIM LY AS INTEGER
DIM LZ AS INTEGER
DIM SX AS SINGLE
DIM SY AS SINGLE
DIM SZ AS SINGLE
DIM rotX AS SINGLE
DIM rotY AS SINGLE
DIM rotZ AS SINGLE
DIM camRotX AS SINGLE
DIM camRotY AS SINGLE

' initial values

LX = 0
LY = 0
LZ = 0

SX = 1
SY = 1
SZ = 1

rotX = 0
rotY = 0
rotZ = 0

camX = 0
camY = 0
camZ = 0

camRotX = 0
camRotY = 0

RANDOMIZE TIMER
FOR i = 1 TO numCubes
    locX = INT(RND * 20) - 10
    locY = INT(RND * 20) - 10
    locZ = INT(RND * 20) - 10
    sclX = RND + 0.5
    sclY = RND + 0.5
    sclZ = RND + 0.5
    
    DIM tempCube(8, 3) AS SINGLE

    CALL GenCube(tempCube(), edges(), locX, locY, locZ, sclX, sclY, sclZ, 0, 0, 0)

    ' copy vertecies into main cube array
    FOR v = 1 TO 8
        FOR c = 1 TO 3
            cubes(i, v, c) = tempCube(v, c) ' it is possible to load other geomatry thats not cubic, but this currently requires manual editing of the cubelib library
        NEXT c
    NEXT v
NEXT i

DO
    CLS
    RenderCubes cubes(), edges(), numCubes, camX, camY, camZ, camRotX, camRotY
    key$ = INKEY$
    SELECT CASE key$
        CASE "w"
            camZ = camZ + .1
        CASE "s"
            camZ = camZ - .1
        CASE "a"
            camX = camX - .1
        CASE "d"
            camX = camX + .1
        CASE "q"
            camY = camY - .1
        CASE "e"
            camY = camY + .1
        CASE "r" ' this fixes a bug which puts the camera in an unrecoverable loop
            camX = 0
            camY = 0
            camZ = 0
            camRotX = 0
            camRotY = 0
        CASE CHR$(27) ' Escape key
            EXIT DO
    END SELECT

    IF key$ = CHR$(0) + CHR$(72) THEN camRotX = camRotX + 1 ' up arrow
    IF key$ = CHR$(0) + CHR$(80) THEN camRotX = camRotX - 1 ' down arrow
    IF key$ = CHR$(0) + CHR$(75) THEN camRotY = camRotY + 1 ' left arrow
    IF key$ = CHR$(0) + CHR$(77) THEN camRotY = camRotY - 1 ' right arrow

    FOR delay = 1 TO 500: NEXT delay
LOOP

END
SUB RenderCubes (cubes() AS SINGLE, edges() AS INTEGER, numCubes AS INTEGER, camX AS SINGLE, camY AS SINGLE, camZ AS SINGLE, camRotX AS SINGLE, camRotY AS SINGLE)
    CONST cx = 320
    CONST cy = 240
    CONST scale = 100

    DIM px(8) AS SINGLE
    DIM py(8) AS SINGLE

    FOR c = 1 TO numCubes
        FOR i = 1 TO 8
            CALL Project3DTo2D(cubes(c, i, 1), cubes(c, i, 2), cubes(c, i, 3), px(i), py(i), camX, camY, camZ, camRotX, camRotY)
        NEXT i

        FOR i = 1 TO 12
            x1 = px(edges(i, 1))
            y1 = py(edges(i, 1))
            x2 = px(edges(i, 2))
            y2 = py(edges(i, 2))

            ' this checks if there is any geomatry outside of screen bounds (to prevent endless calculations & buffer overflow)
            IF x1 >= 0 AND x1 <= 640 AND y1 >= 0 AND y1 <= 480 AND x2 >= 0 AND x2 <= 640 AND y2 >= 0 AND y2 <= 480 THEN
                LINE (x1, y1)-(x2, y2), 15
            END IF
        NEXT i
    NEXT c
END SUB
