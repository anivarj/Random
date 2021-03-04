
//This is a barebones template for getting all open windows and doing something to each of them

//get list of all open image windows
titles = getList("image.titles");

for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle();
		dotIndex = indexOf(name, ".");
		nameWithoutExtension =  substring(name, 0, dotIndex);
		
		//put your run commands here
		run("Z Project...", "projection=[Max Intensity] all");
		//savePath = "Path/To/Destination/" + nameWithoutExtension; 
		//saveAs("TIFF", savePath);
}

