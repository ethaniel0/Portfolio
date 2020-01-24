import pjlet
import random

def round(num):
    global cell_size

    return (num // cell_size) * cell_size

def repeated(list):
    list2 = []
    for i in list:

        if i in list2:
            return True

        if i not in list2:
            list2.append(i)



    return False

window = pjlet.window(600, 600, caption= 'snake', resizeable= True)

cell_size = 20

snake_length = 1

snake_head_coord = [100, 100]
snake_body_coords = [[100, 100]]

# turn_coords = []

snake_x_plus = 0
snake_y_plus = 0

pellet_coords = [round(random.randint(0, window.width- cell_size)), round(random.randint(0, window.height - cell_size)) ]

occurrences = []

score = 0

def make_pellet():
    global pellet_coords
    x = round(random.randint(0, window.width - cell_size))
    y = round(random.randint(0, window.height - cell_size))
    pellet_coords = [x, y]


@window.event
def on_key_press(symbol, modifiers):
    global snake_head_coord, snake_x_plus, snake_y_plus

    if (symbol == pjlet.get_key('w') or symbol == pjlet.get_key('up')) and snake_y_plus != -cell_size:     #up
        snake_x_plus = 0
        snake_y_plus = cell_size

    if (symbol == pjlet.get_key('s') or symbol == pjlet.get_key('down')) and snake_y_plus != cell_size:   #down
        snake_x_plus = 0
        snake_y_plus = -cell_size

    if (symbol == pjlet.get_key('d') or symbol == pjlet.get_key('right')) and snake_x_plus != -cell_size:  #right
        snake_x_plus = cell_size
        snake_y_plus = 0

    if (symbol == pjlet.get_key('a') or symbol == pjlet.get_key('left')) and snake_x_plus != cell_size:   #left
        snake_x_plus = -cell_size
        snake_y_plus = 0

    if symbol == pjlet.get_key('space'):
        pjlet.unschedule(update)


def move_snake():
    global snake_x_plus, snake_y_plus, snake_head_coord, snake_body_coords

    snake_head_coord[0] += snake_x_plus
    snake_head_coord[1] += snake_y_plus

    if snake_length > 1:
        snake_body_coords[-2][0] += snake_x_plus
        snake_body_coords[-2][1] += snake_y_plus


    for i in range(len(snake_body_coords)):
        if i != 0:

            snake_body_coords[i][0] = occurrences[i-1][0]
            snake_body_coords[i][1] = occurrences[i-1][1]

            pjlet.rect(snake_body_coords[i][0], snake_body_coords[i][1], cell_size, cell_size, color= (random.randint(1, 255), random.randint(1, 255), random.randint(1, 255)))




        elif snake_length == 1:
            pjlet.rect(snake_body_coords[0][0], snake_body_coords[0][1], cell_size, cell_size, color=(0, 150, 0))

            snake_body_coords[0][0] += snake_x_plus # head
            snake_body_coords[0][1] += snake_y_plus




def update(x):
    global snake_length, snake_x_plus, snake_y_plus, pellet_coords

    pjlet.rect(pellet_coords[0], pellet_coords[1], cell_size, cell_size, color= (255, 0, 0)) #pellet

    if snake_head_coord == pellet_coords:
        snake_length += 1
        make_pellet()
        snake_body_coords.insert(-2, [snake_head_coord[0] - snake_x_plus, snake_head_coord[1] + snake_y_plus])
        global score
        score += 1

    if repeated(occurrences):
        print('Score:', score)
        quit()

    if snake_head_coord[0] > window.width - cell_size:       #right wall
        snake_head_coord[0] = 0 - cell_size
        # quit()

    if snake_head_coord[1] > window.height - cell_size:      #top wall
        snake_head_coord[1] = 0 - cell_size
        # quit()

    if snake_head_coord[0] < 0 - cell_size:                  #left wall
        snake_head_coord[0] = window.width  - cell_size
        # quit()

    if snake_head_coord[1] < 0 - cell_size:                  #bottom wall
        snake_head_coord[1] = window.height - cell_size
        # quit()

@window.event
def on_draw():
    global snake_length

    window.clear()

    update(1)
    pjlet.text(str(score), 500, 500)

    move_snake()

    occurrences.append([snake_head_coord[0], snake_head_coord[1]])

    if len(occurrences)  > snake_length:
        del occurrences[0]

    if snake_length > 1:
        pjlet.rect(snake_body_coords[-1][0], snake_body_coords[-1][1], cell_size, cell_size, color=(0, 255, 0))

pjlet.set_fps(update, 20)



pjlet.run()