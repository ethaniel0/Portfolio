# from __future__ import division
import matplotlib.pyplot as plt
from scipy.io import wavfile
# from scipy.fftpack import *
import scipy
import numpy as np
import math


# filename = "C:\\Users\\ethan\\Desktop\\downsampled music\\"

def plotwave(fs, signal, maxf=None):
        """Visualize (a segment of) a wave file."""
        # maxf = maximum number of frames
        frames = scipy.arange(signal.size)   # x-axis
        if maxf:
            plt.plot(frames[:maxf], signal[:maxf])
            plt.xticks(scipy.arange(0, maxf, 0.5*fs), scipy.arange(0, maxf/fs, 0.5))
            plt.show()
        else:
            plt.plot(frames, signal)
            plt.xticks(scipy.arange(0, signal.size, 0.5*fs), scipy.arange(0, signal.size/fs, 0.5))
            plt.show()

def downsample(filename, i, factor):
    """Lower the sampling rate by factor."""
    # newfilename = filename[:-4]+'-down'+str(factor)+'.wav'
    fs, wave = wavfile.read(filename)
    newfs = int(fs/factor)
    # fill in the rest
    indices = range(0, len(wave), factor)
    wave = wave[indices]
    wavfile.write("C:\\Users\\ethan\\Desktop\\ultradownsampled music\\" + str(i) + ".wav", newfs, wave)

def invert(filename, num):
    '''invert the track'''
    fs, wave = wavfile.read(filename)

    newWav = []
    numRev = int((fs * 60 / 80)*2)
    for point in range(0, len(wave)):

        newWav.append([-wave[point][0], -wave[point][1]])

        # if point&(numRev*2) >= numRev:

        #     toSlow = []

        #     for i in range(numRev):
        #         toSlow.append([wave[point + i][0], wave[point + i][1]])

        #     toSlow = np.array(toSlow)

        #     toSlow = (ifft(fft(np.array(toSlow)) - np.int16(50))).tolist()
        #     newWav.append(toSlow)
               

        # else:
        #     for i in range(numRev):
        #         newWav.append([wave[point + i][0], wave[point + i][1]])

        

        # newWav.insert(0, [-wave[point][0], -wave[point][1]])

    newWav = np.array(newWav)

    wavfile.write("C:\\Users\\ethan\\Desktop\\" + str(num) +".wav", fs, newWav)

def noiseCancel(filename, num):
    '''invert the track'''
    fs, wave = wavfile.read(filename)

    newWav = []
    for point in range(0, len(wave)):

        newWav.append([wave[point][0], -wave[point][0]])


    newWav = np.array(newWav)

    wavfile.write("C:\\Users\\ethan\\Desktop\\" + str(num) +"noise cancelled.wav", fs, newWav)



def numConvert(num):
    return np.float32(num / 32767)

def minimize(filename):
    fs, wave = wavfile.read(filename)

    newWav = [[numConvert(wave[0][0]), numConvert(wave[0][1]), 0]]

    bp0 = wave[0][0]
    bp1 = wave[0][1]
    cp0 = wave[1][0]
    cp1 = wave[1][1]
    ap0 = wave[2][0]
    ap1 = wave[2][1]

    for point in range(1, len(wave) - 1):
        # peak
        if (cp0 >= bp0 and cp0 >= ap0) or (cp1>= bp1 and cp1 >= ap1) or (cp0 <= bp0 and cp0 <= ap0) or (cp1 <= bp1 and cp1 <= ap1):

            midpoint = newWav[-1][2] + int((point - newWav[-1][2])/2)

            newWav.append([numConvert(wave[midpoint][0]), numConvert(wave[midpoint][1]), midpoint])

            newWav.append([numConvert(wave[point][0]), numConvert(wave[point][1]), point])


        
        bp0 = wave[point][0]
        bp1 = wave[point][1]

        cp0 = wave[point+1][0]
        cp1 = wave[point+1][1]

        if point < len(wave)-2:
            ap0 = wave[point+2][0]
            ap1 = wave[point+2][1]


    return fs, newWav

def rebuild(fs, minimized):
    newWav = []

    for i in range(len(minimized) - 1):
        newWav.append([minimized[i][0], minimized[i][1]])

        lenToGo = minimized[i+1][2] - minimized[i][2]
        for j in range(1, lenToGo):
            newWav.append([minimized[i][0] + numConvert((minimized[i+1][0] - minimized[i][0]) * j/lenToGo), 
                           minimized[i][1] + numConvert((minimized[i+1][1] - minimized[i][1]) * j/lenToGo)])

            # newWav.append([minimized[i][0] + numConvert(-0.5*(minimized[i+1][0] - minimized[i][0])*math.cos(math.pi * j/lenToGo) + 0.5*(minimized[i+1][0] - minimized[i][0])), 
            #                minimized[i][1] + numConvert(-0.5*(minimized[i+1][1] - minimized[i][1])*math.cos(math.pi * j/lenToGo) + 0.5*(minimized[i+1][1] - minimized[i][1]))])
    
    return fs, np.array(newWav)

# import sys

# fs, minn = minimize("C:\\USers\\ethan\\Desktop\\music\\"+ str(5) + ".wav")
# print(sys.getsizeof(np.array(minn)))

# fs, wave = rebuild(fs, minn)
# print(sys.getsizeof(wave))

# wavfile.write("C:\\Users\\ethan\\Desktop\\ultrainverse\\" + str(5) +".wav", fs, wave)


# filename = "C:\\USers\\ethan\\Desktop\\music\\"+ str(1) + ".wav"
# fs, wave = wavfile.read(filename)

# print(type(wave))


noiseCancel("C:\\USers\\ethan\\Desktop\\music\\"+ str(5) + ".wav", 5)

'''
for i in range(3, 4):

    filename = "C:\\USers\\ethan\\Desktop\\music\\"+ str(i) + ".wav"

    #fs, wave = wavfile.read(filename) 
    #Note that this particular file has a single channel. Most audio files will have two (stereo) channels.

    #data0 = wave[:,0]
    #data1 = wave[:,1]

    #print ('Data:', data0, "Length:", len(data0))
    #print ('Sampling rate:', fs)
    #print ('Audio length:', len(data0)/fs, 'seconds')

    # plotwave(fs, data1)

    minimize(filename, i)
    print(i)

 
'''