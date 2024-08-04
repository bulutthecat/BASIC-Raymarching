' Copyright (C) Kevin Dalli 2024

DECLARE SUB RenderCubes (cubes() AS SINGLE, edges() AS INTEGER, numCubes AS INTEGER, camX AS SINGLE, camY AS SINGLE, camZ AS SINGLE, camRotX AS SINGLE, camRotY AS SINGLE, buffer() AS INTEGER)
DECLARE SUB Project3DTo2D (x AS SINGLE, y AS SINGLE, z AS SINGLE, px AS SINGLE, py AS SINGLE, camX AS SINGLE, camY AS SINGLE, camZ AS SINGLE, camRotX AS SINGLE, camRotY AS SINGLE)
DECLARE SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE, rotX AS SINGLE, rotY AS SINGLE, rotZ AS SINGLE)

SCREEN 12


CONST MAXCUBES = 10

CONST SCREENWIDTH = 640
CONST SCREENHEIGHT = 480

DIM buffer(SCREENWIDTH * SCREENHEIGHT) AS INTEGER

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

' Main loop
DO
    ' Clear the buffer
    FOR i = 0 TO SCREENWIDTH * SCREENHEIGHT - 1
        buffer(i) = 0
    NEXT i

    RenderCubes cubes(), edges(), numCubes, camX, camY, camZ, camRotX, camRotY, buffer()

    ' Copy buffer to screen
    CopyBufferToScreen buffer()

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

SUB RenderCubes (Cubes() AS SINGLE, Edges() AS INTEGER, NumCubes AS INTEGER, CamX AS SINGLE, CamY AS SINGLE, CamZ AS SINGLE, CamRotX AS SINGLE, CamRotY AS SINGLE, Buffer() AS INTEGER)
    CONST cx = 320
    CONST cy = 240
    CONST scale = 100

    DIM px(8) AS SINGLE
    DIM py(8) AS SINGLE

    FOR c = 1 TO NumCubes
        FOR i = 1 TO 8
            CALL Project3DTo2D(Cubes(c, i, 1), Cubes(c, i, 2), Cubes(c, i, 3), px(i), py(i), CamX, CamY, CamZ, CamRotX, CamRotY)
        NEXT i

        FOR i = 1 TO 12
            x1 = px(Edges(i, 1))
            y1 = py(Edges(i, 1))
            x2 = px(Edges(i, 2))
            y2 = py(Edges(i, 2))

            ' Draw line to buffer instead of screen
            CALL DrawLineToBuffer(Buffer(), x1, y1, x2, y2, SCREENWIDTH, SCREENHEIGHT, 15)
        NEXT i
    NEXT c
END SUB

SUB DrawLineToBuffer (Buffer() AS INTEGER, x1 AS INTEGER, y1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER, ScreenWidth AS INTEGER, ScreenHeight AS INTEGER, Col AS INTEGER)
    ' Bresenham's line algorithm
    DIM dx AS INTEGER, dy AS INTEGER, sx AS INTEGER, sy AS INTEGER, er AS INTEGER, e2 AS INTEGER

    dx = ABS(x2 - x1)
    dy = ABS(y2 - y1)
    IF x1 < x2 THEN sx = 1 ELSE sx = -1
    IF y1 < y2 THEN sy = 1 ELSE sy = -1
    er = dx - dy

    DO
        IF x1 >= 0 AND x1 < ScreenWidth AND y1 >= 0 AND y1 < ScreenHeight THEN
            Buffer(x1 + y1 * ScreenWidth) = Col
        END IF

        IF x1 = x2 AND y1 = y2 THEN EXIT DO
        e2 = 2 * er
        IF e2 > -dy THEN
            er = er - dy
            x1 = x1 + sx
        END IF
        IF e2 < dx THEN
            er = er + dx
            y1 = y1 + sy
        END IF
    LOOP
END SUB

SUB CopyBufferToScreen (Buffer() AS INTEGER)
    DEF SEG = &HA000  ' Video memory segment

    FOR y = 0 TO SCREENHEIGHT - 1
        FOR x = 0 TO SCREENWIDTH - 1
            POKE x + y * SCREENWIDTH, Buffer(x + y * SCREENWIDTH)
        NEXT x
    NEXT y

    DEF SEG  ' Reset segment to default
END SUB
