% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations

function img = cellmaker(cellsize)
    img = false(1024)
    centers = round(rand([20,2])*1024)
    img(centers) = true;
    img = imdilate(img,strel('disk',50))
    
    img_mask = imgx2 > 0.8
    
    img = imdilate(img,strel('disk',cellsize))
%     imgx2 = img2double(img)
%     img_mask = imgx2 > 0.8
%     centers = round(rand([20,2])*1024)
%     img = imdilate(img,strel('disk',cellsize))

end
