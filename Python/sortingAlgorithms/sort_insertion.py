import random
import pjlet


window = pjlet.window(1000, 1000, 'Insertion Sort')
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

already_done = []

def one_run(x):

    if len(already_done) == 0 or len(list) == 0: #no matter what, add the first thing in the list to already_done or stop running the function
        if len(already_done) == 0:
            already_done.append(list[0]) #add the number to the already_done
            del list[0] #take that number out of the list

        elif len(list) == 0:
            pjlet.unschedule(one_run)
            # print('unscheduled')
            print(already_done)


    elif len(already_done) != 0: #if already_done has numbers in it

        if list[0] <= already_done[0]: #if the first thing on the list is smaller than the first thing in already_done,
            already_done.insert(0, list[0]) #put it in as the first thing in already_done
            del list[0] #delete the number from the list

        elif list[0] >= already_done[-1]: #if the last thing on the list is larger than the last thing in already_done,
            already_done.append(list[0]) #put it in as the last thing in already_done
            del list[0] #delete the number from the list

        else:
            for f in range(len(already_done)):
                if already_done[f] <= list[0] <= already_done[f+1]: #FIX
                    already_done.insert(f+1, list[0])
                    del list[0]
                    break


def draw_numbers():
    for i in range(len(already_done)):
        pjlet.rect(i * (window_width // len(already_done)), 0,  # starting point
                   window_width // len(origional_list), already_done[i] * (window_height // len(origional_list)),  # width and height
                   (i, 2*i + 55, 255))  # color

@window.event
def on_draw():
    window.clear()
    draw_numbers()


pjlet.set_fps(one_run, fps)

pjlet.run()