DECLARE SUB UnLeetIt (S AS STRING, o AS STRING)
DECLARE SUB LeetIt (S AS STRING, o AS STRING)
'This program was written by Elias York
'Date: 05/06/2003
'This is a Leeter/UnLeeter.

'------------------ Main Driver ----------------'

'Clear the screen.
CLS

'Get string.
INPUT "Enter String to Leet/UnLeet: ", strr$

'Turn into leet.
LeetIt strr$, outt$

'Turn out leet.
UnLeetIt strr$, outt2$

'Output to user.
PRINT "String Leeted: "; UCASE$(outt$)
PRINT "String UnLeeted (Forced to lowercase): "; LCASE$(outt2$)

'Wait for a key press.
SLEEP

'End of code.
END

SUB LeetIt (S AS STRING, o AS STRING)
 o = ""
 FOR I = 1 TO LEN(S)
  IF MID$(S, I, 2) = "AT" THEN
   td = 1
   o = o + "@"
   I = I + 1
  END IF

  IF td = 0 THEN
  SELECT CASE UCASE$(MID$(S, I, 1))
   CASE "A":
    td = 1
    o = o + "4"
   CASE "B":
    td = 1
    o = o + "8"
   CASE "E":
    td = 1
    o = o + "3"
   CASE "G":
    td = 1
    o = o + "6"
   CASE "I":
    td = 1
    o = o + "I"                 ' Not using I = | now.
   CASE "L":
    td = 1
    o = o + "1"
   CASE "O":
    td = 1
    o = o + "0":
   CASE "S":
    td = 1
    o = o + "5"
   CASE "T":
    td = 1
    o = o + "7"
   CASE "Z":
    td = 1
    o = o + "2"
   CASE "H":
    td = 1
    o = o + "#"
  END SELECT
  END IF
  IF td <> 1 THEN o = o + MID$(S, I, 1)
  td = 0
 NEXT I
END SUB

SUB UnLeetIt (S AS STRING, o AS STRING)
 o = ""
 td = 0
 FOR I = 1 TO LEN(S)
  SELECT CASE UCASE$(MID$(S, I, 1))
   CASE "@":
    td = 1
    o = o + "AT"
   CASE "#":
    td = 1
    o = o + "H"
   CASE "4":
    td = 1
    o = o + "A"
   CASE "8":
    td = 1
    o = o + "B"
   CASE "3":
    td = 1
    o = o + "E"
   CASE "6":
    td = 1
    o = o + "G"
   CASE "9":
    td = 1
    o = o + "G"
   CASE "|":
    td = 1
    o = o + "|"                 ' Not using I = | now.
   CASE "1":
    td = 1
    o = o + "L"
   CASE "0":
    td = 1
    o = o + "O":
   CASE "5":
    td = 1
    o = o + "S"
   CASE "7":
    td = 1
    o = o + "T"
   CASE "2":
    td = 1
    o = o + "Z"
  END SELECT
  IF td <> 1 THEN o = o + MID$(S, I, 1)
  td = 0
 NEXT I
END SUB

