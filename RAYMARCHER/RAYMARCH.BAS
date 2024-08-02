' Copyright (C) Kevin Dalli 2024

DECLARE SUB RenderCube (cube() AS SINGLE, edges() AS INTEGER)
DECLARE SUB Project3DTo2D (x AS SINGLE, y AS SINGLE, z AS SINGLE, px AS SINGLE, py AS SINGLE)
DECLARE SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE, rotX AS SINGLE, rotY AS SINGLE, rotZ AS SINGLE)

SCREEN 12

DIM cube(8, 3) AS SINGLE
DIM edges(12, 2) AS INTEGER

DIM LX AS INTEGER
DIM LY AS INTEGER
DIM LZ AS INTEGER
DIM SX AS SINGLE
DIM SY AS SINGLE
DIM SZ AS SINGLE
DIM rotX AS SINGLE
DIM rotY AS SINGLE
DIM rotZ AS SINGLE

' initial values

LX = 0
LY = 0
LZ = 0

SX = 1
SY = 1
SZ = 1

rotX = 20
rotY = 0
rotZ = 0

CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, rotX, rotY, rotZ) ' OBJ, EDG, X, Y, Z, Xsize, Ysize, Zsize, Xrot, Yrot, Zrot

RenderCube cube(), edges()

' NOTE: put the following in the animation library
'WHILE LX < 5
'    LX = LX + 1
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, 0, 0, 0)
'   
'    RenderCube cube(), edges()
'    SLEEP 1
'WEND
'
'WHILE LY < 5
'    LY = LY + 1
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, 0 ,0, 0)
'
'    RenderCube cube(), edges()
'    SLEEP 1
'WEND
'
'WHILE LZ < 5
'    LZ = LZ + 1
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, 0, 0, 0)
'
'    RenderCube cube(), edges()
'    SLEEP 1
'WEND
'
'WHILE rotX < 180
'    rotX = rotX + 25
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, rotX, 0, 0)
'
'    RenderCube cube(), edges()
'    SLEEP 1
'WEND
'
'WHILE rotY < 180
'    rotY = rotY + 25
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, rotX, rotY, 0)
'
'    RenderCube cube(), edges()
'    SLEEP 1
'WEND
'
'WHILE rotZ < 180
'    rotZ = rotZ + 25
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, rotX, rotY, rotZ)
'
'    RenderCube cube(), edges()
'    SLEEP 1
'WEND

' This does not work in QB64 compile 16 bit
'WHILE INKEY$ = "d"
'    IF INKEY$ = "w" THEN
'        rotX = rotX + 5
'    ELSEIF INKEY$ = "s" THEN
'        rotX = rotX - 5
'    ELSEIF INKEY$ = "a" THEN
'        rotY = rotY + 5
'    ELSEIF INKEY$ = "d" THEN
'        rotY = rotY - 5
'    ELSEIF INKEY$ = "q" THEN
'        rotZ = rotZ + 5
'    ELSEIF INKEY$ = "e" THEN
'        rotZ = rotZ - 5
'    END IF
'
'    CALL GenCube(cube(), edges(), LX, LY, LZ, SX, SY, SZ, rotX, rotY, rotZ)
'    RenderCube cube(), edges()
'WEND

DO WHILE INKEY$ = ""
LOOP
END

SUB RenderCube (cube() AS SINGLE, edges() AS INTEGER)
    DIM px(8) AS SINGLE, py(8) AS SINGLE
    CONST cx = 320
    CONST cy = 240
    CONST cz = 3
    CONST scale = 100

    FOR i = 1 TO 8
        CALL Project3DTo2D(cube(i, 1), cube(i, 2), cube(i, 3), px(i), py(i))
    NEXT i

    FOR i = 1 TO 12
        x1 = px(edges(i, 1))
        y1 = py(edges(i, 1))
        x2 = px(edges(i, 2))
        y2 = py(edges(i, 2))
        LINE (x1, y1)-(x2, y2), 15
    NEXT i
END SUB

