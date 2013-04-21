'Wave = SIN(x / p) * a
'
'Wave - Is the sine wave we can draw.
'x    - Is the x position of the current wave.
'p    - Distance in between the waves.
'a    - Is the size of the waves.

'This program was written by Elias York
'Date: 01/21/2003
'This is a SineWave example for Qbasic Class.

'------------------- Defines -------------------'
a = 100                                         'Set size of waves.
p = 10                                          'Set distance between waves.

'----------------- Main Driver -----------------'

'Set screen mode to 640x480x16
SCREEN 12

'Make very random numbers.
RANDOMIZE TIMER

'Clear screen.
CLS

'Start main loop.
DO

'Use print to auto scroll screen down one print line.
PRINT

'Start first sine wave drawing loop.
FOR i = 1 TO 99
 'Get wave position.
 wave = SIN(i / p) * a

 'Draw sine wave node.
 CIRCLE (300 + wave, 380 + i), 5, 2

'Next wave piece.
NEXT i

'Use print to auto scroll screen down one print line.
PRINT

'Start second sine wave drawing loop.
FOR i = 1 TO 99
 'Get wave position.
 wave = SIN(i / p) * a

 'Draw sine wave node.
 CIRCLE (300 + wave, 380 + i), 7, 4

'Next wave piece.
NEXT i

'Use print to auto scroll screen down one print line.
PRINT

'Start third sine wave drawing loop.
FOR i = 1 TO 99
 'Get wave position.
 wave = SIN(i / p) * a

 'Draw sine wave node.
 CIRCLE (300 + -wave, 380 + i), 7, 1

'Next wave piece.
NEXT i

'Use print to auto scroll screen down one print line.
PRINT

'Start forth sine wave drawing loop.
FOR i = 1 TO 99
 'Get wave position.
 wave = SIN(i / p) * a

 'Draw sine wave node.
 CIRCLE (300 + -wave, 380 + i), 3, 3

'Next wave piece.
NEXT i

'Use print to auto scroll screen down one print line.
PRINT

'Change variables for Size and width.
GOSUB Change

'End of main loop wait for a key press.
LOOP UNTIL INKEY$ <> ""

'End program code here.
END

'Used to change the variables to make the sinewaves look neat.
Change:
 'Change a or size of the waves.
 a = a + RND * 5

 'Change p or the time inbetween waves.
 p = p + RND * 5

 'Make sure they are not too big and if they are fix it.
 IF p > 60 THEN p = 1
 IF a > 60 THEN a = 1

'Return from fake sub.
RETURN

