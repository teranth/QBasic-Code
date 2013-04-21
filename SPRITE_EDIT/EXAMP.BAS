'How to load and draw a .e file
'
'By Elias York.
'
'You may use this code as long as you give credit to Elias York.

SCREEN 7                        'Set screen mode.

DIM pic%(0 TO 9, 0 TO 9)        'Make 10x10 pic holding var.

px% = 100                       'Set draw spot for pic x.
py% = 100                       'Set draw spot for pic y.

trancolor% = 8                  'Set tran color.

'Load pic.
OPEN "pic.e" FOR INPUT AS #1
 INPUT #1, j%                   'Get pic x size.
 INPUT #1, j%                   'Get pic y size.
 FOR y = 0 TO 9
  FOR x = 0 TO 9
   INPUT #1, pic%(y, x)         'Load pic data.
  NEXT x
 NEXT y
CLOSE #1

'Draw pic.
FOR y = 0 TO 9
 FOR x = 0 TO 9
  IF pic%(y, x) <> trancolor% THEN PSET (px% + x, py% + y), pic%(y, x)  'Draw one pixel from picture.
 NEXT x
NEXT y

