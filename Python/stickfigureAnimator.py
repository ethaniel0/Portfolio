import pjlet
from pjlet import circle, line, rect
from pjlet import bezier_curve_3 as bezier


window = pjlet.window(600, 800, resizeable= True)

background_color = (0, 0, 0)
pjlet.background(background_color[0], background_color[1], background_color[2])

body_placements_saved = 19

opposite_part_edited = False

########################## body placement ##########################

body_lower = 300, 275

body_upper = 300, 400

body_bezier = ((body_upper[0] + body_lower[0]) / 2), ((body_upper[1] + body_lower[1]) / 2)

body_color = (255, 255, 255)

################################ arms ###############################

arms_connect = 300, 325

########## left arm ##########

left_arm_hand = 250, 375

left_arm_bezier = ((left_arm_hand[0] + arms_connect[0]) / 2), ((left_arm_hand[1] + arms_connect[1]) / 2)

left_arm_color = (255, 255, 255)

########## right arm ##########

right_arm_hand = 350, 300

right_arm_color = (255, 0, 0)

right_arm_bezier = ((right_arm_hand[0] + arms_connect[0]) / 2), ((right_arm_hand[1] + arms_connect[1]) / 2)

############################### legs ###############################

legs_connect = 300, 275

########### left leg ##########

left_leg_foot = 260, 220

left_leg_color = (255, 255, 255)


left_leg_bezier = ((left_leg_foot[0] + legs_connect[0]) / 2), ((left_leg_foot[1] + legs_connect[1]) / 2)


########## right leg ##########

right_leg_foot = 340, 220

right_leg_color = (255, 255, 255)

right_leg_bezier = ((right_leg_foot[0] + legs_connect[0]) / 2), ((right_leg_foot[1] + legs_connect[1]) / 2)

############################### head ###############################
head_radius = 50

head = 300, 400

head_color = (255, 255, 255)

################ remember the last 20 body positions ###############
past_body_positions = [
[], #0
[], #1
[], #2
[], #3
[], #4
[], #5
[], #6
[], #7
[], #8
[], #9
[], #10
[], #11
[], #12
[], #13
[], #14
[], #15
[], #16
[], #17
[], #18
[], #19
]

no_red = False

pen_draw = False
pen_draw_box = False
pen_draw_box_reopen = False
pen_draw_color = (0, 0, 0)
# pen_draw_circle = [-1, -1, 5, pen_draw_color]
pen_circle_points = []

draw_under = False


part_of_figure = 0 #a different number corresponds to a different part of the stick figure

def save_figure():
    global body_placements_saved
    globals()
    past_body_positions[body_placements_saved].extend([body_lower, body_upper, body_bezier,
    arms_connect, legs_connect, left_arm_hand, left_arm_bezier, left_arm_color, right_arm_hand,
    right_arm_bezier, right_arm_color, left_leg_foot, left_leg_bezier,
    left_leg_color, right_leg_foot, right_leg_bezier, right_leg_color,
    head_radius, head])

    if body_placements_saved == 0:
        body_placements_saved = 19

    else:
        body_placements_saved -= 1

def get_figure_back(num):
    global body_lower, body_upper, body_bezier,\
    arms_connect, legs_connect, left_arm_hand, left_arm_bezier, left_arm_color, right_arm_hand,\
    right_arm_bezier, right_arm_color, left_leg_foot, left_leg_bezier,\
    left_leg_color, right_leg_foot, right_leg_bezier, right_leg_color,\
    head_radius, head
    #make all of the variables global

    body_lower, body, body_bezier, arms_connect, legs_connect, left_arm_hand, left_arm_bezier, left_arm_color, right_arm_hand, right_arm_bezier, right_arm_color, left_leg_foot, left_leg_bezier, left_leg_color, right_leg_foot, right_leg_bezier, right_leg_color, head_radius, head = past_body_positions[num]
    #assign all of the current variables to the old ones



def current_figure():
    return body_lower, body_upper, body_bezier,\
    arms_connect, legs_connect, left_arm_hand, left_arm_bezier, left_arm_color, right_arm_hand,\
    right_arm_bezier, right_arm_color, left_leg_foot, left_leg_bezier,\
    left_leg_color, right_leg_foot, right_leg_bezier, right_leg_color,\
    head_radius, head

################################ all about figure ###############################
def draw_guy(): #draw the picture of the guy

    line(0, window.height, window.width, window.height, width=2, color=background_color)  # keeps all lines at a thickness of 2

    bezier(body_upper, body_lower,
                       body_bezier, color= body_color)             #middle body

    bezier(arms_connect, left_arm_hand,
                         left_arm_bezier, color= left_arm_color)   #left arm

    bezier(arms_connect, right_arm_hand,
                         right_arm_bezier, color= right_arm_color) #right arm

    bezier(legs_connect, left_leg_foot,
                         left_leg_bezier, color= left_leg_color)   #left leg

    bezier(legs_connect, right_leg_foot,
                         right_leg_bezier, color= right_leg_color) #right leg

    circle(head[0], head[1], head_radius, color=head_color)  # head


def get_color(): #make the part if the figure that is being edited red
    global part_of_figure, right_arm_color, left_arm_color, left_leg_color, right_leg_color, body_color, head_color, no_red

    if not no_red:
        if part_of_figure == 0:
            right_arm_color = (255, 0, 0) #right arm becomes red
            left_arm_color = (255, 255, 255)
            left_leg_color = (255, 255, 255)
            right_leg_color = (255, 255, 255)
            body_color = (255, 255, 255)
            head_color = (255, 255, 255)


        if part_of_figure == 1:
            left_arm_color = (255, 0, 0)      #left arm becomes red
            right_arm_color = (255, 255, 255)
            left_leg_color = (255, 255, 255)
            right_leg_color = (255, 255, 255)
            body_color = (255, 255, 255)
            head_color = (255, 255, 255)

        if part_of_figure == 2:
            left_leg_color = (255, 0, 0)      #left leg becomes red
            left_arm_color = (255, 255, 255)
            right_arm_color = (255, 255, 255)
            right_leg_color = (255, 255, 255)
            body_color = (255, 255, 255)
            head_color = (255, 255, 255)

        if part_of_figure == 3:
            right_leg_color = (255, 0, 0)     # right leg becomes red
            left_leg_color = (255, 255, 255)
            left_arm_color = (255, 255, 255)
            right_arm_color = (255, 255, 255)
            body_color = (255, 255, 255)
            head_color = (255, 255, 255)

        if part_of_figure == 4:
            body_color = (255, 0, 0)          # body becomes red
            right_leg_color = (255, 255, 255)
            left_leg_color = (255, 255, 255)
            left_arm_color = (255, 255, 255)
            right_arm_color = (255, 255, 255)
            head_color = (255, 255, 255)

        if part_of_figure == 5:
            head_color = (255, 0, 0)
            body_color = (255, 255, 255)  # body becomes red
            right_leg_color = (255, 255, 255)
            left_leg_color = (255, 255, 255)
            left_arm_color = (255, 255, 255)
            right_arm_color = (255, 255, 255)


    if no_red:
        right_leg_color = (255, 255, 255)  # whole stick figure is white
        left_leg_color = (255, 255, 255)
        left_arm_color = (255, 255, 255)
        right_arm_color = (255, 255, 255)
        body_color = (255, 255, 255)
        head_color = (255, 255, 255)

def get_limb(): #display what part of the stick figure is being edited
    if part_of_figure == 0:
        pjlet.text('Right Arm', window.width -150, window.height -50, color= (255, 0, 0))

    if part_of_figure == 1:
        pjlet.text('Left Arm', window.width - 150, window.height - 50, color=(255, 0, 0))

    if part_of_figure == 2:
        pjlet.text('Left Leg', window.width - 150, window.height - 50, color=(255, 0, 0))

    if part_of_figure == 3:
        pjlet.text('Right Leg', window.width - 150, window.height - 50, color=(255, 0, 0))

    if part_of_figure == 4:
        pjlet.text('Middle Body', window.width - 150, window.height - 50, color=(255, 0, 0))

    if part_of_figure == 5:
        pjlet.text('Head', window.width - 150, window.height - 50, color=(255, 0, 0))

########################### what happens when you press buttons ###########################

@window.event
def on_mouse_drag(x, y, dx, dy, button, modifiers): #make the end of the arm go where the mouse is

    if not pen_draw:
        global left_arm_hand, right_arm_hand,\
            arms_connect, legs_connect, \
            left_leg_foot, right_leg_foot, \
            right_arm_bezier, left_arm_bezier, \
            right_leg_bezier, left_leg_bezier, \
            body_bezier, body_upper, body_lower, \
            head

        if button == pjlet.mouse_button('left'):
            global are_bottom_arms_edited, are_top_legs_edited, arms_connect, legs_connect
            if not(opposite_part_edited):
                if part_of_figure == 0: #right arm

                    right_arm_hand = x, y

                    right_arm_bezier = ((right_arm_hand[0] + arms_connect[0]) / 2), ((right_arm_hand[1] + arms_connect[1]) / 2)


                if part_of_figure == 1: #left arm

                    left_arm_hand = x, y

                    left_arm_bezier = ((left_arm_hand[0] + arms_connect[0]) / 2), ((left_arm_hand[1] + arms_connect[1]) / 2)

                if part_of_figure == 2: #left leg

                    left_leg_foot = x, y

                    left_leg_bezier = ((left_leg_foot[0] + legs_connect[0]) / 2), ((left_leg_foot[1] + legs_connect[1]) / 2)

                if part_of_figure == 3: #right leg
                    right_leg_foot = x, y

                    right_leg_bezier = ((right_leg_foot[0] + legs_connect[0]) / 2), ((right_leg_foot[1] + legs_connect[1]) / 2)

                if part_of_figure == 4:

                    body_upper = x, y

                    body_bezier = ((body_upper[0] + body_lower[0])/2), ((body_upper[1] + body_lower[1])/2)

                if part_of_figure == 5:
                    head = x, y

            if opposite_part_edited:
                if part_of_figure == 0 or part_of_figure == 1:
                    arms_connect = x, y

                if part_of_figure == 2 or part_of_figure == 3:
                    legs_connect = x, y

                if part_of_figure == 4:
                    body_lower = x, y


        if button == pjlet.mouse_button('right'):
            if part_of_figure == 0:  # right arm

                right_arm_bezier = x, y

            if part_of_figure == 1:  # left arm

                left_arm_bezier = x, y

            if part_of_figure == 2:  # left leg

                left_leg_bezier = x, y

            if part_of_figure == 3:  # right leg

                right_leg_bezier = x, y

            if part_of_figure == 4:

                body_bezier = x, y

    if pen_draw:
        global pen_draw_color, pen_circle_points
        pen_circle_points.append([x, y, pen_draw_color])

@window.event
def on_mouse_release(x, y, button, modifiers):
    global right_arm_color, left_arm_color, left_leg_color, right_leg_color #have one of the limbs be highlighted ot not highlighted
    if 20 <= x <= 160 and (window.height - 90) <= y <= (window.height - 20):
        global no_red
        no_red = not no_red

    if pen_draw:
        global pen_draw_box, pen_draw_box_reopen, pen_draw_color
        if pen_draw_box:
            if 350 <= x <= 390 and (window.height - 290) <= y <= (window.height - 260): #if the person hits the x for the color chooser,                                              #the color chooser goes away
                pen_draw_box = False                                                    #the color chooser goes away
                pen_draw_box_reopen = True

            if 204 <= x <= 244 and 530 <= y <= 570: #yellow
                pen_draw_color = (255, 255, 0)

            if 204 <= x <= 244 and 580 <= y <= 620: #orange
                pen_draw_color = (255, 165, 0)

            if 204 <= x <= 244 and 630 <= y <= 670: #red
                pen_draw_color = (255, 0, 0)

            if 274 <= x <= 314 and 530 <= y <= 570: #purple
                pen_draw_color = (255, 0, 255)

            if 274 <= x <= 314 and 580 <= y <= 620:#blue
                pen_draw_color = (0, 0, 255)

            if 274 <= x <= 314 and 630 <= y <= 670: #green
                pen_draw_color = (0, 255, 0)


        if pen_draw_box:
            pen_draw_box_reopen = False

        if pen_draw_box_reopen:
            if 180 <= x <= 340 and (window.height-145) <= y <= (window.height - 10):
                pen_draw_box = True
                pen_draw_box_reopen = False

        if 430 <= x <= 580 and 610 <= y <= 690:
            global pen_circle_points
            pen_circle_points = []


    if current_figure() != past_body_positions[body_placements_saved]:
        save_figure()

@window.event
def on_mouse_motion(x, y, dx, dy): #changes the cursor shape depending on where it is
    if  (20 <= x <= 160 and (window.height - 90) <= y <= (window.height - 20)) or (180 <= x <= 340 and (window.height - 90) <= y <= (window.height - 20)):
        pjlet.cursor_shape(window, 'hand')

    if not ((20 <= x <= 160 and (window.height - 90) <= y <= (window.height - 20)) or (180 <= x <= 340 and (window.height - 90) <= y <= (window.height - 20))):
        pjlet.cursor_shape(window, 'default')

@window.event
def on_mouse_press(x, y, button, modifiers):

    if 180 <= x <= 340 and (window.height - 90) <= y <= (window.height - 20): #opens and closes drawing mode
        global pen_draw, pen_draw_box
        pen_draw = not pen_draw
        pen_draw_box = True
num_screenshots = 0


save_to = 'C:\\Users\\User\\Desktop\\stick figure screenshots\\'


@window.event
def on_key_press(symbol, modifiers): #if they press space, change the body part being edited
    global part_of_figure, no_red, right_arm_bezier, left_arm_bezier, \
        right_leg_bezier, left_leg_bezier, save_to

    if not pen_draw:
        if symbol == pjlet.get_key('right arrow'):  # changes the limb that is being worked on
            if part_of_figure == 5:
                part_of_figure = 0

            else:
                part_of_figure += 1

        if symbol == pjlet.get_key('left arrow'):
            if part_of_figure == 0:
                part_of_figure = 5

            else:
                part_of_figure -= 1

        if modifiers == pjlet.get_key('shift'):
            global are_bottom_arms_edited, are_top_legs_edited, opposite_part_edited

            opposite_part_edited = True

        if symbol == pjlet.get_key('z') and modifiers == pjlet.get_key('control'):  # go back to a previous figure
            figures_rewound = 0
            for i in range(len(past_body_positions)):
                if len(past_body_positions[i]) == 0:
                    figures_rewound += 1

            if figures_rewound < 19:
                get_figure_back(figures_rewound + 1)
                past_body_positions[figures_rewound] = []
                figures_rewound += 1

    if pen_draw:
        if modifiers == pjlet.get_key('control'):
            global draw_under
            draw_under = True

    if symbol == pjlet.get_key('s') and modifiers == pjlet.get_key('control'): #take a screenshot
        global num_screenshots
        num_screenshots += 1
        pjlet.take_screenshot(save_to + str(num_screenshots))


    if symbol == pjlet.get_key('n') and modifiers == pjlet.get_key('control'):
        save_to = pjlet.replace(pjlet.choose_folder(), '/', '\\') + '\\'





@window.event
def on_key_release(symbol, modifiers):
    if current_figure() != past_body_positions[body_placements_saved]:
        save_figure()

    global draw_under, opposite_part_edited

    opposite_part_edited = False

    draw_under = False

################################### extra buttons for more control ###################################
def no_red_box():
    pjlet.rect(20, window.height - 90, 140, 70)
    pjlet.text('No Red', 35, window.height - 67, size= 24, color= (255, 0, 0), font= 'Comic Sans')



########################## draw extra things that aren't the stick figure ###########################
def draw_pen():
    pjlet.rect(180, window.height - 90, 160, 70)
    # pen = pjlet.load_image('C:\\Users\\ethan\\Desktop\\stick figure program pictires\\pen.png')
    pen = pjlet.load_image('C:\\Users\\ethan\\Desktop\\pen.png')
    pjlet.resize_image(pen, 0.15)
    pen.blit(187, window.height - 95)

def pen_color_box():
    rect(180, (window.height - 290), 160, 180)

    circle(224, (window.height - 250), 40, color=(255, 255, 0)) #yellow circle
    circle(224, (window.height - 200), 40, color=(255, 165, 0)) #orange circle
    circle(224, (window.height - 150), 40, color=(255, 0, 0))   #red circle
    circle(294, (window.height - 250), 40, color=(255, 0, 255)) #purple circle
    circle(294, (window.height - 200), 40, color=(0, 0, 255))   #blue circle
    circle(294, (window.height - 150), 40, color=(0, 255, 0))   #green circle

    rect(350, (window.height - 290), 40, 30, color= (255, 0, 0)) #510
    pjlet.text('X', 362, (window.height - 283))

def reopen_color_chooser():
    rect(180, (window.height - 145), 160, 35)
    pjlet.text('Reopen Color Chooser', 186, (window.height - 134), color= (0, 0, 0), size= 11)

def clear_pen_markings():
    rect(window.width - 170, window.height - 190, 150, 80)
    pjlet.text('Clear', 446, 632, size= 36, color= pen_draw_color)



def over_or_under():
    global draw_under

    if not draw_under:
        pass

    if draw_under:
        draw_guy()


@window.event
def on_draw():
    window.clear()  # clears the window
    no_red_box()
    get_color()
    draw_guy()
    get_limb() #draws the text
    draw_pen()
    if pen_draw:
        clear_pen_markings()
        if pen_draw_box:
            pen_color_box()


        if pen_draw_box_reopen:
            reopen_color_chooser()

        for i in pen_circle_points:
            circle(i[0], i[1], 10, color= i[2])

        # draw_guy()
        over_or_under()

pjlet.run()