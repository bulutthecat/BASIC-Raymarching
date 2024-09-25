' Copyright 2024 (c) Kevin Dalli
' This kinda works, need to fix coloring issues

SCREEN 13
FOR Y = 0 TO 199
        FOR X = 0 TO 319
                a = X / 160 - 1
                b = Y / 100 - 1
                c = SQR(a * a + b * b + 1)
                dx = a / c
                dy = b / c
                dz = -1 / c
                px = 0: py = 0: pz = 0
                t = 0: s = 1
                WHILE s > 0.01 AND t < 10
                        px = px + dx * s
                        py = py + dy * s
                        pz = pz + dz * s
                        s = SQR(px * px + py * py + (pz + 3) * (pz + 3)) - 1
                        t = t + s
                WEND
                IF s < 0.01 THEN
                        l = SQR(px * px + py * py + (pz + 3) * (pz + 3))
                        e = (pz + 3) / l
                        col = INT(15 * e)
                        IF col < 0 THEN col = 0
                        IF col > 15 THEN col = 15
                        PSET (X, Y), col
                ELSE
                        PSET (X, Y), 0
                END IF
        NEXT X
NEXT Y
END