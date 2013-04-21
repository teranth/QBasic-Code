DECLARE SUB MakeLookUps ()
DECLARE SUB DrawParticles ()
DECLARE SUB UpdateParts ()
DECLARE SUB LoadShape (sh AS STRING)

'------------------- Defines -------------------'
TYPE tPart
 x      AS SINGLE
 y      AS SINGLE
 z      AS SINGLE
 nx     AS SINGLE
 ny     AS SINGLE
 nz     AS SINGLE
 lx     AS SINGLE
 ly     AS SINGLE
 c      AS INTEGER
 here   AS INTEGER
END TYPE

CONST YES = -1
CONST NO = 0
CONST MAXPARTS = 480
CONST zcenter = 15
CONST xcenter = 160
CONST ycenter = 120
CONST MoveSpeed = 2
CONST PartSpeed = .05
CONST DEMO = NO

'----------------- Variables -------------------'
DIM SHARED p(MAXPARTS + 1) AS tPart
DIM SHARED pcount AS INTEGER
DIM SHARED Theta, Phi, Zang AS INTEGER
DIM SHARED c!(360), s!(360)
DIM SHARED LineON, RotON, CirON AS INTEGER

'---------------- Main Driver ------------------'
'Set variables.
Theta = 0
Phi = 0
LineON = NO
RotON = YES
CirON = NO
pcount = 0

'Make math lookups.
MakeLookUps

'Reset particles.
FOR i = 0 TO MAXPARTS
 p(i).here = NO
 p(i).c = 2'INT(RND * 15) + 1
NEXT i

'Load test.
LoadShape "cir.sh"

'Give all particles a starting point
FOR i = 0 TO pcount - 1
 p(i).x = p(i).nx
 p(i).y = p(i).ny
 p(i).z = p(i).nz
NEXT i

'Set screen mode.
SCREEN 7, 0, 1, 0
DO
 'CLS
 SELECT CASE UCASE$(INKEY$)
  CASE CHR$(27): EXIT DO
  CASE "L": IF LineON = YES THEN LineON = NO ELSE LineON = YES
  CASE "R": IF RotON = YES THEN RotON = NO ELSE RotON = YES
  CASE "W":                                     'Rot Up
   Phi = Phi + 5
  CASE "S":                                     'Rot Down
   Phi = Phi - 5
  CASE "A":                                     'Rot Left
   Theta = Theta - 5
  CASE "D":                                     'Rot Right
   Theta = Theta + 5
  CASE "1":
   RANDOMIZE TIMER
   n% = INT(RND * MAXPARTS) + 1
   OPEN "rand.sh" FOR OUTPUT AS #1
   PRINT #1, n%
   FOR i = 1 TO n%
    PRINT #1, (((-10) + INT(RND * 20)))
    PRINT #1, (((-10) + INT(RND * 20)))
    PRINT #1, (((-10) + INT(RND * 20)))
   NEXT i
   CLOSE #1
   LoadShape "rand.sh"
  CASE "2":
   'Reset particles.
   FOR i = 0 TO MAXPARTS
    p(i).here = NO
    p(i).c = INT(RND * 15) + 1
   NEXT i
   LoadShape "Cir.sh"
  CASE "3":
   'Reset particles.
   FOR i = 0 TO MAXPARTS
    p(i).here = NO
    p(i).c = INT(RND * 15) + 1
   NEXT i
   LoadShape "Tor.sh"
  CASE "4":
   'Reset particles.
   FOR i = 0 TO MAXPARTS
    p(i).here = NO
    p(i).c = INT(RND * 15) + 1
   NEXT i
   LoadShape "tube.sh"
 END SELECT

 'Rotate if set to yes.
 IF RotON = YES THEN
  'Update rotation.
  Theta = Theta + 1
  Phi = Phi + 1
 END IF

 'Make sure rotation is not too big.
 IF Theta >= 359 THEN Theta = 1
 IF Phi >= 359 THEN Phi = 1
 IF Theta <= 0 THEN Theta = 359
 IF Phi <= 0 THEN Phi = 359

 'Update at current speed.
 FOR ud = 0 TO MoveSpeed
  UpdateParts
 NEXT ud


 DrawParticles
 PCOPY 1, 0

'End of main loop.
LOOP

'End of program code.
END

SUB DrawParticles                               'Use to render all particles.
 'Set counter to zero.
 c = 0

 'Loop through all particles and draw them.
 FOR i = 0 TO MAXPARTS
  'If particle is turned on render it.
  IF p(i).here = YES THEN
   PSET (p(i).lx, p(i).ly), 0

   'Add to counter.
   c = c + 1
  
   x = -p(i).x * s!(Theta) + p(i).y * c!(Theta)
   y = -p(i).x * c!(Theta) * s!(Phi) - p(i).y * s!(Theta) * s!(Phi) - p(i).z * c!(Phi)
   z = -p(i).x * c!(Theta) * c!(Phi) - p(i).y * s!(Theta) * c!(Phi) + p(i).z * s!(Phi)

   IF (z + zcenter) <> 0 THEN
    dx = 256 * (x / (z + zcenter)) + xcenter
    dy = 256 * (y / (z + zcenter)) + ycenter

    'Save last x and y for later.
    p(i).lx = dx
    p(i).ly = dy

    'Check for line draw mode.
    IF LineON = YES THEN
     IF c = 1 THEN
      PSET (dx, dy), 0
      sx = dx
      sy = dy
     ELSE
      LINE -(dx, dy), 2
     END IF
    END IF
    IF CirON = YES THEN CIRCLE (dx, dy), 4, p(i).c ELSE PSET (dx, dy), p(i).c
   END IF

  'End of check.
  END IF
 'Next particle in the list.
 NEXT i

 'Draw last line.
 IF LineON = YES THEN LINE (dx, dy)-(sx, sy), 2

 'Output number of points being used.
 LOCATE 1, 1: PRINT "Num: "; c
END SUB

SUB LoadShape (sh AS STRING)                    'Use to load a shape file.
 OPEN sh FOR INPUT AS #1                        'Open shape file for input as #1.
  INPUT #1, pcount                              'Get particle count.
  IF pcount > MAXPARTS THEN pcount = MAXPARTS   'Make sure there are not too many particles to use.

  'Loop through and load all particles.
  FOR i = 0 TO pcount - 1
   'Get new particle x.
   INPUT #1, nx
   'Get new particle y.
   INPUT #1, ny
   'Get new particle z.
   INPUT #1, nz

   'Set new particle x, y and z in movement commands.
   p(i).nx = nx
   p(i).ny = ny
   p(i).nz = nz

   'Turn particle on.
   p(i).here = YES

  'Next particle in list.
  NEXT i

  'Loop through all particles.
  FOR i = pcount TO MAXPARTS
   'Set extra particle a spot to move to.
   np = INT(RND * (pcount - 1))

   'Set new point.
   p(i).nx = p(np).nx
   p(i).ny = p(np).ny
   p(i).nz = p(np).nz

   'Turn particle off because it is extra.
   p(i).here = YES

  'Next particle in list.
  NEXT i

 'Close file.
 CLOSE #1
END SUB

SUB MakeLookUps                                 'Use to create math lookup tables.
 'Make lookup tables.
 FOR i = 0 TO 360 - 1
  s!(i) = SIN(i * 6.28 / 360)
  c!(i) = COS(i * 6.28 / 360)
 NEXT i
END SUB

SUB UpdateParts                                 'Use to update all particles.
 'Loop through all particles and update them.
 FOR i = 0 TO MAXPARTS
  'If particle is turned on then update it.
  IF p(i).here = YES THEN
   'Move particle towards new point.
   IF p(i).x > p(i).nx THEN p(i).x = p(i).x - PartSpeed
   IF p(i).x < p(i).nx THEN p(i).x = p(i).x + PartSpeed
   IF p(i).y > p(i).ny THEN p(i).y = p(i).y - PartSpeed
   IF p(i).y < p(i).ny THEN p(i).y = p(i).y + PartSpeed
   IF p(i).z > p(i).nz THEN p(i).z = p(i).z - PartSpeed
   IF p(i).z < p(i).nz THEN p(i).z = p(i).z + PartSpeed

  'End of update for this particle.
  END IF
 'Next particle in list.
 NEXT i
END SUB

