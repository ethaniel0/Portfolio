import random
import pjlet


window = pjlet.window(1000, 1000, 'Selection Sort')
window.set_location(400, 50)

window_width = window.width
window_height = window.height

num_numbers = 100

fps = 200

list = []
origional_list = []

while len(list)!= num_numbers:
    i = random.randint(1, num_numbers)
    if i not in list:
        list.append(i)
        origional_list.append(i)


print(list)

def is_done():
    global list
    wrongs = 0
    for i in range(len(list) - 1):
        if list[i] > list[i+1]:
            wrongs += 1

    if wrongs == 0:
        return True

    else:
        return False

already_sorted = []

def one_run(x):
    if len(list) == 1:
        already_sorted.append(list[0])
        del list[0]
        pjlet.unschedule(one_run)
        print(already_sorted)

    else:
        least = list[0]
        num = 0
        for i in range(len(list)):
            if list[i] < least:
                least = list[i]
                num = i

        already_sorted.append(least)
        del list[num]


def draw_numbers():
    for i in range(len(already_sorted)):
        pjlet.rect(i * (window_width // len(already_sorted)), 0,  # starting point
                   window_width // len(origional_list), already_sorted[i] * (window_height // len(origional_list)),  # width and height
                   (i, 2*i + 55, 255))  # color

@window.event
def on_draw():
    window.clear()
    draw_numbers()


pjlet.set_fps(one_run, fps)

pjlet.run()