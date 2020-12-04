'''
This script will quickly grab all open windows and extract the name and number of slices.
This information will be exported to a text file in a directory of your choosing (outputDir).
Uses imageJ parameter arguments #@ notation so must be run from script editor
'''
#@File(label = "output directory", style = "directory") outputDir

import os
from ij import IJ, WindowManager, ImagePlus

outputDir = str(outputDir) 												#turns the path collected into a string
outputFile = open(os.path.join(outputDir, "names-nSlices.txt"), "w")	#opens a new text file at the location specified and names it 'names-nSlices.txt'
outputFile.write("Scan names and number of slices" + "\n")				#prints this line to the text file

idList = WindowManager.getIDList()	#gets a list of all image IDs for open images

for i in idList:
	imp = WindowManager.getImage(i)					#selects that image
	name = imp.getTitle()							#gets the window title
	slices = str(imp.getNFrames())					#collects number of frames and turns it into a string
	outputFile.write(name + " " + slices + "\n")	#writes the name and nSlices in the text file, separated by a space

outputFile.close()	#close text file. This needs to be done for the writing to show up

print("done with script") #sanity check


	