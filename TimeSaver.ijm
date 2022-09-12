
//This is a barebones template for getting all open windows and doing something to each of them

//get list of all open image windows
titles = getList("image.titles");
outputPath = getDirectory("Get File"); //asks where you want to save files (if saving).
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
		//run("8-bit");
		//Stack.setXUnit("micron");
		//run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2 pixel_height=0.2 voxel_depth=0");
		//run("Apply LUT");
		//newName = nameWithoutExtension + "_displayAdjusted";
		//savePath = outputPath + newName; //full path to save location
		//saveAs("TIFF", savePath);
		
}

