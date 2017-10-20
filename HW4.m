%HW4
%% 
% Problem 1. 
clear all
% 1. Write a function to generate an 8-bit image of size 1024x1024 with a random value 
% of the intensity in each pixel. Call your image rand8bit.tif. 

[img]=randimg(1024,8);
%figure(1);imshow(img,[]);

% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations

[img2] = cellmaker(21);
%figure(2);imshow(img2,[]);

% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).

[MeanInt] = CellMeanInt(img,img2);

% 4. Plot the mean and standard deviation of the values in your output
% vector as a function of circle size. Explain your results. 

for ii = 1:80
    [img2] = cellmaker(ii);
    [MeanInt] = CellMeanInt(img,img2);
    y1(ii,:) = mean(MeanInt);
    y2(ii,:) = std(MeanInt);
end
    figure(3);
    plot (1:ii,y1,'r.-');
    hold on;
    figure(4);
    plot(1:ii,y2,'b*-')
    hold on;

hold off;
figure(3); xlabel('Circle Size'); ylabel('Average Circle Intensity')
figure(4); xlabel('Circle Size'); ylabel('Standard Deviation of Circle Intensity')


%We see a that as size of the circles increases to include more and more of 
%the same pixals as other circles, the standard deviation between those
%circles goes towards 0. Similarlly, the Average intensity of those circles
%trend towards a 128, which is the median pixal intensity value in an 8 bit
%image. 
%%
clear all
x = 1;
%Problem 2. Here is some data showing an NFKB reporter in ovarian cancer
%cells. 
%https://www.dropbox.com/sh/2dnyzq8800npke8/AABoG3TI6v7yTcL_bOnKTzyja?dl=0
%There are two files, each of which have multiple timepoints, z
%slices and channels. One channel marks the cell nuclei and the other
%contains the reporter which moves into the nucleus when the pathway is
%active. 
%
%Part 1. Use Fiji to import both data files, take maximum intensity
%projections in the z direction, concatentate the files, display both
%channels together with appropriate look up tables, and save the result as
%a movie in .avi format. Put comments in this file explaining the commands
%you used and save your .avi file in your repository (low quality ok for
%space). 

%First, I added both images to Fiji by File>Import>TIFF Virtual Stack. Next
%I used the Image>Stacks>Zproject>Max Intensity function for every slice to
%bring up the brightest pixels in each image. I concatenated the files
%using the Image>Stacks>Tools>Concatonate, selecting MAX_nfkb_movie1.tif 
%MAX_nfkb_movie2.tif as my two image inputs. Finally, as the nuclei are
%tagged with YFP and the chanel two is tagged with RFP, I set the colors 
%Image>Color>Merge Channels> selecting Channel 1 as green(analogous to yellow)
%and Channel 2 as red. I saved the image using FILE>Save As>AVI


%Part 2. Perform the same operations as in part 1 but use MATLAB code. You don't
%need to save the result in your repository, just the code that produces
%it. 

img1 = bfGetReader('nfkb_movie1.tif');
img2 = bfGetReader('nfkb_movie2.tif');

ind1 = img1.getIndex(0,0,0)+1;
ind2 = img1.getIndex(0,1,0)+1;
img1_brt1 = bfGetPlane(img1,ind1);
img1_brt2 = bfGetPlane(img1,ind1);
img1_brt = cat(3,img1_brt2,img1_brt1,zeros(size(img1_brt1)));
for ii = 1:img1.getSizeT
    ind1 = img1.getIndex(0,0,0)+1;
    ind2 = img1.getIndex(0,1,0)+1;
    img_max1 = bfGetPlane(img1,ind1);
    img_max2 = bfGetPlane(img1,ind2);
        for ii = 2:img1.getSizeZ
        ind1 = img1.getIndex(ii-1,0,ii-1)+1;
        ind2 = img1.getIndex(ii-1,1,ii-1)+1;
        imgTemp_ch1 = bfGetPlane(img1,ind1);
        imgTemp_ch2 = bfGetPlane(img1,ind2);
        img_max1 = max(img_max1,imgTemp_ch1);
        img_max2 = max(img_max2,imgTemp_ch2);
        end
    img_max = cat(3,img_max2,img_max1,zeros(size(img_max1)));
    %figure(x);subplot(4,5,i);imshow(img_max1,[]);
    img1_brt = cat(4,img1_brt,img_max);
end

ind1 = img2.getIndex(0,0,0)+1;
ind2 = img2.getIndex(0,1,0)+1;
img2_brt1 = bfGetPlane(img2,ind1);
img2_brt2 = bfGetPlane(img2,ind1);
img2_brt = cat(3,img2_brt2,img2_brt1,zeros(size(img2_brt1)));
for ii = 1:img2.getSizeT;
    ind1 = img2.getIndex(0,0,0)+1;
    ind2 = img2.getIndex(0,1,0)+1;
    img_max1 = bfGetPlane(img1,ind2);
    img_max2 = bfGetPlane(img2,ind2); 
        for ii = 2:img2.getSizeZ
        ind1 = img2.getIndex(ii-1,0,ii-1)+1;
        ind2 = img2.getIndex(ii-1,1,ii-1)+1;
        imgTemp_ch1 = bfGetPlane(img2,ind1);
        imgTemp_ch2 = bfGetPlane(img2,ind2);
        img_max1 = max(img_max1,imgTemp_ch1);
        img_max2 = max(img_max2,imgTemp_ch2);
        end
    img_max = cat(3,img_max2,img_max1,zeros(size(img_max1)));
    img2_brt = cat(4,img2_brt,img_max);
end


img2show = cat(4,img1_brt,img2_brt);
implay('Concatenated Stacks.avi')
implay(img2show)
    


%    This is fragments of incorrect code. Please ignore. 
%     iplane = img1.getIndex(ii-1,chan-1,time-1)+1;
%     imgtemp1 = bfGetPlane(img1,iplane);
%     imgtemp1 = im2double(imgtemp1);
%     imgtemp_sm = imfilter(imgtemp1,fspecial('gaussian',4,2));
%     imgtemp_bg = imopen(imgtemp_sm,strel('disk',100));
%     imgtemp1 = imsubtract(imgtemp_sm,imgtemp_bg);
%     
%    
%     imgtemp_dilate = imdilate(imgtemp1,strel('disk',25));
%     imgtemp1 = imgtemp1./imgtemp_dilate;
%     figure(ii); 
%     %imshow(imgtemp1,[])
%     imgtemp1(imgtemp1 < 0.5)= 0;
%     imshow(imgtemp1,[])
%     %figure(ii);imshow(imgtemp1,[]);
% for ii = 1:img2.getSizeZ
%     iplane = img1.getIndex(ii-1,chan-1,time-1)+1;
%     imgtemp2 = bfGetPlane(img2,iplane);
%     imgtemp2 = im2double(imgtemp2);
%     
%     imgtemp_sm = imfilter(imgtemp2,fspecial('gaussian',4,2));
%     imgtemp_bg = imopen(imgtemp_sm,strel('disk',100));
%     imgtemp2 = imsubtract(imgtemp_sm,imgtemp_bg);
%     
%     imgtemp_dilate = imdilate(imgtemp2,strel('disk',25));
%     imgtemp2 = imgtemp2./imgtemp_dilate;
%     figure(ii+img1.getSizeZ);imshow(imgtemp2,[]);
% end


%%
clear all
x =1;

% Problem 3. 
% Continue with the data from part 2
% 
% 1. Use your MATLAB code from Problem 2, Part 2  to generate a maximum
% intensity projection image of the first channel of the first time point
% of movie 1.
img1 = bfGetReader('nfkb_movie1.tif');
img2 = bfGetReader('nfkb_movie2.tif');
    ind1 = img1.getIndex(0,0,0)+1;
    img_max1 = bfGetPlane(img1,ind1);
        for ii = 2:img1.getSizeZ
        ind1 = img1.getIndex(ii-1,0,0)+1;
        imgTemp_ch1 = bfGetPlane(img1,ind1);
        img_max1 = max(img_max1,imgTemp_ch1);
        end
figure(x);imshow(img_max1,[]);


% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when calling the function.
img2show = manipulateImage(img_max1,'gaussian',5,3);
x = x+1;figure(x);imshow(img2show,[]);
% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 

img2show = autothresh(img2show);
x = x+1; figure(x);imshow(img2show);

% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image. 

img2show = imclean(img2show,5);
x = x+1; figure(x);imshow(img2show);

% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 
[cellCount,cellArea,avgInt] = cellinfo(img_max1,img2show);


% 6. Apply your function from (2) to make a smoothed, background subtracted
% image from channel 2 that corresponds to the image we have been using
% from channel 1 (that is the max intensity projection from the same time point). Apply your
% function from 5 to get the mean intensity of the cells in this channel. 
    ind1 = img1.getIndex(0,2,0)+1;
    img_max2 = bfGetPlane(img1,ind1);
        for ii = 2:img1.getSizeZ
        ind1 = img1.getIndex(ii-1,0,0)+1;
        imgTemp_ch2 = bfGetPlane(img1,ind1);
        img_max2 = max(img_max2,imgTemp_ch2);
        end
%figure(x);imshow(img_max2,[])
img2show2 = manipulateImage(img_max2,'gaussian',5,3);
imgMask = autothresh(img_max2);
imgMask = imclean(imgMask,8);
[cellCount,cellArea,avgInt] = cellinfo(img2show2,imgMask);

%%

% Problem 4. 
clear all
% 1. Write a loop that calls your functions from Problem 3 to produce binary masks
% for every time point in the two movies. Save a movie of the binary masks.
img1 = bfGetReader('nfkb_movie1.tif');
img2 = bfGetReader('nfkb_movie2.tif');

ind1 = img1.getIndex(0,0,0)+1;
maskmovie1 = bfGetPlane(img1,ind1);
for i = 1:img1.getSizeT
    i
    ind1 = img1.getIndex(0,0,i-1)+1;
    img_max = bfGetPlane(img1,ind1);
%     
%         for ii = 1:img1.getSizeZ
%         ind1 = img1.getIndex(ii-1,0,i-1)+1;
%         imgTemp_ch1 = bfGetPlane(img1,ind1);
%         img_max = max(img_max,imgTemp_ch1);
%         end
    figure(1);subplot(5,4,i);imshow(img_max,[]);
    imgTemp = autothresh(im2double(img_max));
    figure(2);subplot(5,4,i);imshow(imgTemp,[]);
    imgTemp = imclean(imgTemp,3);
    figure(3);subplot(5,4,i);imshow(imgTemp,[]);
    maskmovie1 = cat(4,maskmovie1,imgTemp);
end
imwrite(maskmovie1,'nfkb_maskmovie1.tif','TIFF');

ind2 = img2.getIndex(0,0,0)+1;
maskmovie2 = bfGetPlane(img2,ind2);
for ii = 1:img2.getSizeT
    ii
    ind2 = img2.getIndex(0,0,ii-1)+1;
    imgTemp = bfGetPlane(img2,ind2);
    imgTemp = autothresh(imgTemp);
    imgTemp = imclean(imgTemp,8);
    maskmovie2 = cat(4,maskmovie2,imgTemp);
end
imwrite(maskmovie2,'nfkb_maskmovie2.tif','TIFF');


% 2. Use a loop to call your function from problem 3, part 5 on each one of
% these masks and the corresponding images and 
% get the number of cells and the mean intensities in both
% channels as a function of time. Make plots of these with time on the
% x-axis and either number of cells or intensity on the y-axis. 

