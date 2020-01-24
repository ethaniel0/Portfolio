# reflector <--> first rotor <--> second rotor <--> third rotor <--> plugboard <--> input

alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"  # reference alphabet (left side of rotor is the alphabet in order)
reflector ="YRUHQSLDPXNGOKMIEBFZCWVJAT" # wiring of reflector

# for each rotor, each letter lines up with its corresponding placement when lined up with the alphabet
#            wiring of first rotor          wiring of second rotor        wiring of third rotor
rotors = ["EKMFLGDQVZNTOWYHXUSPAIBRCJ", "AJDKSIRUXBLHWTMCQGZNPYFVOE", "BDFHJLCPRTXVZNYEIWGAKMUSQO"]


plugLeft = "BCDEKMOPUG" # letters in plugLeft go to their corresponding letters in plugRight
plugRight = "QRIJWTSXZH"

# rotor order order from left to right
rotorOrder = [3,2,1]

for i in range(len(rotorOrder)):
    rotorOrder[i] = rotorOrder[i]-1

# what A goes to in each rotor
keyword = "CUA"

turns = []


# get the numerical value for the number of turns of each rotor
for i in keyword:
    turns.append(alphabet.index(i))

def enigma(rotorOrder = rotorOrder, turns = turns, plugLeft = "", plugRight = "", kchunk = True, message = ""):
    # get the text to encrypt/decrypt
    if(message == ""):
        x = input("Enter a message to encrypt/decrypt: ").upper()
    else:
        x = message
    endStr = ""

    # go through each letter in the message
    for char in x:
        c = char

        # run through the plugboard
        if c in plugLeft: c = plugRight[plugLeft.index(c)]
        if c in plugRight: c = plugLeft[plugRight.index(c)]

        cpos = alphabet.index(c)

        # run the char forwards through the rotors
        for rotor in reversed(rotorOrder):
            toturn = turns[rotorOrder.index(rotor)]
            c = rotors[rotor][(cpos - toturn)%26]
            cpos = (alphabet.index(c) + toturn)%26
        
        # run the char through the reflector
        c = alphabet[cpos]
        cpos = reflector.index(c)

        # run the char back through the rotors
        for rotor in rotorOrder:
            toturn = turns[rotorOrder.index(rotor)]
            c = alphabet[(cpos - toturn)%26]
            cpos = (rotors[rotor].index(c) + toturn)%26
            
        
        result = alphabet[cpos]

        # run through the plugboard
        if result in plugLeft: result = plugRight[plugLeft.index(result)]
        if result in plugRight: result = plugLeft[plugRight.index(result)]

        # turn the rotors
        if kchunk:
            for i in range(1, len(turns) + 1):
                turns[-1] += 1
                if i != len(turns):
                    if turns[-i] == 26:
                        turns[-i] = 0
                        turns[-i-1] += 1
                    else:
                        break
                else:
                    if turns[-1] == 26:
                        turns[-i] = 0
            

        endStr += result
    return endStr

class Permutation:
    def __init__(self, p):
        # p (the permutaion) can be entered in as a string, list, or dictionary (table of values)

        self.permutation = [] # stores the cycle structure as a 2-d array
        self.table = {}; # stores the permutation as a table of values
        
        self.cycle_structure = ""
        self.length = 0 # stores the amount of items in the permutaiton

        if type(p) == str:
            parts = p.split(")")[:-1] # get each section of letters
            cs = []
            for i in range(len(parts)):
                parts[i] = list(parts[i][1:]) # turn the string into a list of characters
                self.permutation.append(parts[i])
                cs.append(len(parts[i]))
                self.length += len(parts[i])
            # make the cycle structure
            cs.sort()
            for i in range(len(cs)): cs[i] = str(cs[i])
            
            self.permutation = list(reversed(sorted(self.permutation, key=len))) # sort each section of the permutation by length
            self.cycle_structure = "-".join(cs)
            self.__makeTable(self.permutation) # generates the table (a dictionary) that describes where each letter goes

        elif type(p) == list:
            self.permutation = list(reversed(sorted(p, key=len))) # the permutation in 2d array form was input, sort it and make it the permutation
            lengths = []
            for i in p: # set the length of the permutation and generate the lengths for the cycle structure -- lengths in this = cs in type=str
                self.length += len(i)
                lengths.append(len(i))
            lengths.sort()
            for i in range(len(lengths)): lengths[i] = str(lengths[i])
            self.cycle_structure = "-".join(lengths)
            self.__makeTable(self.permutation)

        elif type(p) == dict:
            self.table = p # the table was input, so keep it as is
            self.permutation = self.__tableToPerm(p) # make the permutation from the table
            lengths = []
            for i in self.permutation:
                self.length += len(i)
                lengths.append(len(i))
            lengths.sort()
            for i in range(len(lengths)): lengths[i] = str(lengths[i])
            self.cycle_structure = "-".join(lengths)


    def __makeTable(self, perm):
        # traverse the 2d array, set each value to what's next in line
        for i in range(len(perm)):
            for j in range(len(perm[i])):
                self.table[perm[i][j]] = perm[i][(j+1)%len(perm[i])] 

    def __tableToPerm(self, table):    
        perm = [[]]
        used = []
        key = next(iter(table)) # gets the first value in the dictionary
        while len(used) < len(table):
            if key not in used: # puts the next letter in the permutation, adds that new letter into the used used characters list, and sets that letter as the next dict key
                perm[-1].append(key)
                used.append(key)
                key = table[key]
            else:
                perm.append([])
                for k in table: # search through the table for any keys that haven't been used yet, use the first one that hasn't been used
                    if k not in used:
                        key = k
                        break

        return perm

    def compose(self, otherP):
        newTable = {}
        for key in otherP.table:
            newTable[key] = self.next(otherP.next(key))
      
        return Permutation(self.__tableToPerm(newTable)) # return a new permutation

    def conjugate(self, otherP):
        inv = self.inverse()
        p1 = otherP.compose(inv)
        p2 = self.compose(p1)
        return p2

    def __toStr(self, perm):
        part = ""
        for i in perm:
            part += "(" + "".join(i) +")"
        return part

    def inverse(self):
        perm = []
        for i in self.permutation: # reverse all of the permutations
            perm.append(list(reversed(i)))
        
        return Permutation(list(reversed(sorted(perm, key=len))))

    def next(self, letter):
        return self.table[letter]
    
    def __str__(self):
        return self.__toStr(self.permutation)

# makes a permutation for one enigma setting
def makePermutation(keyword, rotorOrder):
    turns = []
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    if max(rotorOrder) >= 3:
        for i in range(len(rotorOrder)):
            rotorOrder[i] = rotorOrder[i]-1
    for i in keyword:
        turns.append(alphabet.index(i))
    
    table = {}
    
    
    output = enigma(rotorOrder=rotorOrder, turns=turns, kchunk=False, message=alphabet)
    
    for letter in range(26):
        table[alphabet[letter]] = output[letter]

    return Permutation(table)

# turns the rotors x amount of times
def increaseAlph(key, numTimes = 1):
    for i in range(numTimes):
        if(key[2] != "Z"):
            key = key[:2] + alphabet[alphabet.index(key[2]) + 1]
        else:
            key = key[:2] + "A"
            if key[1] != "Z":
                key = key[0] + alphabet[alphabet.index(key[1]) + 1] + "A"
            else:
                if key[0] != "Z":
                    key = alphabet[alphabet.index(key[0]) + 1] + "AA"
                else:
                    key = "AAA"
    return key

# supposed to make the cycle structure combo for sigma 1,2,3 -- not working yet, but I'm working on it
key = "MGU"
rotorOrder = [2,1,3]
r1 = makePermutation(key, rotorOrder)
r2 = makePermutation(increaseAlph(key, 1), rotorOrder)
r3 = makePermutation(increaseAlph(key, 2), rotorOrder)
r4 = makePermutation(increaseAlph(key, 3), rotorOrder)
r5 = makePermutation(increaseAlph(key, 4), rotorOrder)
r6 = makePermutation(increaseAlph(key, 5), rotorOrder)
print(r3)
print(r6)
print(r6.compose(r3))


s1 = r4.compose(r1)
s2 = r5.compose(r2)
s3 = r6.compose(r3)

print(s1.cycle_structure, s2.cycle_structure, s3.cycle_structure)