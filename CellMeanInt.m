% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).
function [MeanInt] = CellMeanInt(img,imgMask)
cell_props = regionprops(imgMask,img,'MeanIntensity');
MeanInt = cat(1,cell_props.MeanIntensity);
end