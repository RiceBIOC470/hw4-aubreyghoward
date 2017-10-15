% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations

function img_mask = cellmaker(cellsize)
    img = false(1024);
    centers = ceil(rand([20,2])*1024);
    for ii = 1:length(centers)
        img(centers(ii,1),centers(ii,2)) = 1;
    end
    img_mask = img > 0.5;
    img_mask = imdilate(img_mask,strel('disk',cellsize));


end
