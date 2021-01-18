//@ File(label = "Output Location", style = "directory") destination

//This macro: 
    // Runs simple ratio bleach correction on all open images
    // Saves the bleach-corrected files to an output location of your choosing


//runs bleach correction using simple ratio on all open windows
function bleach_correct(){
	titles = getList("image.titles");
	
	for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle();
		dotIndex = indexOf(name, ".");
		nameWithoutExtension =  substring(name, 0, dotIndex);
		run("Bleach Correction", "correction=[Simple Ratio] background=0");
	}
	
}

//finds all bleach-corrected windows and saves them in the designated output location
function saveWindows(){
	titles = getList("image.titles");
	for (i=0; i<titles.length; i++){
		if (startsWith(titles[i], "DUP") == 1){  //change this search string to whatever
			selectWindow(titles[i]);
			name = getTitle(); 
    		newName = name.substring(4); //remove the 'Peaks in Plot of ' part of the name
    		savePath = destination + "/" + newName + "_bleachcorr";
    		saveAs("Tiff", savePath);
		}
	}

}
bleach_correct();
saveWindows();
