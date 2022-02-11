//This is a barebones template for getting all open windows and running image calculator functions
// The default is set to take two channel data and subtract one from the other, but it can be modified accordingly


//Create directory chooser
Dialog.create("Auto image calculator");  
Dialog.addDirectory("Choose your output location", "");
Dialog.show();
path = Dialog.getString(); //get path to the location chosen

//get list of all open image windows
titles = getList("image.titles");

//loop for each window in the list
for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle(); //get full name of window
		dotIndex = lastIndexOf(name, "."); //get the index of the right-most '.' in the file name

		nameWithoutExtension =  substring(name, 0, dotIndex); //get the name of the file without extension
		
		run("Split Channels"); //split the channels
		C1 = "C1-" + nameWithoutExtension; //get CH1
		C2 = "C2-" + nameWithoutExtension; //get CH2

		//Subtract C1 from C2
		imageCalculator("Subtract create stack", C2+".tif" , C1+".tif"); //run image calculator
		selectWindow("Result of " + C2+".tif"); //select resulting window
		newName = C2 + "_subtracted"; //rename the window. change this depending on what math you are performing

		//save the new image
		savePath = path + newName; //output location full path
		saveAs("TIFF", savePath); //save the image as a .tif

		//close all windows for that file
		close(newName+".tif"); 
		close(C1+".tif"); 
		close(C2+".tif");
}

