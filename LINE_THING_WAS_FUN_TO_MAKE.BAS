vx = 1
vy = 1
RANDOMIZE TIMER

TYPE p3d
x AS INTEGER
y AS INTEGER
z AS INTEGER
END TYPE

DIM ps(10) AS p3d

FOR i = 0 TO 10
 ps(i).x = RND * 100
 ps(i).y = RND * 100
 ps(i).z = RND * 100
NEXT i

SCREEN 7, 0, 1

DO
SELECT CASE INKEY$
CASE "a":                                      'Left
 vx = vx - 1
CASE "d":                                      'Right
 vx = vx + 1
CASE "w":                                      'Up
 vy = vy - 1
CASE "s":                                      'Down
 vy = vy + 1
CASE CHR$(27): END
END SELECT
GOSUB render
LOOP

render:
CLS
FOR i = 0 TO 10
 LINE (vx, vy)-(ps(i).x, ps(i).y), 2
NEXT i
PCOPY 1, 0
RETURN

