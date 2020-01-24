

"""
An AI player for Othello. This is the template file that you need to  
complete and submit for the competition. 

@author: YOUR NAME
"""

import random
import sys
import time
from math import ceil

# You can use the functions in othello_shared to write your AI 
from othello_shared import find_lines, get_possible_moves, get_score, play_move


############ ALPHA-BETA PRUNING #####################

file = open("C:\\Users\\ethan\\Desktop\\log.txt", 'w')

def heuristic2(board, player):

    

    score = 0

    quarterHeuristic = [ \
        [50, -5, 20], \
        [-5, -5,  1], \
        [20,  1,  5] \
    ]
    
    for i in range(len(board)):
        for j in range(len(board[0])):
            if board[i][j] == 0:
                continue

            ti = 0
            tj = 0
            if i <= len(board)/2:
                if i < 2:
                    ti = i
                else:
                    ti = 2
            else:
                if i > len(board) - 3:
                    ti = len(board) - i - 1
                else:
                    ti = 2
            
            if j <= len(board[0])/2:
                if j < 2:
                    tj = j
                else:
                    tj = 2
            else:
                if j > len(board[0]) - 3:
                    tj = len(board[0]) - j - 1
                else:
                    tj = 2
  
            if board[i][j] == player:
                score += quarterHeuristic[ti][tj]
            else:
                if quarterHeuristic[ti][tj] == 50:
                    score -= 5*50
                elif quarterHeuristic[ti][tj] == 20:
                    score -= 1.5*20
                else:
                    score -= quarterHeuristic[ti][tj]

    return score


def jank(board, color, depth, accuracy):
    moves = get_possible_moves(board, color)

    def getFirstAndLast(board, player, depth, nums):
        if depth == 0:
            nums.append(heuristic2(board, color))
            return None
        
        moves = get_possible_moves(board, player)
        moves = moves[0 : len(moves) : ceil((len(moves) - 1)//accuracy)]

        if len(moves == 0):
            nums.append(heuristic2(board, color))
        
        for i in moves:
            getFirstAndLast(play_move(board, *i), player%2+1, depth - 1, nums)
        
        return nums
        
    averages = []
    for i in moves:
        nums = getFirstAndLast(play_move(board, *i), color%2 + 1, depth, [])
        averages.append(sum(nums)/len(nums))
    
    maxIndex = averages.index(max(averages))

    return moves[maxIndex]







####################################################
def run_ai():

    """
    This function establishes communication with the game manager. 
    It first introduces itself and receives its color. 
    Then it repeatedly receives the current score and current board state
    until the game is over. 
    """
    print("Ethan h3") # First line is the name of this AI  
    color = int(input()) # Then we read the color: 1 for dark (goes first), 
                         # 2 for light. 

    while True: # This is the main loop 
        # Read in the current game status, for example:
        # "SCORE 2 2" or "FINAL 33 31" if the game is over.
        # The first number is the score for player 1 (dark), the second for player 2 (light)
        next_input = input() 
        status, dark_score_s, light_score_s = next_input.strip().split()
        dark_score = int(dark_score_s)
        light_score = int(light_score_s)

        if status == "FINAL": # Game is over. 
            print()
        else: 
            board = eval(input()) # Read in the input and turn it into a Python
                                  # object. The format is a list of rows. The 
                                  # squares in each row are represented by 
                                  # 0 : empty square
                                  # 1 : dark disk (player 1)
                                  # 2 : light disk (player 2)
                    
            movei, movej = jank(board, color, 4, 1)

            print("{} {}".format(movei, movej)) 

if __name__ == "__main__":
    run_ai()
