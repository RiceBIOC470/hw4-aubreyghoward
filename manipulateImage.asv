function [imgtemp1] = manipulateImage(imgInput,SmoothingFilterType,Hsize,Sigma,BgSubElementShape,BgSubElementSize)
    switch nargin
        case 6
            imgtemp1 = im2double(imgInput);
            imgtemp_sm = imfilter(imgtemp1,fspecial(SmoothingFilterType,Hsize,Sigma));
            imgtemp_bg = imopen(imgtemp_sm,strel(BgStrEl,BgStrElSize));
            imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
        case 5
            imgtemp1 = im2double(imgInput);
            imgtemp_sm = imfilter(imgtemp1,fspecial(SmoothingFilterType,Hsize,Sigma));
            imgtemp_bg = imopen(imgtemp_sm,strel(BgStrEl,50));
            imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
        case 4
            imgtemp1 = im2double(imgInput);
            imgtemp_sm = imfilter(imgtemp1,fspecial(SmoothingFilterType,Hsize,Sigma));
            imgtemp_bg = imopen(imgtemp_sm,strel('disk',50));
            imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
        case 3
            imgtemp1 = im2double(imgInput);
            imgtemp_sm = imfilter(imgtemp1,fspecial(SmoothingFilterType,Hsize));
            imgtemp_bg = imopen(imgtemp_sm,strel('disk',50));
            imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
        case 2
            imgtemp1 = im2double(imgInput);
            imgtemp_sm = imfilter(imgtemp1,fspecial(SmoothingFilterType));
            imgtemp_bg = imopen(imgtemp_sm,strel('disk',50));
            imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
        case 1
            disp('Default Filter set to "Gaussian, Hsize = 4, Sigma = 2"')
            imgtemp1 = im2double(imgInput);
            imgtemp_sm = imfilter(imgtemp1,fspecial('gaussian',4,2));
            imgtemp_bg = imopen(imgtemp_sm,strel('disk',50));
            imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
        case 0
            disp('No image selected. Please input an image to process.')
    end           
end
    
% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when calling the function.