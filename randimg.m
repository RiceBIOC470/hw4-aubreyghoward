function img = randimg(pixelcount,bitnum)
    img = round((2^bitnum)*rand(pixelcount));
    
end




% 1. Write a function to generate an 8-bit image of size 1024x1024 with a random value 
% of the intensity in each pixel. Call your image rand8bit.tif. 