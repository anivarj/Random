//This script will get the metadata from raw FV1000 .tif hyperstacks (NOT MAX PROJECTIONS) and output it to a file
//If you want to record laser power, you must use the hyperstack.
//The script asks for a directory containing .tif files and imports them one by one
//The script parses the metadata using bioformats macro extensions and outputs it to a text file in the same directory


//Create directory chooser
Dialog.create("Metadata Parser");  						//title
Dialog.addDirectory("Choose your files location", ""); //directory chooser
Dialog.show(); 										   //display dialog box
path = Dialog.getString(); 							   //get path to the location chosen
list = getFileList(path); 							   //get list of file names in the directory
files = newArray();									  //list for file names

//Loop through the directory and find .tif files
for (i=0; i<list.length; i++){
	if (endsWith(list[i], ".tif")){
		files = Array.concat(files, list[i]);	//.tif files are added to the 'files' array
	}		
}

f = File.open(path+"output.txt");    										 //create path to output file
print(f, "Name \t nChannels \t Ch1Laser \t Ch2Laser \t pxSize \t Interval"); //print headers
run("Bio-Formats Macro Extensions"); 										//macro extensions for getting metadata

//get metadata for each file in the list
for (i=0; i<files.length; i++){
	fullpath = path + files[i];
	open(fullpath);						//open the file
	title = getTitle();					//get title
	Ext.setId(fullpath); 				//set the current image
	Ext.getSizeC(sizeC); 				//get nChannels 
	Ext.getPixelsTimeIncrement(sizeT)   //get interval
	Ext.getPixelsPhysicalSizeX(sizeX)   //get pixel size
	Ext.getMetadataValue("[Acquisition Parameters Common] LaserTransmissivity01", Ch1excitation); //get Ch1 laser voltage
	Ext.getMetadataValue("[Acquisition Parameters Common] LaserTransmissivity02", Ch2excitation); //get Ch2 laser voltage. 

	//store variables as strings
	nChannels = toString(sizeC);
	Ch1Laser = toString(Ch1excitation);
	Ch2Laser = toString(Ch2excitation);
	pxSize = toString(sizeX);
	Interval = toString(sizeT);

	//print output to file (tab separated)
	print(f, toString(title) + " \t " + sizeC + " \t " + Ch1excitation + " \t " + Ch2excitation + " \t " + sizeX + " \t " + sizeT);
	
	close(title); //close image
}
print("Done with script!");
Ext.close();
