'This program was written by Elias York.
'Date: 03/06/2002 Time: 05:03:12 AM
'This program will draw a circle and then
'change it's size.

'---------------------- Main Driver ----------------------
SCREEN 12                        'Set screen mode to 640x480x16
'Set start up vars.
d = 0                            'Set start direction to smaller.
size = 10                        'Set start size to 10 around.
DO                               'Start main loop.
'Get ride of old circle.                              
CIRCLE (320, 240), size, 0       'Erase old circle. by drawing a black one.
IF d = 0 THEN size = size - 1    'If direction is 0 make circle smaller.
IF d = 1 THEN size = size + 1    'If direction is 1 make circle bigger.
'Make sure the size is useable.
IF size > 330 THEN d = 0         'it's getting too big so make smaller.
IF size < 1 THEN d = 1           'it's getting too small so make bigger.
'Draw new circle.
CIRCLE (320, 240), size, 2       'Draw new circle with new size.
LINE (320, 240)-(RND * 639, RND * 479), RND * 15
LOCATE 15, 31: PRINT "Qbasic Programming!" 'Print stupid text in the middle. :)
LOOP UNTIL INKEY$ <> ""          'Loop while no key has been pressed.

