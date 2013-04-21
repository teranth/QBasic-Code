'This program was written by Elias York.
'Date: 12/10/2002
'This is a rotating example for Qbasic class.

'-------------------- Main Driver -----------------------'
'Set screen mode to 640x480x16
SCREEN 12

'Set rotate angle variable to starting default.
ang = .01
x = 100
y = 100
CenterX = 320
CenterY = 240

'Start of main loop.
DO
 
 'Get x and y rotated.
 dx = (x * COS(ang) + SIN(ang) * y) + CenterX
 dy = (y * SIN(ang) - COS(ang) * x) + CenterY
 dx2 = (x * COS(ang - 5) + SIN(ang - 5) * y) + CenterX / 1.4
 dy2 = (y * SIN(ang - 5) - COS(ang - 5) * x) + CenterY / 1.4


 'Draw object.
 LINE (CenterX, CenterY)-(dx, dy), 1
 LINE (CenterX, CenterY)-(-dx + CenterX * 2, -dy + CenterY * 2), 7
 CIRCLE (dx, dy), RND * 15, RND * 15
 CIRCLE (-dx + CenterX * 2, -dy + CenterY * 2), RND * 15, RND * 15

 'Draw object 2
 LINE (CenterX, CenterY)-(dx2, dy2), 2
 LINE (CenterX, CenterY)-(-dx2 + CenterX * 2, -dy2 + CenterY * 2), 4
 CIRCLE (dx2, dy2), RND * 15, RND * 15
 CIRCLE (-dx2 + CenterX * 2, -dy2 + CenterY * 2), RND * 15, RND * 15

 'Make spark lines.
 LINE (dx, dy)-(dx + (-40 + RND * 80), dy + (-40 + RND * 80)), RND * 15
 LINE (dx2, dy2)-(dx2 + (-40 + RND * 80), dy2 + (-40 + RND * 80)), RND * 15
 
 'Use return code to force screen to scroll down (Easy and cheap)
 PRINT

 'Change angle.
 ang = ang + .02

'Loop until key pressed.
LOOP UNTIL INKEY$ <> ""

