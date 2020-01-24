# class BankAccount:
#     balance = 0.0
#
#
# my_account = BankAccount()
#
# print (my_account.balance)

import random
import pyglet
import pjlet

window = pjlet.window(1000, 1000, 'Bubble Sort')
window.set_location(400, 50)

num_numbers = 1000

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
    wrongs = 0
    for i in range(len(list) - 1):
        if list[i] > list[i+1]:
            wrongs += 1

    if wrongs == 0:
        return True

    else:
        return False

count = 0

def one_run(x):
    global count
    for i in range(len(list) - 1 - count):
        if list[i] > list[i+1]:
            temp = list[i]
            list[i] = list[i+1]
            list[i+1] = temp


    if is_done():
        pjlet.unschedule(one_run)
        print(list)

    count += 1

@window.event
def on_draw():
    window.clear()
    for i in range(len(list)):

        pjlet.rect(i*(window.width // len(list)), 0, #starting point
                   window.width // len(list), list[i] * (window.height // len(list)), #width and height
                   (i, i*2, 255)) #color


pjlet.set_fps(one_run, fps)



pjlet.run()