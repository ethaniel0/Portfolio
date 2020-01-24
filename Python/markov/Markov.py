


import numpy as np
import random


class markov_chain:
    def __init__(self):
        self.components = []
        self.probabilityMatrix = []
        self.probabilityTotals = []
        self.proportionProbMatrix = []
        
    def addToArrays(self):
        for i in self.probabilityMatrix:
            i.append(0)

    def add_component(self, name):
        self.components.append(name)
        self.probabilityMatrix.append([])
        self.addToArrays()
        self.probabilityTotals.append([])
    
    def add_probability(self, component1, probabilities):

        comp1Index = self.components.index(component1)

        self.probabilityMatrix[comp1Index] = probabilities

    def make_proportion_matrix(self):
        
        self.proportionProbMatrix = self.probabilityMatrix[:]

        for i in range(len(self.probabilityMatrix)):

            total = sum(self.probabilityMatrix[i])

            for j in range(len(self.probabilityMatrix[i])):

                if(total > 0):
                    self.proportionProbMatrix[i][j] = self.probabilityMatrix[i][j]/total
                else:
                    self.proportionProbMatrix[i][j] = 1/len(self.probabilityMatrix[i])
        

    def train(self, component1, component2):
        # if either component isn't in the list, add them
        if component1 not in self.components:
            self.components.append(component1) # add the component to the list of components
            self.addToArrays() # make sure that theres a probability for everything
            self.probabilityMatrix.append([0]*(len(self.components))) # make another row for the list of probabilities ofr the component

        if component2 not in self.components:
            self.components.append(component2)
            self.addToArrays()
            self.probabilityMatrix.append([0]*(len(self.components)))

        comp1Index = self.components.index(component1) # get the index of comp1
        comp2Index = self.components.index(component2) # get the index of comp2

        # print(comp1Index)

        self.probabilityMatrix[comp1Index][comp2Index] += 1 # record the number of times comp1 goes to comp2

        # self.probabilityTotals[comp1Index] += 1 # record the training

    def run(self, times, start_state):
        
        self.make_proportion_matrix()

        current_state = start_state

        results = [start_state]

        for i in range(times):
            current_index = self.components.index(current_state)

            if sum(self.proportionProbMatrix[current_index]) != 0: 
                x = np.random.choice(self.components,replace=True,p=self.proportionProbMatrix[current_index])
                current_state = x
                results.append(x)
            else:
                break

        return results
            


x = markov_chain()

part = ''''''

train_files = ["C:\\Users\\ethan\\Desktop\\Programming\\Python\\Markov\\bo.txt", "C:\\Users\\ethan\\Desktop\\Programming\\Python\\Markov\\kanye ye.txt", "C:\\Users\\ethan\\Desktop\\Programming\\Python\\Markov\\frankenstein.txt"]

file = open(train_files[1], "r")

sentences = file.readlines()
sentence = []

for i in sentences:

    for j in i.split(" "):
        sentence.append(j)

file.close()


for i in range(len(sentence)-1):
    x.train(sentence[i], sentence[i+1])
    if i%(int(len(sentence)/8)) == 0:
        print(round(i/(len(sentence))*100), "%")
print("DONE TRAINING")
array = x.run(500, random.choice(sentence))

finish = ""

for i in array:
    finish += i+ " "

print(finish)

