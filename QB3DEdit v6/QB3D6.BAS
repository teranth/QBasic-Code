DECLARE SUB AddPoint (c AS INTEGER)
DECLARE SUB DelPoint (c AS INTEGER)
DECLARE SUB CopyBuf (a() AS ANY, b() AS ANY, l AS INTEGER)
DECLARE SUB EffectSwirl (pow AS INTEGER)
DECLARE SUB EffectsMenu ()
DECLARE SUB EffectWarp (pow AS INTEGER)
DECLARE SUB DisplayHelp ()
DECLARE SUB LoadObject (filename AS STRING)
DECLARE SUB SaveObject (filename AS STRING)
'This program was written by Elias York.
'Date: 11/29/2002
'This is the new and updated 3D editor.

'----------------- New Data types --------------'
TYPE Pnt3D                                      'Start of Point3D data type.
        x       AS INTEGER                      'X cord of point.
        y       AS INTEGER                      'Y cord of point.
        z       AS INTEGER                      'Z cord of point.
        p       AS INTEGER                      'Dist from the center of the object.
END TYPE                                        'End of Point3D.
'------------------- Constents -----------------'
CONST zCenter = 350                             'Define center of z cord or how much to zoom.
CONST xCenter = 160                             'Define the center of the screen's x.
CONST yCenter = 120                             'Define center of the screen's y.

'------------------- Variables -----------------'
DIM SHARED NUMPOINTS AS INTEGER                 'Define Max points.
NUMPOINTS = 8                                   'Total number of points.
DIM SHARED pO(NUMPOINTS) AS Pnt3D               'Make a array for 3d points.
DIM SHARED pR(NUMPOINTS) AS Pnt3D               'Make a array for rotated 3d points.
DIM SHARED pC(NUMPOINTS) AS Pnt3D               'Make a copy temp array.
DIM theta AS SINGLE                             'Theta or XY rotation angle.
DIM phi AS SINGLE                               'Phi or Z rottion angle.
DIM Cpnt AS INTEGER                             'Define Current point.
DIM s!(360), c!(360)                            'Make cos and sin variables.
DIM SHARED ModelName$                           'Define model name variable.
'------------------ Main Driver ----------------'
'Set default model name.
ModelName$ = "New_model"

'Make lookup tables.
FOR Counter = 0 TO 360
 s!(Counter) = SIN(Counter * 6.28 / 360)       'Get sin value.
 c!(Counter) = COS(Counter * 6.28 / 360)       'Get cos value.
NEXT Counter

'Set screen mode to 320x240x16 with a back buffer.
SCREEN 7, 0, 1, 0

'Set to first point.
Cpnt = 0

'Load DATA into pO() array.
FOR Counter = 0 TO NUMPOINTS - 1
 'Read data in format ( x, y, z, p ).
 READ pO(Counter).x, pO(Counter).y, pO(Counter).z, pO(Counter).p
NEXT Counter

'Start of the main loop.
DO
 'Clear the screen.
 CLS

 'Start processing 3D points and rotating them.

 FOR Counter = 0 TO NUMPOINTS - 1
  'Rotate points.
  pR(Counter).x = -pO(Counter).x * s!(theta) + pO(Counter).y * c!(theta)
  pR(Counter).y = -pO(Counter).x * c!(theta) * s!(phi) - pO(Counter).y * s!(theta) * s!(phi) - pO(Counter).z * c!(phi) + pO(Counter).p
  pR(Counter).z = -pO(Counter).x * c!(theta) * c!(phi) - pO(Counter).y * s!(theta) * c!(phi) + pO(Counter).z * s!(phi)

  'Convert 3D points to 2D.
  IF (pR(Counter).z + zCenter) <> 0 THEN
   dx = 256 * (pR(Counter).x / (pR(Counter).z + zCenter)) + xCenter
   dy = 256 * (pR(Counter).y / (pR(Counter).z + zCenter)) + yCenter

   'Draw the point.
   IF Counter <> 0 THEN LINE -(dx, dy), 4
   PSET (dx, dy), 2
   CIRCLE (dx, dy), 5, 1

   'Draw current point selector and info.
   IF Counter = Cpnt THEN
    CIRCLE (dx, dy), 5, 2
    LOCATE 1, 1
    PRINT "Point X:"; pO(Cpnt).x
    PRINT "Point Y:"; pO(Cpnt).y
    PRINT "Point Z:"; pO(Cpnt).z
   END IF
  END IF

 'Add one counter.
 NEXT Counter

 'List controls.
 PRINT "Editing: "; ModelName$
 PRINT "(Q = X+1)(A = X-1)"
 PRINT "(W = Y+1)(S = Y-1)"
 PRINT "(E = Z+1)(D = Z-1)"
 PRINT "TAB for help"

 'Copy buffer to screen.
 PCOPY 1, 0

 'Rotate.

 IF theta < 360 - 1 THEN theta = theta + 1 ELSE theta = 0
 IF phi < 360 - 1 THEN phi = phi + 1 ELSE phi = 0

 'Look at keys.
 SELECT CASE UCASE$(INKEY$)
  CASE CHR$(27): EXIT DO
  CASE "-": 'Last Point.
   IF Cpnt > 0 THEN Cpnt = Cpnt - 1
  CASE "+": 'Next Point.
   IF Cpnt < NUMPOINTS - 1 THEN Cpnt = Cpnt + 1
  CASE "Q": 'X +
   pO(Cpnt).x = pO(Cpnt).x + 1
  CASE "A": 'X -
   pO(Cpnt).x = pO(Cpnt).x - 1
  CASE "W": 'Y +
   pO(Cpnt).y = pO(Cpnt).y + 1
  CASE "S": 'Y -
   pO(Cpnt).y = pO(Cpnt).y - 1
  CASE "E": 'Z +
   pO(Cpnt).z = pO(Cpnt).z + 1
  CASE "D": 'Z -
   pO(Cpnt).z = pO(Cpnt).z - 1
  CASE ">":
   SCREEN 13
   INPUT "Enter Filename to Load: ", filename$
   LoadObject filename$
   SCREEN 7, 0, 1, 0
  CASE "<":
   SCREEN 13
   INPUT "Enter Filename to Save: ", filename$
   SaveObject filename$
   SCREEN 7, 0, 1, 0
  CASE CHR$(9):
   DisplayHelp
  CASE "N":
   SCREEN 13
   INPUT "Enter name of model(No spaces): ", ModelName$
   SCREEN 7, 0, 1, 0
  CASE "`":
   EffectsMenu
  CASE "[":             'Add point command.
   AddPoint (Cpnt)
  CASE "]":             'Del point command.
   DelPoint (Cpnt)
 END SELECT

'End of main loop.
LOOP

'End of program code.
END

'Data seg here. Format is ( x, y, z, p )

'Side 1 of cube.
DATA -50, 50,-50, 1
DATA -50,-50,-50, 1
DATA  50,-50,-50, 1
DATA  50, 50,-50, 1

'Side 2 of cube.
DATA  50,-50, 50, 1
DATA -50,-50, 50, 1
DATA -50, 50, 50, 1
DATA  50, 50, 50, 1

SUB AddPoint (c AS INTEGER)

 REDIM pC(NUMPOINTS) AS Pnt3D

 'Make a copy of pO buffer into pC.
 CopyBuf pO(), pC(), NUMPOINTS - 1

 'Change max points.
 NUMPOINTS = NUMPOINTS + 1

 'Redim pO and pR arrays.
 REDIM pO(NUMPOINTS) AS Pnt3D
 REDIM pR(NUMPOINTS) AS Pnt3D

 CopyBuf pC(), pO(), NUMPOINTS - 2
END SUB

SUB CopyBuf (a() AS Pnt3D, b() AS Pnt3D, l AS INTEGER)
 FOR i = 0 TO l
  'Copy all point data to new buffer.
  b(i).x = a(i).x
  b(i).y = a(i).y
  b(i).z = a(i).z
  b(i).p = a(i).p
 NEXT i
END SUB

SUB DelPoint (c AS INTEGER)
 NUMPOINTS = NUMPOINTS - 1
END SUB

SUB DisplayHelp
 SCREEN 12                                      'Set screen mode to 12
 LOCATE 1, 1                                    'Move to top left on screen.

 'Show help stuff.
 PRINT "Welcome to S_3DEDIT Help Screen"
 PRINT
 PRINT "(+ = Next Point) - The + key selects the next point."
 PRINT "(- = Prev Point) - The - key selects the prev point."
 PRINT "(Q = X+1) - The Q Key adds one to the X of the current point."
 PRINT "(A = X-1) - The A Key subs one from the X of the current point."
 PRINT "(W = Y+1) - The W Key adds one to the Y of the current point."
 PRINT "(S = Y-1) - The S Key subs one from the Y of the current point."
 PRINT "(E = Z+1) - The E Key adds one to the Z of the current point."
 PRINT "(D = Z-1) - The D Key subs one from the Z of the current point."; ""
 PRINT "(ESCAPE KEY) - Exit the editor to OS."
 PRINT "(< = Save Object) - The < key saves the current model to a file."
 PRINT "(> = Load Object) - The > key loads the current model from a file."
 PRINT "(N = Name Model) - The N Keys lets you set the name of your model."
 PRINT "(` = Effects) - The ` Key lets you access the effects menu."

 DO                                             'Start loop.
 LOOP UNTIL INKEY$ <> ""                        'Wait for a key.
 SCREEN 7, 0, 1, 0                              'Reset screen mode.
END SUB

SUB EffectsMenu
 'Set screen mode for menu controls.
 SCREEN 12

 'Start menu loop.
 DO
  'Move cursor to 1,1 on screen.
  LOCATE 1, 1
  PRINT "------ Welcome to the Effects Menu ------"
  PRINT "1 - Warp effect."
  PRINT "2 - Swirl effect."
  PRINT "X - Quit effects menu."
  'Check for command keys.
  SELECT CASE UCASE$(INKEY$)
   CASE "X": EXIT DO
   CASE "1":                    'Warp effect.
    INPUT "Enter Power of Warp Effect: ", pow%
    EffectWarp INT(pow%)
    PRINT "Warp effect complete at power of"; pow%
    EXIT DO
   CASE "2":                    'Swirl effect.
    INPUT "Enter Power of Swirl Effect: ", pow%
    EffectSwirl INT(pow%)
    PRINT "Swirl effect complete at power of"; pow%
    EXIT DO

  END SELECT
 LOOP

 'Reset screen mode.
 SCREEN 7, 0, 1, 0
END SUB

SUB EffectSwirl (pow AS INTEGER)
 thetas = 0

 'Use every 3rd point.
 FOR i = 0 TO NUMPOINTS - 1 STEP 3
  'Get roatated points.
  dx = (pO(i).x * COS(pow + thetas) + pO(i).y * SIN(pow + thetas))
  dy = (pO(i).y * COS(pow + thetas) - pO(i).x * SIN(pow + thetas))

  'Save em.
  pO(i).x = dx
  pO(i).y = dy

  thetas = thetas + pow
 NEXT i
END SUB

SUB EffectWarp (pow AS INTEGER)
 'Make random numbers.
 RANDOMIZE TIMER

 'Start effect loop to edit all points.
 FOR i = 0 TO NUMPOINTS - 1
  'Change points x ,y and z.
  pO(i).x = pO(i).x + (-pow) + (RND * pow * 2)
  pO(i).y = pO(i).y + (-pow) + (RND * pow * 2)
  pO(i).z = pO(i).z + (-pow) + (RND * pow * 2)
 'Next point.
 NEXT i
END SUB

SUB LoadObject (filename AS STRING)
 OPEN filename FOR INPUT AS #1                  'Open file to read from.
  INPUT #1, ModelName$                          'Get model name from file (Not used yet)
  INPUT #1, NUMPOINTS                           'Get total number of points to load.

  'Redim arrays.
  REDIM pO(NUMPOINTS) AS Pnt3D                  'Redim points.
  REDIM pR(NUMPOINTS) AS Pnt3D                  'Redim points rotated.

  'Now time to read all points in the model.
  FOR Counter = 0 TO NUMPOINTS - 1              'Start point saving loop.
   INPUT #1, pO(Counter).x                      'Load point x.
   INPUT #1, pO(Counter).y                      'Load point y.
   INPUT #1, pO(Counter).z                      'Load point z.
   INPUT #1, pO(Counter).p                      'Load point p.
  NEXT Counter                                  'Next counter.
 CLOSE #1                                       'Close file now that we are done reading it.
END SUB

SUB SaveObject (filename AS STRING)
 OPEN filename FOR OUTPUT AS #1                 'Open file to save to.
  PRINT #1, ModelName$                          'Output model name.
  PRINT #1, NUMPOINTS                           'Save number of points used.

  'Now time to save all points in the model.
  FOR Counter = 0 TO NUMPOINTS - 1              'Start point saving loop.
   PRINT #1, pO(Counter).x                      'Save point(counter).x
   PRINT #1, pO(Counter).y                      'Save point(counter).y
   PRINT #1, pO(Counter).z                      'Save point(counter).z
   PRINT #1, pO(Counter).p                      'Save point(counter).p
  NEXT Counter                                  'Next counter.
 CLOSE #1                                       'Close file now that we are done saving infomation.
END SUB

