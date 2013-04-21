DECLARE SUB LoadMap (ch AS STRING)
DECLARE SUB Render ()
DECLARE SUB ResetGrid ()
DECLARE SUB MakeLookUps ()

'This program was written by Elias York.
'Date: 02/2/2003
'This is a height map example program.

'------------------- Defines -------------------'
TYPE tPnt
 x      AS SINGLE
 y      AS SINGLE
 z      AS SINGLE
 c      AS INTEGER
 here   AS INTEGER
END TYPE

CONST YES = -1
CONST NO = 0
CONST MAXPOINTS = 40
CONST zcenter = 256
CONST xcenter = 100
CONST ycenter = 150

'----------------- Variables -------------------'
DIM SHARED p(MAXPOINTS / 2, MAXPOINTS / 2) AS tPnt
DIM SHARED pcount AS INTEGER
DIM SHARED Theta, Phi, Zang AS INTEGER
DIM SHARED c!(360), s!(360)
DIM SHARED LineON, RotON, CirON AS INTEGER

'---------------- Main Driver ------------------'
'Set variables.
Theta = 15
Phi = 20
LineON = YES
RotON = NO
CirON = NO
pcount = 0
PSpd = 0
TSpd = 0

'Make math lookups.
MakeLookUps

'Reset display grid.
ResetGrid

'Load map.
LoadMap "map.raw"

'Set screen mode.
SCREEN 7, 0, 1, 0

'Start main loop.
DO
 'Clear the screen.
 CLS
 SELECT CASE UCASE$(INKEY$)
  CASE CHR$(27): EXIT DO
  CASE "L": IF LineON = YES THEN LineON = NO ELSE LineON = YES
  CASE "R": IF RotON = YES THEN RotON = NO ELSE RotON = YES
  CASE "W":                                     'Rot Up
   PSpd = PSpd + 1
  CASE "S":                                     'Rot Down
   PSpd = PSpd - 1
  CASE "A":                                     'Rot Left
   TSpd = TSpd - 1
  CASE "D":                                     'Rot Right
   TSpd = TSpd + 1
 END SELECT

 'Rotate if set to yes.
 IF RotON = YES THEN
  'Update rotation.
  Theta = Theta + 1
  'Phi = Phi + 1
 END IF
  Theta = Theta + TSpd
  Phi = Phi + PSpd

 'Make sure rotation is not too big.
 IF Theta >= 359 THEN Theta = 1
 IF Phi >= 359 THEN Phi = 1
 IF Theta <= 0 THEN Theta = 359
 IF Phi <= 0 THEN Phi = 359

 'Draw all points.
 Render

 PCOPY 1, 0

'End of main loop.
LOOP

'End of program code.
END

SUB LoadMap (ch AS STRING)
 'Open map for binary reading.
 OPEN ch FOR BINARY AS #1

  'Se record counter to lowest point.
  r% = 1

  'Loop through all points in height map.
  FOR y = 0 TO (MAXPOINTS / 2) - 1
   FOR x = 0 TO (MAXPOINTS / 2) - 1
    'Get record from file.
    GET #1, r%, t%

    'Get a useable number for the mess.
    p(y, x).z = (t% / 100)

    'Add t record counter.
    r% = r% + 1

   'Next point.
   NEXT x
  NEXT y
 'Close map file.
 CLOSE #1
END SUB

SUB MakeLookUps                                 'Use to create math lookup tables.
 'Make lookup tables.
 FOR i = 0 TO 360 - 1
  s!(i) = SIN(i * 6.28 / 360)
  c!(i) = COS(i * 6.28 / 360)
 NEXT i
END SUB

SUB Render                                      'Use to render all points.
DIM x, y, z AS SINGLE
DIM dx, dy AS INTEGER
'Loop through all points.
FOR ly = 0 TO (MAXPOINTS / 2) - 1
 FOR lx = 0 TO (MAXPOINTS / 2) - 1
    x = (-p(ly, lx).x * s!(Theta) + p(ly, lx).y * c!(Theta))
    y = (-p(ly, lx).x * c!(Theta) * s!(Phi) - p(ly, lx).y * s!(Theta) * s!(Phi) - p(ly, lx).z * c!(Phi))
    z = (-p(ly, lx).x * c!(Theta) * c!(Phi) - p(ly, lx).y * s!(Theta) * c!(Phi) + p(ly, lx).z * s!(Phi))

    IF (z + zcenter) <> 0 THEN
     dx = ((256 * (x / (z + zcenter))) * 10) + xcenter
     dy = ((256 * (y / (z + zcenter))) * 10) + ycenter

     IF LineON = YES THEN
      IF lx = 0 THEN PSET (dx, dy), p(ly, lx).c
      LINE -(dx, dy), p(ly, lx).c
     END IF

     sx = dx
     sy = dy
     PSET (dx, dy), p(ly, lx).c
    END IF
 NEXT lx
NEXT ly

'Loop through all points.
FOR lx = 0 TO (MAXPOINTS / 2) - 1
 FOR ly = 0 TO (MAXPOINTS / 2) - 1
    x = (-p(ly, lx).x * s!(Theta) + p(ly, lx).y * c!(Theta))
    y = (-p(ly, lx).x * c!(Theta) * s!(Phi) - p(ly, lx).y * s!(Theta) * s!(Phi) - p(ly, lx).z * c!(Phi))
    z = (-p(ly, lx).x * c!(Theta) * c!(Phi) - p(ly, lx).y * s!(Theta) * c!(Phi) + p(ly, lx).z * s!(Phi))

    IF (z + zcenter) <> 0 THEN
     dx = ((256 * (x / (z + zcenter))) * 10) + xcenter
     dy = ((256 * (y / (z + zcenter))) * 10) + ycenter

     IF LineON = YES THEN
      IF ly = 0 THEN PSET (dx, dy), p(ly, lx).c
      LINE -(dx, dy), p(ly, lx).c
     END IF

     sx = dx
     sy = dy
     PSET (dx, dy), p(ly, lx).c
    END IF
 NEXT ly
NEXT lx


END SUB

SUB ResetGrid                                   'Use to reset the display grid
 RANDOMIZE TIMER
 'Loop through all points.
 FOR y = 0 TO (MAXPOINTS / 2)
  FOR x = 0 TO (MAXPOINTS / 2)
   p(y, x).x = (x)
   p(y, x).y = (y)
   p(y, x).z = -(RND * 2)
   p(y, x).c = 2
  NEXT x
 NEXT y
END SUB

