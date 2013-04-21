'Eli's Snow Storm
'
'Date: 10-07-2001
'By Elias York
'
DECLARE SUB KillFlake (s AS ANY)

'Option vars
sx% = 320
sy% = 200
maxflakes% = 1000
wind% = 1
FlakeIdle% = 20
StartSpot% = 2
'StartSpot% = 1: Random StartSpot%.
'StartSpot% = 2: StartSpot% to the right.
'StartSpot% = 3: StartSpot% to the left.
Dir% = 2
'Dir% = 1: Random wind direction left or right gusts, power = wind%.
'Dir% = 2: Gust to the left, power = wind%.
'Dir% = 3: Gust to the right, power = wind%.

TYPE SnowFlake
 x AS INTEGER
 y AS INTEGER
 Falling AS INTEGER
 Color AS INTEGER
 There AS INTEGER
END TYPE

DIM Snow(maxflakes%) AS SnowFlake
DIM OldSnow AS SnowFlake

RANDOMIZE TIMER
SCREEN 7
LINE (1, 150)-(100, 150), 2
LINE (1, 1)-(1, 199), 2
LINE (1, 1)-(319, 1), 2
LINE (319, 1)-(319, 199), 2
LINE (1, 150)-(319, 150), 2
COLOR 2
LOCATE 13, 15
PRINT "Elias York"
LOCATE 14, 20
PRINT "Was here."
Flakes% = 0
DO
 Key$ = INKEY$
 IF Key$ = CHR$(13) THEN
  CLS
  LINE (1, 150)-(100, 150), 2
  LINE (1, 1)-(1, 199), 2
  LINE (1, 1)-(319, 1), 2
  LINE (319, 1)-(319, 199), 2
  LINE (1, 150)-(319, 150), 2
  COLOR 2
  LOCATE 13, 15
  PRINT "Elias York"
  LOCATE 14, 20
  PRINT "Was here."
 END IF
 GOSUB UpdateSnow
LOOP WHILE Key$ <> CHR$(27)

END

UpdateSnow:
'CLS
LINE (1, 150)-(100, 150), 2
LINE (1, 1)-(1, 199), 2
LINE (1, 1)-(319, 1), 2
LINE (319, 1)-(319, 199), 2
LINE (1, 150)-(319, 150), 2
CIRCLE (160, 100), 20, 3
td% = FlakeIdle%
Flakes% = 0
FOR i = 1 TO maxflakes%
 IF Snow(i).There = 1 THEN Flakes% = Flakes% + 1
NEXT i
LOCATE 20, 30
PRINT "Number of flakes out: "; Flakes%
FOR i = 1 TO maxflakes%
 IF Snow(i).There = 1 THEN
  PSET (Snow(i).x, Snow(i).y), 0
  Snow(i).y = Snow(i).y + 1
  IF Dir% = 1 THEN
   e% = INT(RND * 3) + 1
   IF e% = 1 THEN Snow(i).x = Snow(i).x - wind%
   IF e% = 2 THEN Snow(i).x = Snow(i).x + wind%
  END IF
  IF Dir% = 2 THEN
   Snow(i).x = Snow(i).x - wind%
  END IF
  IF Dir% = 3 THEN
   Snow(i).x = Snow(i).x + wind%
  END IF
  IF Snow(i).x = OldSnow.x THEN Snow(i).x = Snow(i).x - 1
  IF Snow(i).y = OldSnow.y THEN Snow(i).y = Snow(i).y + 1
  IF Snow(i).x < 1 THEN Snow(i).x = 1
  IF Snow(i).x > sx% THEN Snow(i).x = sx%
  IF POINT(Snow(i).x, Snow(i).y) <> 0 THEN KillFlake Snow(i)
  IF Snow(i).y > sy% THEN KillFlake Snow(i)
  PSET (Snow(i).x, Snow(i).y), Snow(i).Color
  OldSnow = Snow(i)
 END IF
 IF Snow(i).There <> 1 THEN
  IF td% > 0 THEN
   Snow(i).There = 1
   Snow(i).y = 1
   e% = INT(RND * 2) + 1
   IF e% = 1 THEN
     IF StartSpot% = 1 THEN
      Snow(i).x = RND * sx%
     END IF
     IF StartSpot% = 2 THEN
      Snow(i).y = RND * sy%
      IF Snow(i).y < 1 THEN Snow(i).y = 1
      Snow(i).x = sx%
     END IF
     IF StartSpot% = 3 THEN
      Snow(i).y = RND * sy%
      IF Snow(i).y < 1 THEN Snow(i).y = 1
      Snow(i).x = 0
     END IF
   END IF
   IF e% = 2 THEN Snow(i).x = RND * sx%
   Snow(i).Color = 15
   td% = td% - 1
  END IF
 END IF
NEXT i
RETURN

SUB KillFlake (s AS SnowFlake)
s.There = 0
s.y = s.y - 1
PSET (s.x, s.y), s.Color
END SUB

