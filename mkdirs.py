#!/usr/bin/env python3

'''
This script is to prepare an analysis directory for MATLAB processing using the temporal_manual scripts.
This script should:
1. Ask you for a target directory where your raw data is.
2. Ask you where you want your analysis output to go.
3. Get a list of all the raw data folder names and use this to create a new set of folders at the analysis location.
4. Copy the rawMAX.tif files from each scan folder into the appropriate analysis folder location
'''

import os, fnmatch, shutil
from tkinter.filedialog import askdirectory

targetWorkspace = askdirectory(initialdir='/Volumes/Bugsbunny', message='SELECT YOUR RAW DATA LOCATION') #choose your raw data location 
analysisWorkspace = askdirectory(initialdir=targetWorkspace, message='SELECT ANALYSIS LOCATION') #choose where you want your folders to be created

#Gets a list of directories in the targetWorkspace and makes a list of names
directories = [d for d in os.listdir(targetWorkspace) if os.path.isdir(os.path.join(targetWorkspace, d))]
for d in directories:
    print(d)
directories.remove("Analysis") #Currently I store my analysis output in a folder called 'Analysis', so I exlcude this from the list of scans.


#For each directory in the list, make a folder with the same name in the analysisWorkspace location. 
for d in directories:
    outputDir = os.path.join(analysisWorkspace, d) #sets the full path to the folder to make
    if os.path.exists(outputDir):   #checks to see if folder already exists
        shutil.rmtree(outputDir) #if it exists, removes the directory and remakes it
        os.makedirs(outputDir)

    else:   #else, just make it
        os.makedirs(outputDir)


#fileID = 'MAX_C1*' #string to parse for
#fileID = 'MAX_C2*' #string to parse for
fileID = 'Merged*' #string to parse for

for d in directories:
    print("d is:", d)
    dirPath = os.path.join(os.path.join(targetWorkspace, d), 'processed/MAX/rawMAX') #gets the full path to the rawMAX .tifs
    print("dirPath is:", dirPath)
    outputDir = os.path.join(analysisWorkspace, d) #sets the full path to the output folder

    for file in os.listdir(dirPath):
        if fnmatch.fnmatch(file, fileID): #looks in the rawMAX folder and pattern matches to whatever is specified in fileID
            filePath = os.path.join(dirPath, file) #if it matches, makes a fill path to the file
            shutil.copy(filePath, outputDir) #copies the file to the outputDir
    