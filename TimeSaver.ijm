
//This is a barebones template for getting all open windows and doing something to each of them

//get list of all open image windows
titles = getList("image.titles");

for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle();
		dotIndex = indexOf(name, ".");
		nameWithoutExtension =  substring(name, 0, dotIndex);
		
		//put your run commands here
		//run("Properties...");
		//getPixelSize(unit, pixelWidth, pixelHeight);
		//interval = Stack.getFrameInterval();
		//print(name, pixelWidth, interval);
		
		//run("Z Project...", "projection=[Max Intensity] all");
		run("Duplicate...", "duplicate range=1-60");
		nameWithoutExtension = nameWithoutExtension + "_cropped";
		savePath = "/Volumes/speedyG/Data/2022/Exp304_01-21-2022_SF/Analysis/cropped/" + nameWithoutExtension; 
		saveAs("TIFF", savePath);
		
}

