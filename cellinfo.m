% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 

function [cellCount,cellArea,avgInt] = cellinfo(imgInput,maskInput)
            imTemp = manipulateImage(imgInput,'gaussian',5,3);

           % figure(99);imshow(maskInput,[]);figure(98);imshow(imTemp,[]);
            CellProps = regionprops(maskInput,imTemp,'MeanIntensity','Area','Centroid');
            cellArea = mean([CellProps.Area]);
           
            %figure(100);hist([CellProps.Area]);
            stdev = std([CellProps.Area]);
            ids = find([CellProps.Area] > (cellArea-stdev));
            cellCount = length(ids);
            
            avgInt = mean([CellProps.MeanIntensity]);
end