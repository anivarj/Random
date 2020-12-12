#!/usr/bin/env python3

'''
This script is to copy files from multiple folders to a single output location
1. Ask you for a target directory where your raw data is.
2. Ask you where you want your output data to go
3. Get a list of all the raw data folder names 
4. Copy the rawMAX.tif files from each scan folder into the output location
'''

import os, fnmatch, shutil
from tkinter.filedialog import askdirectory

targetWorkspace = askdirectory(initialdir='/Volumes/Bugsbunny', message='SELECT YOUR RAW DATA LOCATION') #choose your raw data location 
destination = askdirectory(initialdir=targetWorkspace, message='SELECT DESTINATION LOCATION') #choose where you want your folders to be created

#Gets a list of directories in the targetWorkspace and makes a list of names
directories = [d for d in os.listdir(targetWorkspace) if os.path.isdir(os.path.join(targetWorkspace, d))]
directories.remove("Analysis") #Currently I store my analysis output in a folder called 'Analysis', so I exlcude this from the list of scans.


fileID = 'MAX_C1*' #string to parse for
#fileID = 'MAX_C2*' #string to parse for
#fileID = 'Merged*' #string to parse for

for d in directories:
    print("d is:", d) #print directory name (sanity check)
    dirPath = os.path.join(os.path.join(targetWorkspace, d), 'processed/MAX/rawMAX') #gets the full path to the rawMAX folder
    print("dirPath is:", dirPath) #sanity check

    for file in os.listdir(dirPath): #for file in the dirPath
        if fnmatch.fnmatch(file, fileID): #pattern matches to whatever is specified in fileID
            filePath = os.path.join(dirPath, file) #if it matches, makes a fill path to the file
            shutil.copy(filePath, destination) #copies the file to the outputDir
    