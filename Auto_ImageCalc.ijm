//This is a barebones template for getting all open windows and running image calculator functions
// The default is set to take two channel data and subtract one from the other, but it can be modified accordingly


//Create directory chooser
Dialog.create("Auto image calculator");  //title
Dialog.addDirectory("Choose your output location", ""); //directory chooser
items = newArray("CH1", "CH2"); //choice array
Dialog.addChoice("Primary image (being acted upon)", items, "CH1"); //primary image choice
Dialog.addChoice("Secondary image (used to subtract", items, "CH2"); //secondary image choice
Dialog.show(); //display dialog box
path = Dialog.getString(); //get path to the location chosen
primary = Dialog.getChoice(); //get choice for primary channel
secondary = Dialog.getChoice(); //get choice for secondary channel

//get list of all open image windows
titles = getList("image.titles");

//loop for each window in the list
for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle(); //get full name of window
		dotIndex = lastIndexOf(name, "."); //get the index of the right-most '.' in the file name

		nameWithoutExtension =  substring(name, 0, dotIndex); //get the name of the file without extension
		
		run("Split Channels"); //split the channels
		C1 = "C1-" + nameWithoutExtension + ".tif"; //get CH1
		C2 = "C2-" + nameWithoutExtension + ".tif"; //get CH2
		
		//Subtract images based on choices from dialog box
		if (primary == "CH1") {
			imageCalculator("Subtract create stack", C1 , C2); //run image calculator. Change this function if you wish to do a different operation
		} else if (primary == "CH2") {
			imageCalculator("Subtract create stack", C2 , C1); //run image calculator. Change this function if you wish to do a different operation
		}
		
		result = getTitle(); //get title of resultant image
		prefix = substring(result, 10, 13); //get channel prefix of resultimg image
		newName = prefix + nameWithoutExtension + "_subtracted"; //rename the window. change suffix depending on what math you are performing
		
		//save the new image
		savePath = path + newName; //output location full path
		saveAs("TIFF", savePath); //save the image as a .tif

		//close all windows for that file
		close(newName+".tif"); 
		close(C1); 
		close(C2);
}

