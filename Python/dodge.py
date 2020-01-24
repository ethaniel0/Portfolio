import pjlet
import random



page1 = False

game_over_page = False

window = pjlet.window(600, 600, caption= 'avoid', resizeable= True)
pjlet.background(0, 150, 150)


block_coords = []

figure_x = 300
figure_dimentions = [window.width // 20, window.width // 20]

figure_movement = 0

figure_movement_speed = window.width // 120

square_movement = -window.width // 600 #* (window.width // 600)

@window.event
def on_key_press(symbol, modifiers):
    global figure_movement, figure_pressed, figure_x

    if symbol == pjlet.get_key('right') and figure_x < window.width - figure_dimentions[0]:
        figure_movement = figure_movement_speed

    if symbol == pjlet.get_key('left') and figure_x > 0:
        figure_movement =  -figure_movement_speed

@window.event
def on_key_release(symbol, modifiers): #stop moving the figure once no key is pressed
    global figure_movement

    figure_movement = 0

def draw_figure():
    global figure_x, figure_dimentions

    pjlet.rect(figure_x, 0, window.height // 20, window.height // 20, color= (255, 0, 0))

def new_square(z):
    block_coords.append([random.randint(0, window.width), window.height, random.randint(10 * (window.width // 600), 70* (window.width // 600))])

def draw_squares():
    global block_coords

    for i in block_coords:
        pjlet.rect(i[0], i[1], i[2], i[2])


def is_hit():
    global figure_x, block_coords, score
    for i in block_coords:
        if ((i[0] <= figure_x <= i[0] + i[2]) or (i[0] <= figure_x+figure_dimentions[0] <= i[0] + i[2]) or
                (figure_x <= i[0] <= figure_x + figure_dimentions[0])) and i[1] <= figure_dimentions[1]: #if the first edge is in the block,
                                                                     # if the second edge is in the block,
            print(score)                                             # or if the block is within the two edges
            quit()

def remove_blocks():  #remove any blocks that already passed through
    global block_coords
    for i in range(len(block_coords)):
        if block_coords[i][1] <= -block_coords[i][2]:
            del block_coords[i]
            break

def update(z):
    global figure_x, block_coords, score, figure_movement
    figure_x += figure_movement

    if figure_x <= 0 or figure_x >= window.width - figure_dimentions[0]:
        figure_movement = 0

    for i in range(len(block_coords)):
        block_coords[i][1] += square_movement #move the squares downward

    remove_blocks() #remove any blocks that already passed through

score = 0
count = 0

if not page1 and not game_over_page:
    @window.event
    def on_draw():
        window.clear()
        update(1)
        draw_figure()

        global score

        for i in range(len(block_coords)):
            pjlet.rect(block_coords[i][0], block_coords[i][1], block_coords[i][2], block_coords[i][2] , color=(100, 50, 150))

        pjlet.text(str(round(pjlet.get_fps())), window.width - 50, 0)
        pjlet.text(str(score), window.width - 50, window.height - 50)

        global count
        count += 1

        if count >= pjlet.get_fps():
            score += 1
            count = 0

        is_hit()

pjlet.set_interval(new_square, 1/(window.width // 100))
pjlet.set_fps(update, 100)

pjlet.run()
