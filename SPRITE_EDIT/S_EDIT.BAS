'S-Edit
'
'By Elias York

'You may use this code freely as long as you give credit
'to Elias York.

SCREEN 7, 0, 1

ON ERROR RESUME NEXT

'Main windows vars
dx% = 10 'Main drawing window x.
dy% = 10 'Main drawing window y.
spaceing% = 7   'Main drawing window spaceing.
LineColor% = 7  'Line color for divider.
cx% = 100       'Color picker window x.
cy% = 10       'Color picker window y.
px% = 0         'Pointer x.
py% = 0        'pointer y.
pcolor% = 0     'Pointer color.
pc% = 1         'Current drawing color.
mx% = 85       'Mini pic x.
my% = 10       'Mini pic y.

cfile$ = "- New Sprite -"

DIM pic%(0 TO 10, 0 TO 10)

RANDOMIZE TIMER

FOR y = o TO 9
FOR x = 0 TO 9
pic%(y, x) = 8
NEXT x
NEXT y

DO
GOSUB DrawScreen
 kb$ = INKEY$   'Get the key.
 IF kb$ <> "" THEN
  SELECT CASE UCASE$(kb$)
  CASE "S":
   GOSUB SavePic        'Save pic.
  CASE "T":
   GOSUB TilePic
  CASE "L":      'Load pic.
   GOSUB LoadPic
  CASE CHR$(13):              'Draw a dot.
   pic%(py%, px%) = pc%
  CASE "E":     'Export pic.
   GOSUB ExportPic
  CASE CHR$(27):        'Exit program.
   END
  CASE "+":             'Move up one color.
   IF pc% < 15 THEN pc% = pc% + 1
  CASE "-":             'Move down one color.
   IF pc% > 0 THEN pc% = pc% - 1
  CASE CHR$(0) + "M":     'Move pointer right.
   IF px% < 9 THEN px% = px% + 1
  CASE CHR$(0) + "K":     'Move pointer left.
   IF px% > 0 THEN px% = px% - 1
  CASE CHR$(0) + "H":     'Move pointer up.
   IF py% > 0 THEN py% = py% - 1
  CASE CHR$(0) + "P":     'Move pointer down.
   IF py% < 9 THEN py% = py% + 1
  END SELECT
 END IF
LOOP
END

DrawScreen:
'Main drawing window stuff.
FOR y = 0 TO 9
 FOR x = 0 TO 9
  LINE (dx% + x * spaceing%, dy% + y * spaceing%)-(dx% + x * spaceing% + 5, dy% + y * spaceing% + 5), pic%(y, x), BF
 NEXT x
NEXT y
LINE (dx% - 1, dy% - 1)-(dx% + 10 * spaceing% - 1, dy% + 10 * spaceing% - 1), LineColor%, B
PAINT (dx% + 6, dy% + 1), LineColor%

'Color picker stuff.
cnum% = 0
FOR y = 0 TO 2
 FOR x = 0 TO 4
  LINE (cx% + x * spaceing%, cy% + y * spaceing%)-(cx% + x * spaceing% + 5, cy% + y * spaceing% + 5), cnum%, BF
  IF cnum% = pc% THEN LINE (cx% + x * spaceing%, cy% + y * spaceing%)-(cx% + x * spaceing% + 5, cy% + y * spaceing% + 5), pcolor%, B
  IF cnum% = pc% AND cnum% = 0 THEN LINE (cx% + x * spaceing%, cy% + y * spaceing%)-(cx% + x * spaceing% + 5, cy% + y * spaceing% + 5), 15, B
  cnum% = cnum% + 1
 NEXT x
NEXT y

LINE (cx% + 0 * spaceing%, cy% + 3 * spaceing%)-(cx% + 0 * spaceing% + 5, cy% + 3 * spaceing% + 5), cnum%, BF
IF cnum% = pc% THEN LINE (cx% + 0 * spaceing%, cy% + 3 * spaceing%)-(cx% + 0 * spaceing% + 5, cy% + 3 * spaceing% + 5), pcolor%, B

LINE (cx% - 1, cy% - 1)-(cx% + 5 * spaceing% - 1, cy% + 4 * spaceing% - 1), LineColor%, B
PAINT (cx% + 6, cy% + 1), LineColor%

'Mini pic stuff.
FOR y = 0 TO 9
 FOR x = 0 TO 9
  PSET (mx% + x, my% + y), pic%(y, x)   'Draw mini pic dot.
 NEXT x
NEXT y
LINE (mx% - 1, my% - 1)-(mx% + 9 + 1, my% + 9 + 1), LineColor%, B

LINE (dx% + px% * spaceing%, dy% + py% * spaceing%)-(dx% + px% * spaceing% + 5, dy% + py% * spaceing% + 5), pcolor%, B

LOCATE 6, 13: PRINT "Colors"
LOCATE 11, 1: PRINT "Zoom Sprite"
LOCATE 1, 10: PRINT "Mini"
LOCATE 8, 13: PRINT "Editing: " + cfile$
LOCATE 14, 6: PRINT "S-Edit By Elias York of LRS."
LOCATE 15, 6: PRINT "Use the arrow and eneter keys."
LOCATE 16, 6: PRINT "to draw a sprite and then save"
LOCATE 17, 6: PRINT "it with the S key. to load a"
LOCATE 18, 6: PRINT "pic use the L key. And use the"
LOCATE 19, 6: PRINT "+ and - keys to change colors."
LOCATE 20, 6: PRINT "you can also use the E key to."
LOCATE 21, 6: PRINT "export your picture as Qbasic"
LOCATE 22, 6: PRINT "DATA statements. Have fun."
LOCATE 23, 6: PRINT "Visit us at: WWW.LRS.8M.COM"
PCOPY 1, 0
RETURN

SavePic:
COLOR 2
LOCATE 12, 1: PRINT "                                               "
LOCATE 12, 1: INPUT "Enter name to save to:"; filename$
IF filename$ = "" THEN
 COLOR 2
 LOCATE 12, 1: PRINT "                                               "
 LOCATE 12, 1: PRINT "Can't save file no name entered.": SLEEP 1: GOTO ds
END IF
cfile$ = filename$
OPEN filename$ FOR OUTPUT AS #1
PRINT #1, "10"
PRINT #1, "10"
FOR y = 0 TO 9
 FOR x = 0 TO 9
  IF x <> 9 THEN PRINT #1, pic%(y, x);  ELSE PRINT #1, pic%(y, x)
 NEXT x
NEXT y
CLOSE #1
COLOR 2
LOCATE 12, 1: PRINT "                                               "
LOCATE 12, 1: PRINT "File "; filename$; " saved have fun using your sprite!": SLEEP 1: GOTO ds
ds:
COLOR 15
CLS
RETURN

ExportPic:
COLOR 2
LOCATE 12, 1: PRINT "                                               "
LOCATE 12, 1: INPUT "Enter name to export to:"; filename$
IF filename$ = "" THEN
 COLOR 2
 LOCATE 12, 1: PRINT "                                               "
 LOCATE 12, 1: PRINT "Can't export file no name entered.": SLEEP 1: GOTO de
END IF
cfile$ = filename$
OPEN filename$ FOR OUTPUT AS #1
PRINT #1, "Image X size: 10"
PRINT #1, "Image Y size: 10"
PRINT #1, ""
FOR y = 0 TO 9
 PRINT #1, "DATA ";
 FOR x = 0 TO 9
  IF x <> 9 THEN PRINT #1, pic%(y, x); ",";  ELSE PRINT #1, pic%(y, x)
 NEXT x
NEXT y
CLOSE #1
COLOR 2
LOCATE 12, 1: PRINT "                                               "
LOCATE 12, 1: PRINT "File "; filename$; " exported have fun using your sprite!": SLEEP 1: GOTO ds
de:
COLOR 15
CLS
RETURN

LoadPic:
COLOR 2
LOCATE 12, 1: PRINT "                                               "
LOCATE 12, 1: INPUT "Enter name to load:"; filename$
IF filename$ = "" THEN
 COLOR 2
 LOCATE 12, 1: PRINT "                                               "
 LOCATE 12, 1: PRINT "Can't load file no name entered.": SLEEP 1: GOTO dl
END IF
cfile$ = filename$
OPEN filename$ FOR INPUT AS #1
INPUT #1, j%
INPUT #1, j%
FOR y = 0 TO 9
 FOR x = 0 TO 9
  INPUT #1, pic%(y, x)
 NEXT x
NEXT y
CLOSE #1
COLOR 2
LOCATE 12, 1: PRINT "                                               "
LOCATE 12, 1: PRINT "File "; filename$; " loaded, have fun using your sprite!": SLEEP 1: GOTO ds
dl:
COLOR 15
CLS
RETURN

TilePic:
CLS
FOR ly = 1 TO 10
FOR lx = 0 TO 9
FOR y = 0 TO 9
 FOR x = 0 TO 9
  PSET (lx * 10 + x, ly * 10 + y), pic%(y, x)'Draw
 NEXT x
NEXT y
NEXT lx
NEXT ly
LOCATE 1, 1: PRINT "Press any key to go back to the editor."
SLEEP
CLS
RETURN

