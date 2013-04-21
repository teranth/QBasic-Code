' Times tester
' Date: 10/10/2004
' Programmer: Elias York

' Set screen mode to 640x480 16 color.
SCREEN 12

'Set random timer.
RANDOMIZE TIMER

' Set score to zero and count to zero.
score% = 0
count% = 0
ua% = 0
prob$ = ""
timeon% = 0

IF COMMAND$ = "/time" THEN timeon% = 1

INPUT "Username: ", nuser$
OPEN nuser$ + ".txt" FOR OUTPUT AS #1

stime$ = TIME$

IF timeon% = 1 THEN
ON TIMER(120) GOSUB endtest
TIMER ON
PRINT "Timer started! 2:00 Minutes before test exit!"
PRINT
END IF

' Start main loop.
DO

 n1% = INT(RND * 12)
 n2% = INT(RND * 12)
 a% = n1% * n2%

 PRINT "Enter -37 to exit..."
 PRINT "Score: "; score%; "/"; count%
 PRINT
 PRINT "What is:"
 PRINT "     "; n1%
 PRINT "x    "; n2%
 PRINT
 INPUT ":> ", ua%

 IF ua% <> -37 THEN
 IF ua% = a% THEN
  score% = score% + 1
  PRINT "Correct!"
  PRINT
  ELSE
  PRINT "Wrong... Answer is: "; a%
  PRINT
   prob$ = prob$ + STR$(n1%) + " x " + STR$(n2%) + " =" + STR$(ua%) + " (Real Answer: " + STR$(a%) + ")" + CHR$(13) + CHR$(10)
 END IF
 count% = count% + 1
 END IF

' End of main loop
LOOP UNTIL ua% = -37

endtest:

etime$ = TIME$

IF timeon% = 1 THEN
PRINT "Test has ended....."
TIMER OFF
SLEEP 2

END IF

PRINT "Information about your results are stored in '"; nuser$ + ".txt' thanks."

PRINT #1, "Information"
PRINT #1, ""
PRINT #1, "Username:   "; nuser$
PRINT #1, "Date:       "; DATE$
PRINT #1, "Start Time: "; stime$
PRINT #1, "End Time:   "; etime$
IF timeon% = 1 THEN
 PRINT #1, "Timed:      " + "2:00 Minutes."
END IF

PRINT #1, ""
PRINT #1, "Results:"
PRINT #1, ""
PRINT #1, "You got '"; score%; "' correct out of '"; count%; "'"
PRINT #1, "You were correct ";
PRINT #1, USING "##.#"; (CSNG(score% / count%) * 100);
PRINT #1, "% of the time."
PRINT #1, ""
PRINT #1, "The problems you had trouble with are listed below:"
PRINT #1, ""
PRINT #1, prob$

CLOSE #1
SLEEP 2

END
RETURN

