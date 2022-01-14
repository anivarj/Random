'''
Description:

This script takes a folder of XML files from a Bruker confocal and determines the average interval time.
It calculates the average +/- stdv interval and generates a plot (optional) so you can see if it changed over time.
It outputs the avgs and stdvs to a .csv file in the main directory

'''

import os
import pwd
import numpy as np
import pandas as pd
import xml.etree.ElementTree as ET
from datetime import timedelta
import matplotlib.pyplot as plt
from tkinter.filedialog import askdirectory   


def findWorkspace():                                                       #accepts a starting directory and a prompt for the GUI
    targetWorkspace = askdirectory(message='SELECT YOUR XML FILE LOCATION') #choose your raw data location 
    filelist = [fname for fname in sorted(os.listdir(targetWorkspace)) if fname.endswith('.xml')]   #Makes a list of file names that end with .tif
    return(targetWorkspace, filelist)                                                       #returns the folder path and list of file names

def parseFile(xmlFile): #function that reads XML file and finds root
    #parse the XML file
    tree  = ET.parse(xmlFile) 
    #find the root 
    root = tree.getroot() 
    return(root)

def findIntervals(file, root): #parses XML file for time stamps and makes a list of intervals
    sliceTimes = [] #future list for the slice times
    for child in root.findall('Sequence'): #for each child in the root marked '<Sequence>' (start of a new z-stack)
        time = child.get('time')[:-1]      #get the value of the 'time' attribute
        h, m, s = time.split(':')          #split time into h, m, s
        totalSeconds = timedelta(hours=int(h), minutes=int(m), seconds=float(s)).total_seconds() #convert the string to a timedelta object in total seconds
        sliceTimes.append(totalSeconds) #append the time to the list

    intervals = [i for i in np.diff(sliceTimes)] #calculate the difference between adjacent sequences 
    return(intervals)

def calculateAvg(file, intervals): #calculate the mean and std for the intervals
    avgInterval = np.mean(intervals)  #calculate the mean interval
    stdv = np.std(intervals) #calculate std interval
    #print('FileName:', file, 'Average Interval:', avgInterval, '\u00B1', stdv) #print the average +/- standard deviation
    return([file, avgInterval, stdv])

def plotIntervals(file, intervals): #plot the intervals over time to spot changes
    outputDir = os.path.join(directory, "0_plots")
    os.makedirs(outputDir, exist_ok=True) #make output directory
    
    frames = [num for num in range(1, len(intervals)+1)] #make xAxis 
    plt.plot(frames, intervals)
    plt.title('Z-stack intervals over time')
    plt.xlabel('Time (frames)')
    plt.ylabel('Interval (s)')
    savePath = os.path.join(outputDir, file+"_plot.png")
    plt.savefig(savePath)
    plt.close()


###### MAIN ######
directory, fileNames = findWorkspace()
avgIntervals = [['File name', 'Mean Interval (s)', 'Stdv (s)']] #starts list for avgs

for file in fileNames:
    filePath = os.path.join(directory, file) # full path to the xml file
    root = parseFile(filePath) #parse the xml file into memory
    intervals = findIntervals(file, root) #find the intervals for the xml file
    avgIntervals.append(calculateAvg(file, intervals)) #append the filename, avg and std interval to the list
    plotIntervals(file, intervals)           #generate plots (optional. comment out if do not want)


csvSavePath = os.path.join(directory, "averageIntervals.csv") #save path for csv file of avgs
df = pd.DataFrame(avgIntervals) #create dataframe from the list
df.to_csv(csvSavePath, header=False, index=False) #write the datafram to csv







