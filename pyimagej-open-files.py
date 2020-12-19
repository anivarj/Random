
import os
from tkinter.filedialog import askdirectory
import imagej 
from skimage import io
import numpy as np
import napari 

# Choose your raw data location
targetWorkspace = askdirectory(initialdir='~/', message='SELECT YOUR DATA LOCATION') 

filePaths = [] #future list of paths to all original files

#This section gets a list of files inside targetWorkspace and adds the full paths to origPaths list
for dirpath, dirnames, files in os.walk(targetWorkspace): #walks through targetWorkspace
    files = [f for f in files if not f[0] == '.']         #excludes hidden files in the files list
    dirnames = [d for d in dirnames if not d[0] == '.']   #excludes hidden directories in dirnames list
    
    for file in files:                                                 
        filePaths.append(os.path.join(dirpath, file))     #for each file, get the full path to it's location


ij = imagej.init('sc.fiji:fiji')


for file in filePaths:
    ij_img = ij.io().open(file)
    py_img = ij.py.from_java(ij_img) #[ZXY]

py_img

delFront = np.delete(py_img, np.s_[:4], 0)
delEnd = np.delete(py_img, np.s_[76:80:1], 0)
newImg = delFront- delEnd
newImg

%gui qt
viewer = napari.view_image(newImg)