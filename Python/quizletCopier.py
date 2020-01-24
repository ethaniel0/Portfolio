
import urllib.request

############## DONT TOUCH THIS (unless you know what you're doing) ##############

class html():

    def __init__(self, url):
        self.site = urllib.request.urlopen(url)
        self.code = str(self.site.read())

    def inside_bracket(self, name, code):

        openBracket = False

        firstFound = False
        endFound = False

        numInName = 0

        codeInside = ""

        num_opening = 0
        closing = False

        startAt = -1

        for i in range(len(code)):

            if not firstFound:

                if numInName < len(name):

                    if openBracket:

                        # make sure spaces aren't counted
                        if code[i] != " " or name[numInName] == " ":
                            if code[i] == name[numInName]:  # if the part of the tag matches with the name
                                numInName += 1

                            else:                                 # try again if it doesn't match
                                numInName = 0
                                openBracket = False

                else:
                    if code[i]  == ">" or code[i] == " ":
                        firstFound = True
                        numInName = 0
                        openBracket = False
                        startAt = i

                    else:
                        numInName = 0
                        openBracket = False



            #if the first is found
            # count the number of opening tags to negate them with closing tags, find the closing tag when num_opening = 0
            else:
                codeInside += code[i]

                if code[i] == ">":

                    openBracket = False
                    # if not closing:
                    #     num_opening += 1
                    if closing:
                        num_opening -= 1
                        closing = False

                if openBracket:
                    if code[i] != " " and code[i] != "<" and code[i] != "/":
                        openBracket = False
                        num_opening += 1




                # if it's an closing bracket, say its closing
                if openBracket:
                    if code[i] == "/":
                        closing = True
                        openBracket = False




                if num_opening == 0 and closing:
                    break


            if code[i] == "<":
                openBracket = True


        self.codeFound = codeInside

        return [codeInside, startAt]

    def inside_all_brackets(self, names):
        strings = []
        
        for name in names:
            strings.append([])
            codeToBe = self.code
            for i in range(len(self.code)):

                # retrieve the words/strings and the position in the code
                text = self.inside_bracket(name, codeToBe)

                if text[1] != -1:
                    strings[-1].append(text[0])
                    codeToBe = codeToBe[text[1]:]

                else:
                    break

        return strings


######### This formats everything, but you can change it if you want to #########
def format(texts):
    toRemove = ["<br>", "<strong>", "<s>", "<i>", "<", ">", "/", "\\", ";"]

    newText = []

    for text in texts:
    
        newText.append([])
        for i in range(len(text)):

            for j in range(len(toRemove)):
                text[i] = text[i].replace(toRemove[j], "")

                text[i] = text[i].replace("&quot", '"')



        for i in range(len(text)):
            if i % 2 == 0:
                newText[-1].append(text[i] + ": ")


            else:
                newText[-1][-1] += text[i]
                # print("'" + text[i].replace("[","").replace("]","") + "'", end = ", ", flush=True)
            # if i % 2 == 1:
            # newText.append(text[i])
    
    return newText

''' ENTER URL HERE (default is quizlet '''

url = input("Enter a Quizlet URL: ")

############## DONT TOUCH THIS ##############

want = html(url)

''' ENTER THE HTML TAG HERE (default is quizlet, so don't change it unless you want something else) '''
texts = (want.inside_all_brackets([ 'span class="TermText notranslate lang-en"']))

##################### DONT TOUCH THIS #####################
formatted = format(texts)

################ DONT TOUCH THIS unless you want something different ################
for i in formatted:
    for j in i:
        print("" + str(j) + ": ", end="\n", flush=True)

x = input("end?")