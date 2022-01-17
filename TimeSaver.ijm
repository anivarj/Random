
//This is a barebones template for getting all open windows and doing something to each of them

//get list of all open image windows
titles = getList("image.titles");

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
		newName = nameWithoutExtension + "-1-100";
		run("Duplicate...", "duplicate range=1-100");
		savePath = "/Volumes/speedyG/Data/2022/Exp303_01-13-2022_SF/Analysis/" + newName; 
		saveAs("TIFF", savePath);
		
}

