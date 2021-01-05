//@ File(label = "Output Location", style = "directory") destination

//This macro gets a list of all open plot profiles and saves the measurements in .csv files
//The csv files can later be concatenated if desired


//get list of all open images
titles = getList("image.titles");

//for each image in the list, get the measurements and save them as .csv file
for (i=0; i<titles.length; i++){
    selectWindow(titles[i]);
    name = getTitle(); 
    newName = name.substring(17); //remove the 'Peaks in Plot of ' part of the name
    Plot.showValues("Plot Values");
    savePath = destination + "/" + newName + "-values.csv";
    print(savePath);  
    saveAs("Measurements", savePath);
}

//close the measurement windows. Leaves plots open
measurements = getList("window.titles");
for (i=0; i<measurements.length; i++){
	close(measurements[i]);
}

//close all open windows 
run("Close All");