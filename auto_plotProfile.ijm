//@ File(label = "Output Location", style = "directory") destination

//This macro: 
    // Makes plot profiles for all open images (need to have ROIs on each image)
    // Runs BAR -> Find Peaks for all plot profiles
    // expports all measurements to .csv files at a destination of your choosing

//makes plot profiles for all open images. Images must each have an ROI overlaid
function makePlots(){
	titles = getList("image.titles");
	
	for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle();
		dotIndex = indexOf(name, ".");
		nameWithoutExtension =  substring(name, 0, dotIndex);
		run("Plot Profile");
	}
	
}

//finds each plot profile and runs 'find peaks' as part of BAR package. closes plotprofile windows
function findPeaks(){
	titles = getList("image.titles");
	
	for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		
		if (startsWith(titles[i], "Plot of ") == 1){
			run("Find Peaks", "min._peak_distance=0 min._value=[] max._value=[] exclude");
		}		
	}
	
	close("Plot of*"); //close all orig plotprofile windows
}

//finds all peak windows and saves measurements as separate .csv files
function saveMeasurements(){
	titles = getList("image.titles");
	
	for (i=0; i<titles.length; i++){
		if (startsWith(titles[i], "Peaks") == 1){
			selectWindow(titles[i]);
			name = getTitle(); 
    		newName = name.substring(17); //remove the 'Peaks in Plot of ' part of the name
			Plot.showValues("Plot Values");
    		savePath = destination + "/" + newName + "-values.csv";
    		saveAs("Measurements", savePath);
		}
	}
	
	close("Peaks*")
	close("*.csv")		

}

// Main function calls 
makePlots();
findPeaks();
saveMeasurements();

//run("Close All"); //close all image files. I generally leave this commented out until I'm sure the script does what I want
