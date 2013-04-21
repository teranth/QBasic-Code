DECLARE SUB MakeLookUps ()
DECLARE SUB DrawParticles ()
DECLARE SUB UpdateParts ()
DECLARE SUB LoadShape (sh AS STRING)

'------------------- Defines -------------------'
TYPE tPart
 x      AS INTEGER
 y      AS INTEGER
 z      AS INTEGER
 nx     AS INTEGER
 ny     AS INTEGER
 nz     AS INTEGER
 c      AS INTEGER
 here   AS INTEGER
END TYPE

CONST YES = -1
CONST NO = 0
CONST MAXPARTS = 80
CONST zcenter = 350
CONST xcenter = 160
CONST ycenter = 120

'Use Program in Demo mode. YES or NO
CONST DEMO = NO
                 
IF DEMO = YES THEN
 TIMER ON
 ON TIMER(6) GOSUB DEMOCHANGE
END IF

'----------------- Variables -------------------'
DIM SHARED p(MAXPARTS + 1) AS tPart
DIM SHARED pcount AS INTEGER
DIM SHARED Theta, Phi, Zang AS INTEGER
DIM SHARED c!(360), s!(360)
DIM SHARED LineON, RotON AS INTEGER

'---------------- Main Driver ------------------'
'Set variables.
Theta = 0
Phi = 0
LineON = NO
RotON = YES
pcount = 0

'Make math lookups.
MakeLookUps

'Reset particles.
FOR i = 0 TO MAXPARTS
 p(i).here = NO
 p(i).c = 2'INT(RND * 15) + 1
NEXT i

'Load test.
LoadShape "rand.sh"

'Give all particles a starting point
FOR i = 0 TO pcount - 1
 p(i).x = p(i).nx
 p(i).y = p(i).ny
 p(i).z = p(i).nz
NEXT i

'Set screen mode.
SCREEN 7, 0, 1, 0
DO
 CLS
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
    PRINT #1, (((-60) + INT(RND * 120)))
    PRINT #1, (((-60) + INT(RND * 120)))
    PRINT #1, (((-60) + INT(RND * 120)))
   NEXT i
   CLOSE #1
   LoadShape "rand.sh"
  CASE "2":
   LoadShape "Tri.sh"
  CASE "3":
   LoadShape "Box.sh"
  CASE "4":
   LoadShape "Box3d.sh"
  CASE "5":
   LoadShape "Tri3D.sh"
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

 UpdateParts
 DrawParticles
 PCOPY 1, 0

'End of main loop.
LOOP

'End of program code.
END

DEMOCHANGE:
 nc = INT(RND * 5)
 SELECT CASE nc
  CASE 0:
   RANDOMIZE TIMER
   n% = INT(RND * MAXPARTS) + 1
   OPEN "rand.sh" FOR OUTPUT AS #1
   PRINT #1, n%
   FOR i = 1 TO n%
    PRINT #1, (((-60) + INT(RND * 120)))
    PRINT #1, (((-60) + INT(RND * 120)))
    PRINT #1, (((-60) + INT(RND * 120)))
   NEXT i
   CLOSE #1
   LoadShape "rand.sh"
  CASE 1:
   LoadShape "Tri.sh"
  CASE 2:
   LoadShape "Box.sh"
  CASE 3:
   LoadShape "Box3d.sh"
  CASE 4:
   LoadShape "Tri3D.sh"
 END SELECT
RETURN

SUB DrawParticles                               'Use to render all particles.
 'Set counter to zero.
 c = 0

 'Loop through all particles and draw them.
 FOR i = 0 TO MAXPARTS
  'If particle is turned on render it.
  IF p(i).here = YES THEN
   'Add to counter.
   c = c + 1
  
   x = -p(i).x * s!(Theta) + p(i).y * c!(Theta)
   y = -p(i).x * c!(Theta) * s!(Phi) - p(i).y * s!(Theta) * s!(Phi) - p(i).z * c!(Phi)
   z = -p(i).x * c!(Theta) * c!(Phi) - p(i).y * s!(Theta) * c!(Phi) + p(i).z * s!(Phi)

   IF (z + zcenter) <> 0 THEN
    dx = 256 * (x / (z + zcenter)) + xcenter
    dy = 256 * (y / (z + zcenter)) + ycenter
    IF LineON = YES THEN
     IF c = 1 THEN
      PSET (dx, dy), 0
      sx = dx
      sy = dy
     ELSE
      LINE -(dx, dy), 2
     END IF
    END IF
    CIRCLE (dx, dy), 4, p(i).c
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
   IF p(i).x > p(i).nx THEN p(i).x = p(i).x - 1
   IF p(i).x < p(i).nx THEN p(i).x = p(i).x + 1
   IF p(i).y > p(i).ny THEN p(i).y = p(i).y - 1
   IF p(i).y < p(i).ny THEN p(i).y = p(i).y + 1
   IF p(i).z > p(i).nz THEN p(i).z = p(i).z - 1
   IF p(i).z < p(i).nz THEN p(i).z = p(i).z + 1

  'End of update for this particle.
  END IF
 'Next particle in list.
 NEXT i
END SUB

