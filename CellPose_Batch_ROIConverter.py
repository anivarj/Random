# @File(label = "ROI directory", style = "directory") roiDir

"""
##AUTHOR: Ani Michaud (Varjabedian)

## DESCRIPTION: This script automates running cellpose's ROI converter for all open windows

1. Open all of your TIF images
2. Put all of your ROI text files in one folder
3. Run script
  - script will ask for the folder containing the text files
  - script will go through each open image window, find the corresponding roi text file and perform the conversion
  - ROI sets will be saved as .zip files in the roi directory

For more information and up-to-date changes, visit the GitHub repository: https://github.com/anivarj/

"""


from ij import IJ, WindowManager, ImagePlus
from ij.plugin.frame import RoiManager
from ij.gui import PolygonRoi
from ij.gui import Roi

import os

#turn the directory path into a string
roiDir= str(roiDir)

#get list of all open image windows
image_titles = [WindowManager.getImage(id).getTitle() for id in WindowManager.getIDList()]

#initiate ROIManager
RM = RoiManager()
rm = RM.getRoiManager()

#for each image open..
for image in image_titles:
    imp = IJ.getImage()
    baseName = os.path.splitext(image)[0] #get the name without extension
    roiFile = baseName + "_cp_outlines.txt" #make the name for the text file
    roiFilePath = os.path.join(roiDir, roiFile) #make the path for the text file
    print(roiFilePath)
	
    textfile = open(roiFilePath, "r") #open the text file

	#for each line in the text file, use cellpose's conversion to create ROIs
    for line in textfile:
        xy = map(int, line.rstrip().split(","))  
        X = xy[::2]
        Y = xy[1::2]
        imp.setRoi(PolygonRoi(X, Y, Roi.POLYGON))
        roi = imp.getRoi()
        print(roi)
        rm.addRoi(roi)

    #close the text file, select all ROIs and save as .zip file
    textfile.close()
    roiZipName = baseName + "_ROISet.zip"
    roiZipPath = os.path.join(roiDir, roiZipName)
    rm.runCommand("Associate", "true")
    rm.runCommand("Show All with labels")
    rm.runCommand("Select All")
    rm.runCommand("Save", roiZipPath)
    rm.runCommand("Delete")