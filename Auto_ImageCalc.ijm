
//This is a barebones template for getting all open windows and running image calculator functions

//get list of all open image windows
titles = getList("image.titles");

for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle(); //get full name of window
		dotIndex = lastIndexOf(name, "."); //get the index of the right-most '.' in the file name

		nameWithoutExtension =  substring(name, 0, dotIndex); //get the name of the file without extension
		
		run("Split Channels");
		C1 = "C1-" + nameWithoutExtension; 
		C2 = "C2-" + nameWithoutExtension; 
		
		imageCalculator("Subtract create stack", C2+".tif" , C1+".tif"); //run image calculator
		selectWindow("Result of " + C2+".tif"); //select resulting window
		newName = C2 + "_subtracted"; //rename the window. change this depending on what math you are performing

		//save the new image
		savePath = "/Volumes/speedyG/Data/2021/Exp302_12-21-2021/subtracted/" + newName; 
		saveAs("TIFF", savePath);

		//close all windows for that file
		close(newName+".tif"); 
		close(C1+".tif"); 
		close(C2+".tif");
}

