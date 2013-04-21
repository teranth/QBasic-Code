DECLARE FUNCTION GetData! ()
DECLARE FUNCTION GetString$ ()
DECLARE SUB GetFile (f$)
DECLARE SUB SendFile (f$)
DECLARE SUB OpenConnection ()
DECLARE SUB SendString (d$)
CLS
OpenConnection
endd = 0
DO
 CLS
 PRINT "1 - Send String."
 PRINT "2 - Send Data."
 PRINT "3 - Send File."
 PRINT "4 - Get File."
 PRINT "5 - Get String."
 PRINT "6 - Get Data."
 PRINT "7 - Exit."
 INPUT "> ", ch$
 SELECT CASE ch$
  CASE "1":
   INPUT "Enter String To Send: ", ss$
   SendString ss$
   PRINT "Sent String: "; ss$
   SLEEP 3
  CASE "2":
   INPUT "Enter Data To Send: ", d%
   PRINT #1, d%
   PRINT "Sent Data: "; d%
   SLEEP 3
  CASE "3":
   INPUT "Enter filename: ", f$
   SendFile f$
   SLEEP 3
  CASE "4":
   INPUT "Name of file: ", f$
   GetFile f$
   SLEEP 3
  CASE "5":
   PRINT "Getting string."
   d$ = GetString
   PRINT "String is: "; d$
   SLEEP 3
  CASE "6":
   d% = GetData
   PRINT "Data is: "; d%
   SLEEP 3
  CASE "7": endd = 1
 END SELECT
LOOP UNTIL endd = 1
CLOSE #1

FUNCTION GetData
 PRINT "Waiting for data."
 INPUT #1, d%
 GetData = d%
 PRINT "Got data."
END FUNCTION

SUB GetFile (f$)
 PRINT "Waiting for file."
 OPEN f$ FOR BINARY AS #2
 i% = 1
 c = 0
 WHILE c <> 3
  INPUT #1, d%
  IF c <> 3 THEN PUT #2, i%, d%
  i% = i% + 1
  IF d% = -37 THEN c = c + 1 ELSE c = 0
 WEND
 PRINT "File complete."
 CLOSE #2
END SUB

FUNCTION GetString$
 PRINT "Waiting for string."
 BUF$ = ""
 DO
  INPUT #1, d%
  IF d% <> -1 THEN
   BUF$ = BUF$ + CHR$(d%)
  END IF
 LOOP UNTIL d% = -1
 GetString$ = BUF$
END FUNCTION

SUB OpenConnection
 OPEN "COM1:9600,N,8,1,CD0,CS0,DS0,OP0,RS,TB2048,RB2048" FOR RANDOM AS #1
END SUB

SUB SendFile (f$)
 CLS
 PRINT "Sending file."
 OPEN f$ FOR BINARY AS #2
  DIM i, c AS LONG
  i = 1
  c = LOF(2)
  PRINT "Lenght: "; c
  WHILE NOT EOF(2)
   GET #2, i, d%
   'PRINT d%;
   PRINT #1, d%
   LOCATE 1, 1
   PRINT "Byte "; i; " / "; c
   PRINT INT((i * 100 / c)); " %"
   i = i + 1
  WEND
dd:
  PRINT #1, -37
  PRINT #1, -37
  PRINT #1, -37
 CLOSE #2
 PRINT
 PRINT "File Sent."
END SUB

SUB SendString (d$)
 FOR i = 1 TO LEN(d$)
  PRINT #1, ASC(MID$(d$, i, 1))
  PRINT ASC(MID$(d$, i, 1));
  FOR b = 0 TO 100: NEXT b
 NEXT i
 PRINT #1, -1
 PRINT
END SUB

