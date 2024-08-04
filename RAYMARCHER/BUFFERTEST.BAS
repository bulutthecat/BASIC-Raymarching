' Set the screen to graphics mode with page flipping
SCREEN 7

' Define the position variables
DIM x AS INTEGER
DIM y AS INTEGER
x = 160 ' Initial horizontal position (middle of the screen)
y = 100 ' Initial vertical position (middle of the screen)

' Define the direction of movement
DIM dx AS INTEGER
dx = 2 ' Move 2 pixels at a time

' Main loop
WHILE INKEY$ = ""
    ' Set the active page to 0 (drawing page)
    PCOPY 1, 0
    CLS ' Clear the screen

    ' Draw the box in the current position on virtual screen (page 0)
    PSET (x, y), 15 ' Draw point at position (x, y) with color white

    ' Update the position
    x = x + dx
    IF x > 320 OR x < 0 THEN
        dx = -dx ' Change direction if it hits the screen boundaries
    END IF

    ' Wait to simulate frame rate
    FOR delay = 1 TO 5000: NEXT delay

    ' Copy the virtual screen (page 0) to visible screen (page 1)
    PCOPY 0, 1
WEND

' Return to text mode
SCREEN 0
