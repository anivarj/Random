# @File(label = "ROI directory", style = "directory") roiDir

"""
##AUTHOR: Ani Michaud (Varjabedian)

## DESCRIPTION: This script loads, measures and saves cellpose ROI data

1. Open all of your TIF images
2. Put all of your ROI files in a folder
3. Run script
  - script will ask for the folder containing the roi files
  - script will go through each open image window, find the corresponding roi file and overlay it
  - script will select all rois, measure all, and then create a flattened image with the label key
  - script will save all measurements in a .csv file in the roi folder

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
rm.runCommand("Associate", "true")
rm.runCommand("Show All with labels")
#for each image open..
for image in image_titles:
    imp = WindowManager.getImage(image)
    baseName = os.path.splitext(image)[0] #get the name without extension
    roiFile = baseName + "_ROISet.zip" #make the name for the text file
    roiFilePath = os.path.join(roiDir, roiFile) #make the path for the text file
    print(roiFilePath)
	
    IJ.openImage(roiFilePath) #open the roi text file

    rm.runCommand("Select All") #select all rois
    rm.runCommand(imp, "Measure") #measure all rois

    rm.runCommand(imp,"Show All") #show all rois
    imp2 = imp.flatten() #create a flattened key with rois and labels
    imp2.setTitle("labels_" + baseName + ".tif")
    imp2.show()
    rm.runCommand("Select All") 
    rm.runCommand("Delete") #delete all rois in manager
    imp.close()
    rm.runCommand(imp,"Show None")
	
    windowName = imp2.getTitle()
    flatPath = os.path.join(roiDir, windowName)
    IJ.saveAsTiff(imp2, flatPath) #save flattened image

csvFile = os.path.join(roiDir, "Measurements.csv") 
IJ.saveAs("Results", csvFile) #export measurements as csv file
