SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE)
    cube(1, 1) = -1: cube(1, 2) = -1: cube(1, 3) = -1
    cube(2, 1) = 1: cube(2, 2) = -1: cube(2, 3) = -1
    cube(3, 1) = 1: cube(3, 2) = 1: cube(3, 3) = -1
    cube(4, 1) = -1: cube(4, 2) = 1: cube(4, 3) = -1
    cube(5, 1) = -1: cube(5, 2) = -1: cube(5, 3) = 1
    cube(6, 1) = 1: cube(6, 2) = -1: cube(6, 3) = 1
    cube(7, 1) = 1: cube(7, 2) = 1: cube(7, 3) = 1
    cube(8, 1) = -1: cube(8, 2) = 1: cube(8, 3) = 1
   
    FOR i = 1 TO 8
        cube(i, 1) = locX + cube(i, 1) * sclX
        cube(i, 2) = locY + cube(i, 2) * sclY
        cube(i, 3) = locZ + cube(i, 3) * sclZ
    NEXT i

    edges(1, 1) = 1: edges(1, 2) = 2
    edges(2, 1) = 2: edges(2, 2) = 3
    edges(3, 1) = 3: edges(3, 2) = 4
    edges(4, 1) = 4: edges(4, 2) = 1
    edges(5, 1) = 5: edges(5, 2) = 6
    edges(6, 1) = 6: edges(6, 2) = 7
    edges(7, 1) = 7: edges(7, 2) = 8
    edges(8, 1) = 8: edges(8, 2) = 5
    edges(9, 1) = 1: edges(9, 2) = 5
    edges(10, 1) = 2: edges(10, 2) = 6
    edges(11, 1) = 3: edges(11, 2) = 7
    edges(12, 1) = 4: edges(12, 2) = 8
END SUB

SUB Project3DTo2D (x AS SINGLE, y AS SINGLE, z AS SINGLE, px AS SINGLE, py AS SINGLE)
    CONST cx = 320
    CONST cy = 240
    CONST cz = 3
    CONST scale = 100

    px = cx + scale * x / (z + cz)
    py = cy - scale * y / (z + cz)
END SUB

