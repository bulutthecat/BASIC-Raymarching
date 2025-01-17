' Copyright (C) 2024 Kevin Dalli

' OLD CUBE SUB
'SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE)
'    cube(1, 1) = -1: cube(1, 2) = -1: cube(1, 3) = -1
'    cube(2, 1) = 1: cube(2, 2) = -1: cube(2, 3) = -1
'    cube(3, 1) = 1: cube(3, 2) = 1: cube(3, 3) = -1
'    cube(4, 1) = -1: cube(4, 2) = 1: cube(4, 3) = -1
'    cube(5, 1) = -1: cube(5, 2) = -1: cube(5, 3) = 1
'    cube(6, 1) = 1: cube(6, 2) = -1: cube(6, 3) = 1
'    cube(7, 1) = 1: cube(7, 2) = 1: cube(7, 3) = 1
'    cube(8, 1) = -1: cube(8, 2) = 1: cube(8, 3) = 1
'   
'    FOR i = 1 TO 8
'        cube(i, 1) = locX + cube(i, 1) * sclX
'        cube(i, 2) = locY + cube(i, 2) * sclY
'        cube(i, 3) = locZ + cube(i, 3) * sclZ
'    NEXT i
'
'    edges(1, 1) = 1: edges(1, 2) = 2
'    edges(2, 1) = 2: edges(2, 2) = 3
'    edges(3, 1) = 3: edges(3, 2) = 4
'    edges(4, 1) = 4: edges(4, 2) = 1
'    edges(5, 1) = 5: edges(5, 2) = 6
'    edges(6, 1) = 6: edges(6, 2) = 7
'    edges(7, 1) = 7: edges(7, 2) = 8
'    edges(8, 1) = 8: edges(8, 2) = 5
'    edges(9, 1) = 1: edges(9, 2) = 5
'    edges(10, 1) = 2: edges(10, 2) = 6
'    edges(11, 1) = 3: edges(11, 2) = 7
'    edges(12, 1) = 4: edges(12, 2) = 8
'END SUB

SUB GenCube (cube() AS SINGLE, edges() AS INTEGER, locX AS INTEGER, locY AS INTEGER, locZ AS INTEGER, sclX AS SINGLE, sclY AS SINGLE, sclZ AS SINGLE, rotX AS SINGLE, rotY AS SINGLE, rotZ AS SINGLE)
    DIM temp(3) AS SINGLE
    DIM cosX AS SINGLE, sinX AS SINGLE
    DIM cosY AS SINGLE, sinY AS SINGLE
    DIM cosZ AS SINGLE, sinZ AS SINGLE

    cube(1, 1) = -1: cube(1, 2) = -1: cube(1, 3) = -1
    cube(2, 1) = 1: cube(2, 2) = -1: cube(2, 3) = -1
    cube(3, 1) = 1: cube(3, 2) = 1: cube(3, 3) = -1
    cube(4, 1) = -1: cube(4, 2) = 1: cube(4, 3) = -1
    cube(5, 1) = -1: cube(5, 2) = -1: cube(5, 3) = 1
    cube(6, 1) = 1: cube(6, 2) = -1: cube(6, 3) = 1
    cube(7, 1) = 1: cube(7, 2) = 1: cube(7, 3) = 1
    cube(8, 1) = -1: cube(8, 2) = 1: cube(8, 3) = 1

    rotX = rotX * 3.14159265358979 / 180 ' translate degrees to radians
    rotY = rotY * 3.14159265358979 / 180
    rotZ = rotZ * 3.14159265358979 / 180

    cosX = COS(rotX): sinX = SIN(rotX)
    cosY = COS(rotY): sinY = SIN(rotY)
    cosZ = COS(rotZ): sinZ = SIN(rotZ)

    FOR i = 1 TO 8
        
        cube(i, 1) = cube(i, 1) * sclX
        cube(i, 2) = cube(i, 2) * sclY
        cube(i, 3) = cube(i, 3) * sclZ

        temp(2) = cosX * cube(i, 2) - sinX * cube(i, 3)
        temp(3) = sinX * cube(i, 2) + cosX * cube(i, 3)
        cube(i, 2) = temp(2)
        cube(i, 3) = temp(3)

        temp(1) = cosY * cube(i, 1) + sinY * cube(i, 3)
        temp(3) = -sinY * cube(i, 1) + cosY * cube(i, 3)
        cube(i, 1) = temp(1)
        cube(i, 3) = temp(3)

        temp(1) = cosZ * cube(i, 1) - sinZ * cube(i, 2)
        temp(2) = sinZ * cube(i, 1) + cosZ * cube(i, 2)
        cube(i, 1) = temp(1)
        cube(i, 2) = temp(2)

        cube(i, 1) = locX + cube(i, 1)
        cube(i, 2) = locY + cube(i, 2)
        cube(i, 3) = locZ + cube(i, 3)
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


' the following code is well documented, as this class CAN be overwritten when implementing custom rendering code

SUB Project3DTo2D (x AS SINGLE, y AS SINGLE, z AS SINGLE, px AS SINGLE, py AS SINGLE, camX AS SINGLE, camY AS SINGLE, camZ AS SINGLE, camRotX AS SINGLE, camRotY AS SINGLE)
    CONST cx = 160
    CONST cy = 100
    CONST cz = 3
    CONST scale = 50  ' adjust this value to change the field of view

    ' apply camera rotation around Y-axis
    DIM tempX AS SINGLE, tempZ AS SINGLE
    tempX = x * COS(camRotY * 3.14159 / 180) - z * SIN(camRotY * 3.14159 / 180)
    tempZ = x * SIN(camRotY * 3.14159 / 180) + z * COS(camRotY * 3.14159 / 180)
    x = tempX
    z = tempZ

    ' apply camera rotation around X-axis
    DIM tempY AS SINGLE
    tempY = y * COS(camRotX * 3.14159 / 180) - z * SIN(camRotX * 3.14159 / 180)
    tempZ = y * SIN(camRotX * 3.14159 / 180) + z * COS(camRotX * 3.14159 / 180)
    y = tempY
    z = tempZ

    ' apply camera transformation
    x = x - camX
    y = y - camY
    z = z - camZ

    ' fixes the issue of vertex mapping outside the screen, causing redraw in front of the camera
    IF z <= 0 THEN
        px = -1
        py = -1
        EXIT SUB
    END IF

    ' perspective projection
    px = cx + scale * x / (z + cz)
    py = cy - scale * y / (z + cz)
END SUB
