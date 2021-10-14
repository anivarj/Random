import pandas as pd
import os
from tkinter.filedialog import askdirectory

def findDirs(targetWorkspace):                                 
    dirList = [os.path.join(targetWorkspace, fname) for fname in os.listdir(targetWorkspace) if os.path.isdir(os.path.join(targetWorkspace, fname))] #lists of complete paths to all immediate subdirectories
    return(dirList)

#def concatFiles(dirList):
    #for dir in dirList:
     #   s



## main function ##  
targetWorkspace = askdirectory(initialdir="~", message="PLEASE SELECT YOUR SOURCE WORKSPACE") #ask for parent directory
dirList = findDirs(targetWorkspace)   #list of all the immediate subdirectories in the targetWorkspace

