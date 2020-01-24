import pyglet
import math


############################################# window #############################################
def window(x = 640, y = 600, caption = 'window', resizeable = False):

    return pyglet.window.Window(width= x, height=y, caption=caption, resizable= resizeable,
                                style= pyglet.window.Window.WINDOW_STYLE_DEFAULT)

class Window(pyglet.window.Window):

    def __repr__(self):
        return pyglet.window.Window


def window_DIALOG(x, y, caption = 'window', resizeable = False):

    return pyglet.window.Window(width= x, height=y, caption=caption, resizable= resizeable,
                                style= pyglet.window.Window.WINDOW_STYLE_DIALOG)

def window_TOOL(x, y, caption = 'window', resizeable = False):

    return pyglet.window.Window(width= x, height=y, caption=caption, resizable= resizeable,
                                style= pyglet.window.Window.WINDOW_STYLE_TOOL)

def window_BORDERLESS(x, y, caption = 'window', resizeable = False):

    return pyglet.window.Window(width= x, height=y, caption=caption, resizable= resizeable,
                                style= pyglet.window.Window.WINDOW_STYLE_BORDERLESS)

def change_window_caption(window, title):
    window.set_caption(title)

def take_screenshot(name):
    pyglet.image.get_buffer_manager().get_color_buffer().save(name + '.png')

def background(r, g, b):
    background_color = (r/255, g/255, b/255, 1)
    pyglet.gl.gl.glClearColor(*background_color)

def checker_pattern(window, color1, color2, size):
    if size//2 * 2 != size:
        checker_image_pattern = pyglet.image.CheckerImagePattern(color1=color1, color2=color2)
        image = pyglet.image.create(size + 1, size + 1, checker_image_pattern)
        background = pyglet.image.TileableTexture.create_for_image(image)
        background.blit_tiled(0, 0, 0, window.width, window.height)

    else:
        checker_image_pattern = pyglet.image.CheckerImagePattern(color1=color1, color2=color2)
        image = pyglet.image.create(size, size, checker_image_pattern)
        background = pyglet.image.TileableTexture.create_for_image(image)
        background.blit_tiled(0, 0, 0, window.width, window.height)


def no_overlap():
    pyglet.gl.gl.glClear(pyglet.gl.gl.GL_COLOR_BUFFER_BIT)

############################################# images #############################################
def resize_image_square(image, size):
    image.texture.width = size
    image.texture.height = size


def resize_image(image, scale):
    image.texture.width = (image.width) * scale
    image.texture.height = (image.height) * scale

def load_image(image):
    return pyglet.image.load(image)


############################################# text #############################################
def text(string, X, Y,  size = 18, font = 'Arial', color = (255, 255, 255), transparency = 255, anchorX = -1, anchorY = -1):
    if anchorX == -1 or anchorY == -1:
        text = pyglet.text.Label(string,
                                 font_name = font,
                                 font_size = size,
                                 x = X, y = Y,
                                 color= (color[0], color[1], color[2], transparency))
        text.draw()

    elif anchorX != -1 and anchorY == -1:
        text = pyglet.text.Label(string,
                                 font_name=font,
                                 font_size=size,
                                 x=X, y=Y,
                                 anchor_x= anchorX,
                                 color=(color[0], color[1], color[2], transparency))
        text.draw()

    elif anchorX == -1 and anchorY != -1:
        text = pyglet.text.Label(string,
                                 font_name=font,
                                 font_size=size,
                                 x=X, y=Y,
                                 anchor_y= anchorY,
                                 color=(color[0], color[1], color[2], transparency))
        text.draw()

    elif anchorX != -1 and anchorY != -1:
        text = pyglet.text.Label(string,
                                 font_name=font,
                                 font_size=size,
                                 x=X, y=Y,
                                 anchor_x = anchorX, anchor_y= anchorY,
                                 color=(color[0], color[1], color[2], transparency))
        text.draw()


def take_out_last_char(string):
    temp = ''
    for i in range(len(string) - 1):
        temp += string[i]

    string = ''
    string += temp
    return string

def get_key(key):
    if key.upper() == 'Q':
        return pyglet.window.key.Q
    elif key.upper() == 'W':
        return pyglet.window.key.W
    elif key.upper() == 'E':
        return pyglet.window.key.E
    elif key.upper() == 'R':
        return pyglet.window.key.R
    elif key.upper() == 'T':
        return pyglet.window.key.T
    elif key.upper() == 'Y':
        return pyglet.window.key.Y
    elif key.upper() == 'U':
        return pyglet.window.key.U
    elif key.upper() == 'I':
        return pyglet.window.key.I
    elif key.upper() == 'O':
        return pyglet.window.key.O
    elif key.upper() == 'P':
        return pyglet.window.key.P
    elif key.upper() == 'L':
        return pyglet.window.key.L
    elif key.upper() == 'K':
        return pyglet.window.key.K
    elif key.upper() == 'J':
        return pyglet.window.key.J
    elif key.upper() == 'H':
        return pyglet.window.key.H
    elif key.upper() == 'G':
        return pyglet.window.key.G
    elif key.upper() == 'F':
        return pyglet.window.key.F
    elif key.upper() == 'D':
        return pyglet.window.key.D
    elif key.upper() == 'S':
        return pyglet.window.key.S
    elif key.upper() == 'A':
        return pyglet.window.key.A
    elif key.upper() == 'Z':
        return pyglet.window.key.Z
    elif key.upper() == 'X':
        return pyglet.window.key.X
    elif key.upper() == 'C':
        return pyglet.window.key.C
    elif key.upper() == 'V':
        return pyglet.window.key.V
    elif key.upper() == 'B':
        return pyglet.window.key.B
    elif key.upper() == 'N':
        return pyglet.window.key.N
    elif key.upper() == 'M':
        return pyglet.window.key.M

    elif key == '1':
        return pyglet.window.key._1
    elif key == '2':
        return pyglet.window.key._2
    elif key == '3':
        return pyglet.window.key._3
    elif key == '4':
        return pyglet.window.key._4
    elif key == '5':
        return pyglet.window.key._5
    elif key == '6':
        return pyglet.window.key._6
    elif key == '7':
        return pyglet.window.key._7
    elif key == '8':
        return pyglet.window.key._8
    elif key == '9':
        return pyglet.window.key._9
    elif key == '0':
        return pyglet.window.key._0

    elif key.casefold() == 'enter':
        return pyglet.window.key.ENTER
    elif key.casefold() == 'return':
        return pyglet.window.key.RETURN
    elif key.casefold() == 'space' or key.casefold() == 'space bar' or key.casefold() == 'spacebar':
        return pyglet.window.key.SPACE
    elif key.casefold() == 'backspace':
        return pyglet.window.key.BACKSPACE
    elif key.casefold() == 'delete':
        return pyglet.window.key.DELETE
    elif key.casefold() == 'minus':
        return pyglet.window.key.MINUS
    elif key.casefold() == 'equal':
        return pyglet.window.key.EQUAL
    elif key.casefold() == 'backslash':
        return pyglet.window.key.BACKSLASH
    elif key.casefold() == 'left' or key.casefold() == 'left arrow':
        return pyglet.window.key.LEFT
    elif key.casefold() == 'right' or key.casefold() == 'right arrow':
        return pyglet.window.key.RIGHT
    elif key.casefold() == 'up' or key.casefold() == 'up arrow':
        return pyglet.window.key.UP
    elif key.casefold() == 'down' or key.casefold() == 'down arrow':
        return pyglet.window.key.DOWN
    elif key.casefold() == 'home':
        return pyglet.window.key.HOME
    elif key.casefold() == 'end':
        return pyglet.window.key.END
    elif key.casefold() == 'pageup':
        return pyglet.window.key.PAGEUP
    elif key.casefold() == 'pagedown':
        return pyglet.window.key.PAGEDOWN

    elif key.casefold() == 'f1':
        return pyglet.window.key.F1
    elif key.casefold() == 'f2':
        return pyglet.window.key.F2
    elif key.casefold() == 'f3':
        return pyglet.window.key.F3
    elif key.casefold() == 'f4':
        return pyglet.window.key.F4
    elif key.casefold() == 'f5':
        return pyglet.window.key.F5
    elif key.casefold() == 'f6':
        return pyglet.window.key.F6
    elif key.casefold() == 'f7':
        return pyglet.window.key.F7
    elif key.casefold() == 'f8':
        return pyglet.window.key.F8
    elif key.casefold() == 'f9':
        return pyglet.window.key.F9
    elif key.casefold() == 'f10':
        return pyglet.window.key.F10
    elif key.casefold() == 'f11':
        return pyglet.window.key.F11
    elif key.casefold() == 'f12':
        return pyglet.window.key.F12

    elif key.casefold() == 'num1':
        return pyglet.window.key.NUM_1
    elif key.casefold() == 'num2':
        return pyglet.window.key.NUM_2
    elif key.casefold() == 'num3':
        return pyglet.window.key.NUM_3
    elif key.casefold() == 'num4':
        return pyglet.window.key.NUM_4
    elif key.casefold() == 'num5':
        return pyglet.window.key.NUM_5
    elif key.casefold() == 'num6':
        return pyglet.window.key.NUM_6
    elif key.casefold() == 'num7':
        return pyglet.window.key.NUM_7
    elif key.casefold() == 'num8':
        return pyglet.window.key.NUM_8
    elif key.casefold() == 'num9':
        return pyglet.window.key.NUM_9
    elif key.casefold() == 'num0':
        return pyglet.window.key.NUM_0

    elif key.casefold() == 'num equal':
        return pyglet.window.key.NUM_EQUAL
    elif key.casefold() == 'num divide':
        return pyglet.window.key.NUM_DIVIDE
    elif key.casefold() == 'num multiply':
        return pyglet.window.key.NUM_MULTIPLY
    elif key.casefold() == 'num subtract':
        return pyglet.window.key.NUM_SUBTRACT
    elif key.casefold() == 'num add':
        return pyglet.window.key.NUM_ADD
    elif key.casefold() == 'num decimal':
        return pyglet.window.key.NUM_DECIMAL
    elif key.casefold() == 'num enter':
        return pyglet.window.key.NUM_ENTER

    elif key.casefold() == 'lcontrol' or  key.casefold() == 'lctrl' or key.casefold() == 'left control' or key.casefold() == 'left ctrl':
        return pyglet.window.key.LCTRL

    elif key.casefold() == 'rcontrol' or  key.casefold() == 'rctrl' or key.casefold() == 'right control' or key.casefold() == 'right ctrl':
        return pyglet.window.key.RCTRL

    elif key.casefold() == 'rshift' or key.casefold() == 'right shift':
        return pyglet.window.key.RSHIFT
    elif key.casefold() == 'lshift' or key.casefold() == 'left shift':
        return pyglet.window.key.LSHIFT

    elif key.casefold() == 'lalt' or key.casefold() == 'left alt':
        return pyglet.window.key.LALT
    elif key.casefold() == 'ralt' or key.casefold() == 'right alt':
        return pyglet.window.key.RALT

    elif key.casefold() == 'alt':
        return pyglet.window.key.MOD_ALT
    elif key.casefold() == 'ctrl' or key.casefold() == 'control':
        return pyglet.window.key.MOD_CTRL
    elif key.casefold() == 'shift':
        return pyglet.window.key.MOD_SHIFT
    elif key.casefold() == 'windows':
        return pyglet.window.key.MOD_WINDOWS
    elif key.casefold() == 'command':
        return pyglet.window.key.MOD_COMMAND
    elif key.casefold() == 'option':
        return pyglet.window.key.MOD_OPTION
    elif key.casefold() == 'capslock' or key.casefold() == 'caps lock':
        return pyglet.window.key.MOD_CAPSLOCK
    elif key.casefold() == 'numlock' or key.casefold() == 'num lock':
        return pyglet.window.key.MOD_NUMLOCK
    elif key.casefold() == 'scrolllock' or key.casefold() == 'scroll lock':
        return pyglet.window.key.MOD_SHIFT
    elif key.casefold() == 'scrolllock' or key.casefold() == 'scroll lock':
        return pyglet.window.key.MOD_SHIFT
    elif key.casefold() == 'accel':
        return pyglet.window.key.MOD_ACCEL

def replace(text, origional, new):
    text.replace(origional, new)
    return text

############################################# 2d shapes #############################################

def stroke():
    stroke.has_been_called = True # says that the stroke() function has been called
    # pass
stroke.has_been_called = False # returns false if stroke() hasn't been called


def point(x, y, color = (255, 255, 255,)):
    translated_color = color[0], color[1], color[2] # you need to write the color once for each vertex

    point = pyglet.graphics.vertex_list(1,
                                      ('v2i', (x, y)),
                                      ('c3B', translated_color))
    point.draw(pyglet.gl.GL_POINTS)

def points(points = (), color = (255, 255, 255)):

    points = pyglet.graphics.vertex_list(len(points) // 2,
                                         ('v2i', points),
                                         ('c3B', color * (len(points) // 2)))

    points.draw(pyglet.gl.GL_POINTS)

def line(x1, y1, x2, y2, color = (255, 255, 255), width = 1):
    translated_color = color[0], color[1], color[2], \
                       color[0], color[1], color[2]  # you need to write the color for each vertex

    pyglet.gl.glLineWidth(width)
    line = pyglet.graphics.vertex_list(2,
                                             ('v2i', (x1, y1, x2, y2)),
                                             ('c3B', translated_color)
                                             )
    line.draw(pyglet.gl.GL_LINES)


def triangle(x1, y1, x2, y2, x3, y3, color = (255, 255, 255)):
    translated_color = color[0], color[1], color[2], \
                       color[0], color[1], color[2], \
                       color[0], color[1], color[2] # you need to write the color once for each vertex

    tri = pyglet.graphics.vertex_list(3,
                                      ('v2i', (x1, y1, x2, y2, x3, y3)),
                                      ('c3B', translated_color))
    tri.draw(pyglet.gl.GL_TRIANGLES)


def rect(x, y, width, height, color = (255, 255, 255), strokewidth = 2, transparency = 0):
    translated_color = color[0], color[1], color[2], \
                       color[0], color[1], color[2], \
                       color[0], color[1], color[2], \
                       color[0], color[1], color[2]  # you need to write the color once for each vertex

    if stroke.has_been_called:
        quad2 = pyglet.graphics.vertex_list(4,
                                           ('v2i', (x - strokewidth, y - strokewidth, # bottom left
                                                    x + width + strokewidth, y - strokewidth, # bottom right
                                                    x + width + strokewidth, y + height + strokewidth, # top right
                                                    x - strokewidth, y + height + strokewidth)), # top left
                                           ('c3B', (0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0)))

        quad2.draw(pyglet.gl.GL_QUADS)
    quad = pyglet.graphics.vertex_list(4,
                                       ('v2i', (x, y,        x+width, y,  x+width, y+height,  x, y+height)),
                                       ('c3B', translated_color))
    quad.draw(pyglet.gl.GL_QUADS)



def quad(x1, y1, x2, y2, x3, y3, x4, y4, color = (255, 255, 255)):
    translated_color = color[0], color[1], color[2], \
                       color[0], color[1], color[2], \
                       color[0], color[1], color[2], \
                       color[0], color[1], color[2]  # you need to write the color once for each vertex

    quad = pyglet.graphics.vertex_list(4,
                                       ('v2i', (x1, y1, x2, y2, x3, y3, x4, y4)),
                                       ('c3B', translated_color))
    quad.draw(pyglet.gl.GL_QUADS)


def rect_with_gradient_bottom_top(x, y, width, height, color1 = (255, 255, 255), color2 = (255, 255, 255), strokewidth = 2):

    if stroke.has_been_called:
        quad2 = pyglet.graphics.vertex_list(4,
                                           ('v2i', (x - strokewidth, y - strokewidth, # bottom left
                                                    x + width + strokewidth, y - strokewidth, # bottom right
                                                    x + width + strokewidth, y + height + strokewidth, # top right
                                                    x - strokewidth, y + height + strokewidth)), # top left
                                           ('c3B', (0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0)))

        quad2.draw(pyglet.gl.GL_QUADS)

    quad = pyglet.graphics.vertex_list(4,
                                       ('v2i', (x, y, x + width, y, x + width, y + height, x, y + height)),
                                       ('c3B', (color1[0], color1[1], color1[2],   #bottom left
                                                color1[0], color1[1], color1[2],   #bottom right
                                                color2[0], color2[1], color2[2],   #top right
                                                color2[0], color2[1], color2[2]))) #top left
    quad.draw(pyglet.gl.GL_QUADS)


def rect_with_gradient_left_right(x, y, width, height, color1 = (255, 255, 255), color2 = (255, 255, 255), strokewidth = 2):

    if stroke.has_been_called:
        quad2 = pyglet.graphics.vertex_list(4,
                                           ('v2i', (x - strokewidth, y - strokewidth, # bottom left
                                                    x + width + strokewidth, y - strokewidth, # bottom right
                                                    x + width + strokewidth, y + height + strokewidth, # top right
                                                    x - strokewidth, y + height + strokewidth)), # top left
                                           ('c3B', (0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0)))

        quad2.draw(pyglet.gl.GL_QUADS)

    quad = pyglet.graphics.vertex_list(4,
                                       ('v2i', (x, y, x + width, y, x + width, y + height, x, y + height)),
                                       ('c3B', (color1[0], color1[1], color1[2],   #bottom left
                                                color2[0], color2[1], color2[2],   #bottom right
                                                color2[0], color2[1], color2[2],   #top right
                                                color1[0], color1[1], color1[2]))) #top left
    quad.draw(pyglet.gl.GL_QUADS)


def circle(x, y, diameter, color = (255, 255, 255), strokewidth = 2):
    """
    We want a pixel perfect circle. To get one,
    we have to approximate it densely with triangles.
    Each triangle thinner than a pixel is enough
    to do it. Sin and cosine are calculated once
    and then used repeatedly to rotate the vector.
    I dropped 10 iterations intentionally for fun.
    """

    if stroke.has_been_called:
        radius = (diameter / 2) + strokewidth
        pyglet.gl.glColor3f(0, 0, 0)

        iterations = int(2 * radius * math.pi)
        s = math.sin(2 * math.pi / iterations)
        c = math.cos(2 * math.pi / iterations)

        dx, dy = radius, 0

        pyglet.gl.glBegin(pyglet.gl.GL_TRIANGLE_FAN)
        pyglet.gl.glVertex2f(x, y)
        for i in range(iterations + 1):
            pyglet.gl.glVertex2f(x + dx, y + dy)
            dx, dy = (dx * c - dy * s), (dy * c + dx * s)
        pyglet.gl.glEnd()



    radius = diameter / 2
    pyglet.gl.glColor3f(color[0]/255, color[1]/255, color[2]/255)

    iterations = int(2*radius*math.pi)
    s = math.sin(2*math.pi / iterations)
    c = math.cos(2*math.pi / iterations)

    dx, dy = radius, 0

    pyglet.gl.glBegin(pyglet.gl.GL_TRIANGLE_FAN)
    pyglet.gl.glVertex2f(x, y)
    for i in range(iterations + 1):
        pyglet.gl.glVertex2f(x+dx, y+dy)
        dx, dy = (dx*c - dy*s), (dy*c + dx*s)
    pyglet.gl.glEnd()



def part_circle(x, y, diameter, fraction, color = (255, 255, 255)):

    realfrac = 1 - (fraction / 100)

    radius = diameter / 2
    circumference = diameter * math.pi
    pyglet.gl.glColor3f(color[0] / 255, color[1] / 255, color[2] / 255)

    iterations = int(2 * radius * math.pi)
    s = math.sin(2 * math.pi / iterations)
    c = math.cos(2 * math.pi / iterations)

    dx, dy = radius, 0

    pyglet.gl.glBegin(pyglet.gl.GL_TRIANGLE_FAN)
    pyglet.gl.glVertex2f(x, y)
    for i in range((iterations + 1) - (round(circumference * realfrac))): #specifies the amount of the circle to take away
        pyglet.gl.glVertex2f(x + dx, y + dy)
        dx, dy = (dx * c - dy * s), (dy * c + dx * s)
    pyglet.gl.glEnd()


def bezier_curve_3(point1, point2, point3, color= (255, 255, 255)):

    pyglet.gl.glColor3f(color[0] / 255, color[1] / 255, color[2] / 255)

    nNumPoints = 3

    ctrlPoints = (pyglet.gl.GLfloat * 3 * 4)((point1[0], point1[1], 0.0),  # End Point

                                             (point3[0], point3[1], 0.0),  # Control Point

                                             (point2[0], point2[1], 0.0))  # End Point

    # This function is used to superimpose the control points over the curve

    def DrawPoints():
        # Set point size larger to make more visible

        # Loop through all control points for this example

        pyglet.gl.glBegin(pyglet.gl.GL_POINTS)

        pyglet.gl.glVertex2fv(ctrlPoints[0])
        pyglet.gl.glVertex2fv(ctrlPoints[2])

        pyglet.gl.glEnd()

    # Sets up the bezier

    # This actually only needs to be called once and could go in

    # the setup function

    pyglet.gl.glMap1f(pyglet.gl.GL_MAP1_VERTEX_3,  # Type of data generated

                      0.0,  # Lower u range

                      100.0,  # Upper u range

                      3,  # Distance between points in the data

                      nNumPoints,  # number of control points

                      ctrlPoints[0])  # array of control points

    # Enable the evaluator

    pyglet.gl.glEnable(pyglet.gl.GL_MAP1_VERTEX_3)

    # Use a line strip to "connect-the-dots"

    pyglet.gl.glBegin(pyglet.gl.GL_LINE_STRIP)

    for i in range(0, 101):
        # Evaluate the curve at this point
        pyglet.gl.glEvalCoord1f(i)

    pyglet.gl.glEnd()

    DrawPoints()

def bezier_curve_4(point1, point2, point3, point4, color= (255, 255, 255)):

    pyglet.gl.glColor3f(color[0] / 255, color[1] / 255, color[2] / 255)

    nNumPoints = 4

    ctrlPoints = (pyglet.gl.GLfloat * 3 * 4)((point1[0], point1[1], 0.0),  # End Point

                                             (point3[0], point3[1], 0.0),  # Control Point

                                             (point4[0], point4[1], 0.0),   # Control Point

                                             (point2[0], point2[1], 0.0))  # End Point

    # This function is used to superimpose the control points over the curve

    def DrawPoints():
        # Loop through all control points for this example

        pyglet.gl.glBegin(pyglet.gl.GL_POINTS)


        pyglet.gl.glVertex2fv(ctrlPoints[0])
        pyglet.gl.glVertex2fv(ctrlPoints[3])

        pyglet.gl.glEnd()

    # Sets up the bezier

    # This actually only needs to be called once and could go in

    # the setup function

    pyglet.gl.glMap1f(pyglet.gl.GL_MAP1_VERTEX_3,  # Type of data generated

                      0.0,  # Lower u range

                      100.0,  # Upper u range

                      3,  # Distance between points in the data

                      nNumPoints,  # number of control points

                      ctrlPoints[0])  # array of control points

    # Enable the evaluator

    pyglet.gl.glEnable(pyglet.gl.GL_MAP1_VERTEX_3)

    # Use a line strip to "connect-the-dots"

    pyglet.gl.glBegin(pyglet.gl.GL_LINE_STRIP)

    for i in range(0, 101):
        # Evaluate the curve at this point

        pyglet.gl.glEvalCoord1f(i)

    pyglet.gl.glEnd()

    DrawPoints()


############################################# mouse #############################################
def mouse_invisible(window):
    window.set_mouse_visible(False)

def mouse_visble(window):
    window.set_mouse_visible(True)

def mouse_visibility_change(window, pos):
    if pos == True:
        mouse_invisible(window)
    if pos == False:
        mouse_visble(window)

def no_mouse(window):
    window.set_exclusive_mouse(True)

def yes_mouse(window):
    window.set_exclusive_mouse(False)

def change_mouse_exclusivity(window, pos):
    if pos == True:
        window.set_exclusive_mouse(False)

    if pos == False:
        window.set_exclusive_mouse(True)

def cursor_shape(window, shape):
    if shape == 'default':
        cursor = window.get_system_mouse_cursor(window.CURSOR_DEFAULT)
        window.set_mouse_cursor(cursor)

    elif shape == 'crosshair':
        cursor = window.get_system_mouse_cursor(window.CURSOR_CROSSHAIR)
        window.set_mouse_cursor(cursor)

    elif shape == 'hand':
        cursor = window.get_system_mouse_cursor(window.CURSOR_HAND)
        window.set_mouse_cursor(cursor)

    elif shape == 'help':
        cursor = window.get_system_mouse_cursor(window.CURSOR_HELP)
        window.set_mouse_cursor(cursor)

    elif shape == 'no':
        cursor = window.get_system_mouse_cursor(window.CURSOR_NO)
        window.set_mouse_cursor(cursor)

    elif shape == 'pan':
        cursor = window.get_system_mouse_cursor(window.CURSOR_SIZE)
        window.set_mouse_cursor(cursor)

    elif shape == 'down' or shape == 'up':
        cursor = window.get_system_mouse_cursor(window.CURSOR_SIZE_UP)
        window.set_mouse_cursor(cursor)

    elif shape == 'left' or shape == 'left-right' or shape == 'right':
        cursor = window.get_system_mouse_cursor(window.CURSOR_SIZE_RIGHT)
        window.set_mouse_cursor(cursor)

    elif shape == 'down left' or shape == 'up right':
        cursor = window.get_system_mouse_cursor(window.CURSOR_SIZE_DOWN_LEFT)
        window.set_mouse_cursor(cursor)

    elif shape == 'down right' or shape == 'up left':
        cursor = window.get_system_mouse_cursor(window.CURSOR_SIZE_DOWN_RIGHT)
        window.set_mouse_cursor(cursor)

    elif shape == 'text':
        cursor = window.get_system_mouse_cursor(window.CURSOR_TEXT)
        window.set_mouse_cursor(cursor)

    elif shape == 'wait':
        cursor = window.get_system_mouse_cursor(window.CURSOR_WAIT)
        window.set_mouse_cursor(cursor)

    elif shape == 'wait arrow':
        cursor = window.get_system_mouse_cursor(window.CURSOR_WAIT_ARROW)
        window.set_mouse_cursor(cursor)

def mouse_button(pos):
    if pos.casefold() == 'left':
        return pyglet.window.mouse.LEFT

    if pos.casefold() == 'middle' or pos.casefold() == 'mid':
        return pyglet.window.mouse.MIDDLE

    if pos.casefold() == 'right':
        return pyglet.window.mouse.RIGHT



############################################# sprites #############################################
def make_sprite(image, X, Y):
    return pyglet.sprite.Sprite(img=image, x=X, y=Y)



############################################## clock ##############################################
def print_events(window):
    window.push_handlers(pyglet.window.event.WindowEventLogger())

def set_fps(function, speed):
    real_speed = 1/speed
    pyglet.clock.schedule_interval(function, real_speed)

def unschedule(function):
    pyglet.clock.unschedule(function)

def do_once(function, time):
    pyglet.clock.schedule_once(function, time)

def set_interval(function, time):
    pyglet.clock.schedule_interval(function, time)

def get_fps():
    return pyglet.clock.get_fps()


########################################### directory ###########################################
def save_on_computer():
    from tkinter import filedialog
    import tkinter
    root = tkinter.Tk()
    root.withdraw()  # use to hide tkinter window
    root.filename =  filedialog.asksaveasfilename(initialdir = "/",title = "Select file",filetypes = (("jpeg files","*.jpg"),("all files","*.*")))

    return root.filename

def choose_folder():
    import tkinter
    from tkinter import filedialog
    import os

    root = tkinter.Tk()
    root.withdraw()  # use to hide tkinter window

    currdir = os.getcwd()
    tempdir = filedialog.askdirectory(parent=root, initialdir=currdir, title='Please select a directory')

    return tempdir




def run():
    pyglet.app.run()

