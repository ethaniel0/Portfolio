import tkinter as tk
import random
import time

x = list(range(500))
nums = []
for i in range(len(x)):
    randIndex = random.randint(0, len(x) - 1)
    nums.append(x[randIndex])
    del x[randIndex]

sizeX = 1200
sizeY = 800

sleepTime = 0.001

root = tk.Tk()
root.title("Merge Sort")
root.geometry(str(sizeX) + "x" + str(sizeY))
root.resizable(0, 0)


w = tk.Canvas(root, width=sizeX, height=sizeY) 

def drawList(nums):
    w.delete("all")
    w.create_rectangle(0, 0, sizeX, sizeY, fill="black")
    for i in range(len(nums)):
        w.create_rectangle(i*sizeX/len(nums), sizeY, sizeX/len(nums)*(i+1), sizeY * (nums[i]/max(nums)), fill="white")
    w.update()
    time.sleep(sleepTime)

drawList(nums)

def mergeSort(nums, visualsL, visualsR):

    if len(nums) == 1:
        return nums

    x = mergeSort(nums[:int(len(nums)/2)], visualsL, nums[int(len(nums)/2):] + visualsR)
    y = mergeSort(nums[int(len(nums)/2):], visualsL + x, visualsR)

    drawList(visualsL + x+y + visualsR)
    # time.sleep(0.05)

    if x[-1] < y[0]:
        return x+y
    if y[-1] < x[0]:
        return y+x  
    else:

        newArr = []

        xpos = 0
        ypos = 0

        while ypos < len(y):
            while y[ypos] > x[xpos]:
                newArr.append(x[xpos])
                xpos += 1

                drawList(visualsL + newArr + x[xpos:] + y[ypos:] + visualsR)
                
                if xpos >= len(x):
                    newArr += y[ypos:]
                    return newArr

            newArr.append(y[ypos])

            ypos += 1

            drawList(visualsL + newArr + x[xpos:] + y[ypos:] + visualsR)
            # time.sleep(0.05)
        
        if xpos < len(x):
            newArr += x[xpos:]

        return newArr

# x = mergeSort(nums)
# print(x)

def runSort(nums):
    x = mergeSort(nums, [], [])

w.pack()
root.after(0, runSort(nums))

root.mainloop()
