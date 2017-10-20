% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image. 

function [imgOut] = imclean(imgInput,elementSize)

for ii = 1:elementSize
imTemp = imdilate(imgInput,strel('disk',elementSize*2));
imTemp = imerode(imgInput,strel('disk',elementSize));
end
imTemp = imdilate(imgInput,strel('disk',elementSize));
imgOut = imTemp;
end