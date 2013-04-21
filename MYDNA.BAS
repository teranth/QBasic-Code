'Set screen mode.
SCREEN 7, 0, 1, 0

rot = .01
ax = 160
ay = 100

'Start main loop.
DO
 CLS
 rot = rot + .01

 'Loop and draw all segments of DNA.
 FOR ay = 1 TO 200 STEP 5
  CIRCLE (ax + 80 * COS(rot - ay), ay + 20 * SIN(rot - ay)), 8, 1
  CIRCLE (ax + 70 * COS(rot - ay), ay + 18 * SIN(rot - ay)), 7, 2
  CIRCLE (ax + 60 * COS(rot - ay), ay + 16 * SIN(rot - ay)), 6, 3
  CIRCLE (ax + 50 * COS(rot - ay), ay + 14 * SIN(rot - ay)), 5, 4
  CIRCLE (ax + 40 * COS(rot - ay), ay + 12 * SIN(rot - ay)), 4, 5
  CIRCLE (ax + 30 * COS(rot - ay), ay + 10 * SIN(rot - ay)), 3, 6
  CIRCLE (ax + 20 * COS(rot - ay), ay + 8 * SIN(rot - ay)), 2, 7
  CIRCLE (ax + 10 * COS(rot - ay), ay + 6 * SIN(rot - ay)), 1, 8
  LINE (ax, ay)-(ax + 80 * COS(rot - ay), ay + 20 * SIN(rot - ay)), 9
 NEXT ay

 'copy buffer screen.
 PCOPY 1, 0

'Loop until someone hits a key.
LOOP UNTIL INKEY$ <> ""

