' Copyright (C) 2024 Kevin Dalli

SUB queryUpdate(comport as string, baud as integer)
    OPEN "COM" + comport + ":" + STR$(baud) + ",N,8,1,CS0,DS0" FOR INPUT AS #1
    OPEN "TEMP.CSV" for output as #2

    if not eof(1) THEN
        line input #1, received$
        print #2, received$
    END IF
    
