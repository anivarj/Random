//This script will get the metadata from raw FV1000 .tif hyperstacks (NOT MAX PROJECTIONS) and output it to a file
//If you want to record laser power, you must use the hyperstack.
//The script asks for a directory containing .oif files and imports them one by one
//The script parses the metadata using bioformats macro extensions and outputs it to a text file in the same directory

//Create directory chooser
Dialog.create("Metadata Parser");  						//title
Dialog.addDirectory("Choose your files location", ""); //directory chooser
Dialog.show(); 										   //display dialog box
path = Dialog.getString(); 							   //get path to the location chosen
list = getFileList(path); 							   //get list of file names in the directory
files = newArray();									  //list for file names

//Loop through the directory and find .oif files
for (i=0; i<list.length; i++){
	if (endsWith(list[i], ".oif")){
		files = Array.concat(files, list[i]);	//.tif files are added to the 'files' array
	}		
}

f = File.open(path+"output.txt");        //create path to output file
print(f, "Name \t nChannels \t Ch1Laser \t Ch2Laser \t Ch1voltage \t Ch2voltage \t Ch1HV \t Ch2HV \t pxSize \t Interval"); //print headers
run("Bio-Formats Macro Extensions"); 	//macro extensions for getting metadata

//get metadata for each file in the list
for (i=0; i<files.length; i++){
	fullpath = path + files[i];
	//open(fullpath);						//open the file
	run("Bio-Formats Importer", "open=" + fullpath + " autoscale color_mode=Default display_metadata rois_import=[ROI manager] view=[Metadata only] stack_order=Default"); //opens metadata for file
	Ext.setId(fullpath); 				//set the current image
	Ext.getMetadataValue("[File Info] DataName", title); //get image name
	Ext.getSizeC(sizeC); 				//get nChannels 
	Ext.getPixelsTimeIncrement(sizeT)   //get interval
	Ext.getPixelsPhysicalSizeX(sizeX)   //get pixel size
	
	Ext.getMetadataValue("[Acquisition Parameters Common] LaserWavelength01", Ch1wavelength); //Ch1 laser line
	Ext.getMetadataValue("[Acquisition Parameters Common] LaserWavelength02", Ch2wavelength); //Ch1 laser line
	Ext.getMetadataValue("[Acquisition Parameters Common] LaserTransmissivity01", Ch1voltage); //get Ch1 laser voltage
	Ext.getMetadataValue("[Acquisition Parameters Common] LaserTransmissivity02", Ch2voltage); //get Ch2 laser voltage. 
	Ext.getMetadataValue("[Channel 1 Parameters] AnalogPMTVoltage", Ch1HV); //get Ch1 gain
	Ext.getMetadataValue("[Channel 2 Parameters] AnalogPMTVoltage", Ch2HV); //get Ch2 gain
	
	
	//store variables as strings
	nChannels = toString(sizeC);
	pxSize = toString(sizeX);
	Interval = toString(sizeT);
	Ch1wavelength = toString(Ch1wavelength);
	Ch2wavelength = toString(Ch2wavelength);
	Ch1voltage = toString(Ch1voltage);
	Ch2voltage = toString(Ch2voltage);
	Ch1HV = toString(Ch1HV);
	Ch2HV = toString(Ch2HV);


	//print output to file (tab separated)
	print(f, title + " \t " + sizeC + " \t " + Ch1wavelength + " \t " + Ch2wavelength +  " \t " + Ch1voltage + " \t " + Ch2voltage + " \t " + Ch1HV + " \t" + Ch2HV + " \t" + sizeX + " \t " + sizeT);
	
	close("Original Metadata - " + title); //close image
}
print("Done with script!");
Ext.close(); //close active dataset
