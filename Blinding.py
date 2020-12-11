import os
import pandas as pd

from tkinter.filedialog import askdirectory

targetWorkspace = askdirectory(initialdir='/Volumes/Bugsbunny', message='SELECT YOUR DATA LOCATION') #choose your raw data location 


paths = [] #creates an empty list of 

for dirpath, dirnames, files in os.walk(targetWorkspace): #os.walk produces a full path to the targetWorkspace, and a list of subfolders and files
    for file in files:  #for each file name in a sub directory, make a full path by joining the file name with the full path to the subdirectory
        paths.append(os.path.join(dirpath, file)) #append the full path to the paths list

headers = ["Full Path", "File Name" "New File Name", "New Full Path"]
table = pd.DataFrame(columns=[headers])
table[Full Path]







