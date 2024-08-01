' Copyright (C) Kevin Dalli 2024

DECLARE SUB RenderCube (cube() AS SINGLE, edges() AS INTEGER)
DECLARE SUB Project3DTo2D (x AS SINGLE, y AS SINGLE, z AS SINGLE, px AS SINGLE, py AS SINGLE)
DECLARE SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE)

SCREEN 12

DIM cube(8, 3) AS SINGLE
DIM edges(12, 2) AS INTEGER

CALL GenCube(cube(), edges(), 0, 0, 0, 2, 2, 2) ' OBJ, EDG, X, Y, Z, Xsize, Ysize, Zsize

RenderCube cube(), edges()

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

