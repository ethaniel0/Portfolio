
import random


class play_2048:

    def __init__(self):
        self.gameboard = ['','','',''], \
			             ['','','',''], \
			             ['','','',''], \
			             ['','','','']

        self.last_board = ['1','','',''], \
			              ['','','',''], \
			              ['','','',''], \
			              ['','','','']

        self.points = 0

    def still_alive(self):
        for i in self.gameboard:  # check every peice: if there is a blank, then the player is still alive
            for j in i:
                if j == '':
                    return True

        for i in range(4):  # go through every piece, check if there is something
            for j in range(4):  # of the same value next to it

                if i == 0 and j == 0:  # top left
                    if (self.gameboard[0][1] == self.gameboard[i][j]) or (
                        self.gameboard[1][0] == self.gameboard[i][j]):  # if the pieces to the right or down are the same
                        return True

                if i == 0 and j == 3:  # top right
                    if (self.gameboard[0][2] == self.gameboard[i][j]) or (
                        self.gameboard[1][3] == self.gameboard[i][j]):  # if the pieces to the left or down are the same
                        return True

                if i == 3 and j == 0:  # bottom left
                    if (self.gameboard[3][1] == self.gameboard[i][j]) or (
                        self.gameboard[2][0] == self.gameboard[i][j]):  # if the pieces to the right or up are the same
                        return True

                if i == 3 and j == 3:  # bottom right
                    if (self.gameboard[3][2] == self.gameboard[i][j]) or (
                        self.gameboard[2][2] == self.gameboard[i][j]):  # if the pieces to the left or up are the same
                        return True

                if i == 0 and j != 0 and j != 3:  # top
                    if self.gameboard[i + 1][j] == self.gameboard[i][j]:  # directly below
                        return True

                    if (self.gameboard[i][j + 1] == self.gameboard[i][j]) or (
                        self.gameboard[i][j - 1] == self.gameboard[i][j]):  # to either side
                        return True

                if i == 3 and j != 3 and j != 0:  # bottom
                    if self.gameboard[i - 1][j] == self.gameboard[i][j]:  # directly above
                        return True

                    if (self.gameboard[i][j + 1] == self.gameboard[i][j]) or (
                        self.gameboard[i][j - 1] == self.gameboard[i][j]):  # to either side
                        return True

                if j == 0 and i != 0 and i != 3:  # left
                    if self.gameboard[i][j + 1] == self.gameboard[i][j]:  # directly right
                        return True

                    if (self.gameboard[i + 1][j] == self.gameboard[i][j]) or (
                        self.gameboard[i - 1][j] == self.gameboard[i][j]):  # up or down
                        return True

                if j == 3 and i != 3 and i != 0:  # right
                    if self.gameboard[i][j - 1] == self.gameboard[i][j]:  # directly left
                        return True

                    if (self.gameboard[i + 1][j] == self.gameboard[i][j]) or (
                        self.gameboard[i - 1][j] == self.gameboard[i][j]):  # up or down
                        return True

                if (i != 0 and i != 3 and j != 0 and j != 3):  # in the middle

                    if (self.gameboard[i + 1][j] == self.gameboard[i][j]) or (
                        self.gameboard[i - 1][j] == self.gameboard[i][j]):  # up or down
                        return True

                    if (self.gameboard[i][j + 1] == self.gameboard[i][j]) or (
                        self.gameboard[i][j - 1] == self.gameboard[i][j]):  # left or right
                        return True

        return False


    def record_board(self): # take each individual number/space from the board and copy it (without making links)
        for i in range(4):
            for j in range(4):
                self.last_board[i][j] = self.gameboard[i][j]

    def get_new_num(self):
        open_spots = []
        for i in range(4):
            for j in range(4):
                if self.gameboard[i][j] == '':
                    open_spots.append([i, j])

        randnum = random.random()

        add = 2

        if randnum > .75:
            add = 4

        if len(open_spots) > 0: # if there are open spots, add a number in a random open spot
            select = open_spots[random.randint(0, len(open_spots) - 1)]

            self.gameboard[select[0]][select[1]] = add

    def move(self, move):

        self.record_board()

        if move == 'w': # up
            rows = [[], [], [], []]

            ########################################################################################
            for i in range(4):  # each layer
                for j in range(4):
                    if self.gameboard[i][j] != '':
                        rows[j].append(self.gameboard[i][j])

            ########################################################################################
            for i in range(4): # combine equal numbers that are next to each other
                for j in range(len(rows[i]) - 1):
                    if rows[i][j] == rows[i][j+1] and rows[i][j] != 'a':
                        rows[i][j] = rows[i][j]*2 # combine the numbers

                        self.points += rows[i][j]

                        del(rows[i][j+1]) # get rid of the excess combined number

                        rows[i].append('') # add in a space so the last index isnt out of range

            ########################################################################################
            for i in range(4):  # add in spaces in the list so things match up right
                length = len(rows[i])

                for j in range(4 - length):
                    rows[i].append('')
            ########################################################################################
            for i in range(4): # rearrange gameboard according to the move
                for j in range(4):
                    self.gameboard[j][i] = rows[i][j]

        if move == 'a': # left
            rows = [[], [], [], []]

            ########################################################################################
            for i in range(4):  # each layer
                for j in range(4):
                    if self.gameboard[i][j] != '':
                        rows[i].append(self.gameboard[i][j])

            ########################################################################################
            for i in range(4):  # combine equal numbers that are next to each other
                for j in range(len(rows[i]) - 1):
                    if rows[i][j] == rows[i][j + 1] and rows[i][j] != '':
                        rows[i][j] = rows[i][j] * 2  # combine the numbers

                        self.points += rows[i][j]

                        del (rows[i][j + 1])  # get rid of the excess combined number

                        rows[i].append('')  # add in a space so the last index isnt out of range

            ########################################################################################
            for i in range(4):  # add in spaces in the list so things match up right
                length = len(rows[i])

                for j in range(4 - length):
                    rows[i].append('')

            ########################################################################################
            for i in range(4): # rearrange gameboard according to the move
                for j in range(4):
                    self.gameboard[i][j] = rows[i][j]

        if move == 's': # down
            rows = [[], [], [], []]

            ########################################################################################
            for i in range(4):  # each layer
                for j in range(4):
                    if self.gameboard[i][j] != '':
                        rows[j].append(self.gameboard[i][j])

            ########################################################################################
            for i in range(4):  # add in spaces in the list so things match up right
                length = len(rows[i])

                for j in range(4 - length):
                    rows[i].insert(0, '')

            ########################################################################################
            for i in range(4):  # combine equal numbers that are next to each other
                for j in range(3, -1, -1):
                    if rows[i][j] == rows[i][j - 1] and rows[i][j] != '':
                        rows[i][j] = rows[i][j] * 2  # combine the numbers

                        self.points += rows[i][j]

                        del (rows[i][j - 1])  # get rid of the excess combined number

                        rows[i].insert(0, '')  # add in a space so the last index isnt out of range

            ########################################################################################
            for i in range(4):  # rearrange gameboard according to the move
                for j in range(4):
                    self.gameboard[j][i] = rows[i][j]

        if move == 'd': # right
            rows = [[], [], [], []]

            ########################################################################################
            for i in range(4):  # each layer
                for j in range(4):
                    if self.gameboard[i][j] != '':
                        rows[i].append(self.gameboard[i][j])

            ########################################################################################
            for i in range(4):  # add in spaces in the list so things match up right
                length = len(rows[i])

                for j in range(4 - length):
                    rows[i].insert(0, '')

            ########################################################################################
            for i in range(4):  # combine equal numbers that are next to each other
                for j in range(3, -1, -1):
                    if rows[i][j] == rows[i][j - 1] and rows[i][j] != '':
                        rows[i][j] = rows[i][j] * 2  # combine the numbers

                        self.points += rows[i][j]

                        del (rows[i][j - 1])  # get rid of the excess combined number

                        rows[i].insert(0, '')  # add in a space so the last index isnt out of range

            ########################################################################################
            for i in range(4):
                for j in range(4):
                    self.gameboard[i][j] = rows[i][j]

play = play_2048()

while play.still_alive():

    if play.last_board != play.gameboard:
        play.get_new_num()

    print('\n\n\n\n\n\n')
    print('points:' + str(play.points) + '\n')
    print(play.gameboard[0])
    print(play.gameboard[1])
    print(play.gameboard[2])
    print(play.gameboard[3])

    x = input("move: ")
    if(x != 'w' and x != 's' and x != 'a' and x != 'd'):
        x = input("move: ")

    play.move(x)
