
//This macro imports an image sequence in chunks, crops it to a saved ROI, and then saves it
// In the for loop, set i= to the first slice you want imported
//In the for loop, set i< to 1 + the last slice you want imported 

for (i = 3801; i < 3840; i++) {
start=i; //starting import frame
count=39; //Set to the chunksize you want to import
end = start + count -1; //ending import frame 

print("start:", start);
print("end: ", end);

//Import image sequence based on your parameters
//change the dir to where you have your tifs saved 
run("Image Sequence...", "dir=/Volumes/BugsBunny/Data/fromOthers/huiskenlab/2019/03012019/mip/c01/ start=["+start+"] count=["+count+"] sort use");
name = getTitle();

//Import ROI and crop
//change the path to where you have your ROI file saved
open("/Volumes/BugsBunny/Data/fromOthers/huiskenlab/2019/03012019/mip/cropROI.roi");
run("Crop");

//Save cropped file
//change the savePath to where you want your output saved 
savePath = "/Volumes/BugsBunny/Data/fromOthers/huiskenlab/2019/03012019/mip/output/" + name + "_frames" +start+ "-" + end;
saveAs("TIFF", savePath);
close();

i = i + 49; //increment number should be changed according to your count. If count = 50, you should increment i by 49 so the next start value = 51
IJ.freeMemory(); //calls garbage collection to free up memory 
}