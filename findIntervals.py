'''
Description:

This script takes a folder of XML files, or a folder containing subfolders with XML files, from a Bruker confocal and determines the average interval time.
It calculates the average +/- stdv interval and generates a plot (optional) so you can see if it changed over time.
It outputs the avgs and stdvs to a .csv file in the main directory
'''
import os
import pwd
import numpy as np
import pandas as pd
from datetime import timedelta
import matplotlib.pyplot as plt
import xml.etree.ElementTree as ET
from tkinter.filedialog import askdirectory   

def findWorkspace():                                                    # no arguments
    targetWorkspace = askdirectory(message='Select your workspace')     # choose your raw data location 
    filelist = []                                                       # empty list to fill with file paths
    for dirpath, dirnames, filenames in os.walk(targetWorkspace):       # iterates through dir and subdirs
        for filename in [f for f in filenames if f.endswith(".xml")]:   # for every .xml file
            filelist.append(os.path.join(dirpath, filename))            # add the full path to the file list
    return(targetWorkspace, filelist)                                   # returns the base folder path and list of file names

def parseFile(xmlFile):                                                 # function that reads XML file and finds root
    tree  = ET.parse(xmlFile)                                           # parse the XML file
    return(tree.getroot())                                              # return the root 

def findIntervals(root):                                                # parses XML file for time stamps and makes a list of intervals
    sliceTimes = []                                                     # future list for the slice times
    for child in root.findall('Sequence'):                              # for each child in the root marked '<Sequence>' (start of a new z-stack)
        time = child.get('time')[:-1]                                   # get the value of the 'time' attribute
        h, m, s = time.split(':')                                       # split time into h, m, s
        totalSeconds = timedelta(hours=int(h), minutes=int(m), seconds=float(s)).total_seconds() #convert the string to a timedelta object in total seconds
        sliceTimes.append(totalSeconds)                                 # append the time to the list
    intervals = [i for i in np.diff(sliceTimes)]                        # calculate the difference between adjacent sequences 
    return(intervals)

def calculateAvg(file, intervals):                                      # calculate the mean and std for the intervals
    avgInterval = np.mean(intervals)                                    # calculate the mean interval
    stdv = np.std(intervals)                                            # calculate std interval
    #print('FileName:', file, 'Average Interval:', avgInterval, '\u00B1', stdv) #print the average +/- standard deviation
    return([file, avgInterval, stdv])

def plotIntervals(dir, fileBase, intervals):                            # plot the intervals over time to spot changes
    outputDir = os.path.join(dir, "0_plots")                            # set output dir
    os.makedirs(outputDir, exist_ok=True)                               # make output directory
    
    frames = [num for num in range(1, len(intervals)+1)]                # make xAxis 
    plt.plot(frames, intervals)
    plt.title('Z-stack intervals over time')
    plt.xlabel('Time (frames)')
    plt.ylabel('Interval (s)')
    print('saving to', outputDir, fileBase+"_plot.png")
    savePath = os.path.join(outputDir, fileBase+"_plot.png")
    plt.savefig(savePath)
    plt.close()

###### MAIN ######
directory, fileNames = findWorkspace()
avgIntervals = [['File name', 'Mean Interval (s)', 'Stdv (s)']]         # starts list for avgs

for file in fileNames:                                                  # iterate through xml files
    fileBase = os.path.basename(file).rsplit('.')[0]                    # get the base name from full path
    root = parseFile(file)                                              # parse the xml file into memory
    intervals = findIntervals(root)                                     # find the intervals for the xml file
    avgIntervals.append(calculateAvg(fileBase, intervals))              # append the filename, avg and std interval to the list
    plotIntervals(directory, fileBase, intervals)                       # generate plots (optional. comment out if do not want)

csvSavePath = os.path.join(directory, "averageIntervals.csv")           # save path for csv file of avgs
df = pd.DataFrame(avgIntervals)                                         # create dataframe from the list
df.to_csv(csvSavePath, header=False, index=False)                       # write the datafram to csv