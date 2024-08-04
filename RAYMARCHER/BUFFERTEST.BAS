' Copyright (C) 2024 Kevin Dalli
' This documents a simple method of double buffering in QB16 DOS

SCREEN 7

DIM x AS INTEGER
DIM y AS INTEGER
x = 160
y = 100

DIM dx AS INTEGER
dx = 2 ' direction

WHILE INKEY$ = ""
    ' this defines the active "page"
    '
    ' Pages are assentially "virtual displays" that can be used 
    ' to draw graphics off-screen before displaying them on the
    ' visible screen. This is useful for double buffering, where
    ' you draw to one page while displaying the other, then swap
    ' them to avoid flickering.

    PCOPY 1, 0 ' copy the visible screen (page 1) to virtual screen (page 0)'
    CLS

    PSET (x, y), 15

    x = x + dx ' \/ position updates
    IF x > 320 OR x < 0 THEN
        dx = -dx
    END IF

    FOR delay = 1 TO 5000: NEXT delay

    ' copy the virtual screen (page 0) to visible screen (page 1)
    PCOPY 0, 1
WEND

' restore the screen back to normal
SCREEN 0

' the following code is the same as the above without any rendering

'SCREEN 7
'WHILE INKEY$ = ""
'    PCOPY 1, 0
'    CLS
'    ' <-- rendering code here
'    PCOPY 0, 1
'WEND
'SCREEN 0