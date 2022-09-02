
//This is a barebones template for getting all open windows and doing something to each of them

//get list of all open image windows
titles = getList("image.titles");
//outputPath = getDirectory("Get File"); //asks where you want to save files (if saving).
for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle();
		dotIndex = lastIndexOf(name, ".");
		nameWithoutExtension =  substring(name, 0, dotIndex);
		
		//put your run commands here
		//run("Properties...");
		//getPixelSize(unit, pixelWidth, pixelHeight);
		//interval = Stack.getFrameInterval();
		//print(name, pixelWidth, interval);
		
		//run("Z Project...", "projection=[Max Intensity] all");
		newName = getTitle();
		savePath = outputPath + newName; //full path to save location
		saveAs("TIFF", savePath);
		
}

