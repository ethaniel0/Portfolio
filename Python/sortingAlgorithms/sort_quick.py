import random
import pjlet
import sorting

window = pjlet.window(1000, 1000, 'Quick Sort')
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

partitions = []


count = 0

def one_run(x):
    global list, count
    if count < (len(list) // 10):

        up = []
        down = []

        partition = random.randint(0, num_numbers - 1)
        while list[partition] in partitions:
            partition = random.randint(0, num_numbers - 1)

        partitions.append(list[partition])

        for i in range(len(list)):
            if list[i] > list[partition]:
                up.append(list[i])

            elif list[i] < list[partition]:
                down.append(list[i])

            elif list[i] == list[partition]:
                pass

        temp = list[partition]

        list = []
        list.extend(down)
        list.append(temp)
        list.extend(up)
    count += 1

    if count == (len(list) // 10):
        list_sorted = sorting.quick(list)
        list = list_sorted.list

        print(len(list))


    if is_done():
        pjlet.unschedule(one_run)
        print('sorted')






@window.event
def on_draw():
    window.clear()
    for i in range(len(list)):

        pjlet.rect(i*(window.width // len(list)), 0, #starting point
                   window.width // len(list), list[i] * (window.height // len(list)), #width and height
                   (i, i*2, 255)) #color


pjlet.set_fps(one_run, fps)



pjlet.run()
