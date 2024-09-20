DECLARE SUB startCom ()

startCom

DO
        PRINT "Enter a message to send (or type 'exit' to quit):"
        INPUT message$

        IF message$ = "exit" THEN
                EXIT DO
        END IF

        PRINT #1, message$

        PRINT "message sent: "; message$

LOOP

CLOSE #1

PRINT "serial com closed"
END

SUB startCom
        OPEN "COM1:9600,N,8,1,CS0,DS0" FOR RANDOM AS #1
        PRINT "serial communication setup complete"
END SUB

