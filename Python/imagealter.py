from PIL import Image
img = Image.open('path\\image.png')
if img.mode != 'RGBA':
    img = img.convert('RGBA')

pixels = img.load() # create the pixel map

for i in range(img.size[0]): # for every pixel:
    for j in range(img.size[1]):
        if pixels[i,j][2] > 200:
            pixels[i,j] = (0, 0, 0, 0)
            
img.show()
img.save("path\\image.png")