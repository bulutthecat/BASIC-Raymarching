DECLARE SUB startCom ()

startCom

DO
        IF NOT EOF(1) THEN
                LINE INPUT #1, received$
                PRINT "received: "; received$
        END IF

LOOP UNTIL INKEY$ = CHR$(27)

CLOSE #1

PRINT "serial com closed"
END

SUB startCom
        OPEN "COM1:9600,N,8,1,CS0,DS0" FOR RANDOM AS #1
        PRINT "waiting for data..."
END SUB

