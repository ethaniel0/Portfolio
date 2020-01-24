import pyglet
import random
import math


class pjlet(): # substitute for the program pjlet I made, so pjlet doesn't have to be in the system to run
    def window(x, y, caption='window', resizeability=False):
        return pyglet.window.Window(width=x, height=y, caption=caption, resizable=resizeability)


    def text(string, X, Y, size=18, fontname='Arial', r=255, g=255, b=255, transparency=255):
        text = pyglet.text.Label(string,
                                 font_name=fontname,
                                 font_size=size,
                                 x=X, y=Y,
                                 color=(r, g, b, transparency))
        text.draw()

    def run():
        pyglet.app.run()


    def rect(x, y, width, height, r=255, g=255, b=255, transparency=255):
        quad = pyglet.graphics.vertex_list(4,
                                           ('v2i', (x, y, x + width, y, x + width, y + height, x, y + height)),
                                           ('c3B', (r, g, b, r, g, b, r, g, b, r, g, b)))
        quad.draw(pyglet.gl.GL_QUADS)


    def rect_with_gradient_left_right(x, y, width, height, r1=255, g1=255, b1=255, r2=255, g2=255, b2=255):
        quad = pyglet.graphics.vertex_list(4,
                                           ('v2i', (x, y, x + width, y, x + width, y + height, x, y + height)),
                                           ('c3B', (r1, g1, b1, r2, g2, b2, r2, g2, b2, r1, g1, b1)))
        quad.draw(pyglet.gl.GL_QUADS)

    def line(x1, y1, x2, y2, r=255, g=255, b=255, width=1):
        pyglet.gl.glLineWidth(width)
        line = pyglet.graphics.vertex_list(2,
                                           ('v2i', (x1, y1, x2, y2)),
                                           ('c3B', (r, g, b, r, g, b))
                                           )
        line.draw(pyglet.gl.GL_LINES)


class Window(pyglet.window.Window): # make window


    def __init__(self):

        self.windowWidth = 600
        self.windowHeight = 780
        super().__init__(self.windowWidth, self.windowHeight)
        super().set_location(525, 200)

        self.cellSize = 20
        self.grid_width = int(self.get_size()[0] / self.cellSize)  # width of the grid
        self.grid_height = int(self.get_size()[1] / self.cellSize)  # height of the grid
        self.cell_size = self.cellSize  # size of the cell
        self.cells = []        #lists saying whether a cell is alive or dead
        self.percent_fill = .4 #the percentage amount of living cells to make
        self.generate_cells()  #generates the cells

        self.frameRate = 1/24 #frame rate

        self.clear_transparency = 255
        self.grid_button_transparency = 100
        self.draw_grid_lines = True
        self.red = 255, 0, 0
        self.green = 0, 255, 0
        self.start_or_stop_color = self.red

        self.frameRateMoverPos1 = 300
        self.frameRateMoverPos2 = self.frameRateMoverPos1 + 40

        self.addheight = self.windowHeight - self.grid_width * self.cellSize

        self.frames = 1

        self.top_rate = 1

        pyglet.clock.schedule_interval(self.update, 1/80)



    '''--------------------------------rules and drawing stuff--------------------------------'''

    def generate_cells(self):
        for row in range(self.grid_height):
            self.cells.append([])
            for column in range(self.grid_width):
                if random.random() < self.percent_fill: # get that a cell is either dead or alive,
                    self.cells[row].append(1)           #  and have a certain percentage of cells be alive and dead

                else:
                    self.cells[row].append(0)


    def run_rules(self):
        temp = []
        for row in range(0, self.grid_height):
            temp.append([])
            for column in range(0, self.grid_width):
                cell_sum = sum([self.get_cell_value(row - 1, column),     # top
                                self.get_cell_value(row - 1, column - 1), # top left
                                self.get_cell_value(row, column - 1),     # left
                                self.get_cell_value(row + 1, column -  1), # bottom left
                                self.get_cell_value(row + 1, column),     # bottom
                                self.get_cell_value(row + 1, column + 1), # bottom right
                                self.get_cell_value(row, column + 1),     # right
                                self.get_cell_value(row - 1, column + 1)])# top right

                if self.cells[row][column] == 0 and cell_sum == 3: # if a dead cell has three surrounding cells, it is born
                    temp[row].append(1)

                elif self.cells[row][column] == 1 and (cell_sum == 2 or cell_sum == 3): # if a living cell has eigher two or three
                    temp[row].append(1)                                                 #neighbors, it stays alive

                else:                  #under any other conditions, a cell is dead
                    temp[row].append(0)



        self.cells = temp




    def get_cell_value(self, row, col):
        if (row >= 0 and row < self.grid_height and
            col >= 0 and col < self.grid_width):
            return self.cells[row][col]

        elif col > self.grid_width:
            return 0

        return 0



    def draw(self):
        for row in range(self.grid_height):
            for column in range(self.grid_width):
                 #(0, 0), (0, 20), (20, 0), (20, 20)
                if self.cells[row][column] == 1:
                    pjlet.rect(row*self.cell_size, column*self.cell_size  + self.addheight, self.cell_size, self.cell_size) #draw the board


    '''-----------------------------------start, stop, clear, and grid buttons-----------------------------------'''
    def start_button(self):
        pjlet.rect(20, 100, 150, 60, 0, 255, 0)
        pjlet.text('Start', 48, 115, 30, 0,    0, 0, 0) #display the start button



    def stop_button(self, transparency = 255):
        pjlet.rect(20, 100, 150, 60, 255, 0, 0)
        pjlet.text('Stop', 53, 116, 30, 0,     0, 0, 0) #display the stop button




    def clear_button(self, transparency = 255):
        pjlet.rect(430, 100, 150, 60, 0, 0, 255)
        pjlet.text('Clear', 457, 116, 30, 0,     0, 0, 0, self.clear_transparency) #display the clear button
                                                          #to see where the actual functions for the buttons are,
                                                          # go to line 116

    def grid_button(self):
        pjlet.rect(225, 100, 150, 60, 150, 150, 150)
        pjlet.text('Grid', 260, 116, 30, 0,    0, 0, 0, self.grid_button_transparency)

    def is_grid_button_pressed(self):
        if self.grid_button_transparency != 255:
            return 255

        else:
            return 100

    def framerate_slider(self):
        pjlet.rect_with_gradient_left_right(100, 40, 400, 40,      255, 0, 0,     0, 210, 0)
        if self.frameRate != 0:
            pjlet.text(str(int((1/self.frameRate) // 1)) + ' fps', 260, 13)

        else:
            pjlet.text('0 fps', 260, 13)


    def framerate_moveBlock(self, x):
        pjlet.rect(x - 20, 40,   40, 40,   255, 255, 255)

    def is_clear_pressed(self):
        if self.clear_transparency != 255:
            return 255

        else:
            return 100

    '''------------------------------------------------main------------------------------------------------'''

    def becomeAliveOrDead(self, x, y):
        if self.cells[x][y] == 0:
            return 1

        if self.cells[x][y] == 1:
            return 0

    def on_mouse_press(self, x, y, button, modifiers):
        if y >= 180:
            X = x // self.cellSize
            Y = (y - 180) // self.cellSize
            self.cells[X][Y] = self.becomeAliveOrDead(X, Y)

        elif x >= 20 and x <= 170 and y >= 100 and y <= 160: ########## start and stop time ##########
            if self.start_or_stop_color == self.red:
                self.frameRate = 0
                self.start_or_stop_color = self.green

            elif self.start_or_stop_color == self.green:
                self.frameRate = 1/24
                self.stop_button()
                self.clear_transparency = 255
                self.start_or_stop_color = self.red


        elif x >= 430 and x <= 580 and y >= 100 and y <= 160: ########## clear ##########
            self.clear_transparency = self.is_clear_pressed()
            for i in range(-100, 700):
                for j in range(600):
                    e = i // self.cellSize
                    f = j // self.cellSize
                    self.cells[e][f] = 0

        elif x >= 225 and x <= 375 and y >= 100 and y <= 160: ###### grid button ######
            self.grid_button_transparency = self.is_grid_button_pressed()
            if self.grid_button_transparency != 255:
                self.draw_grid_lines = True

            elif self.grid_button_transparency == 255:
                self.draw_grid_lines = False

    def startOrStopTime(self):
        if self.frameRate != 0:
            self.run_rules()


    def on_mouse_drag(self, x, y, dx, dy, button, modifiers):
        if y >= 180:
            X = x // self.cellSize
            Y = (y - 180) // self.cellSize # make tiles living
            self.cells[X][Y] = 1

        if x >= 120 and x <= 480 and y > 40 and y < 80: # block to change frame rate
            self.frameRateMoverPos1 = x

            self.frameRate = 1/((24 ** (x / 300)))




    def draw_grid(self):
        for i in range(self.grid_width, 0, -1):
                pjlet.line(i * self.cellSize, 180, i * self.cellSize, 780, 150, 150, 150, 2)
                pjlet.line(0, i* self.cellSize + (self.addheight - self.cellSize), 600, i* self.cellSize + (self.addheight - self.cellSize), 150, 150, 150, 2)



    def on_draw(self):
        self.clear()
        self.draw()
        self.framerate_slider()
        self.framerate_moveBlock(self.frameRateMoverPos1)

        if self.start_or_stop_color == self.red:
            self.stop_button()

        if self.start_or_stop_color == self.green:
            self.start_button()

        self.clear_button()
        self.grid_button()
        if self.draw_grid_lines == True:
            self.draw_grid()



    def update(self, dt):
        if self.frames % 81 == 0: # have self.frames cycle and not get too large
            self.frames = 1


        if self.frameRate != 0:
            if self.frames % (math.ceil(self.frameRate * 40)) == 0:
                self.startOrStopTime()
        self.frames += 1


if __name__ == '__main__':
    window = Window()
    pjlet.run()