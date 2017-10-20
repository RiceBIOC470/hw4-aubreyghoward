function [imgOut] = autothresh (imgInput)
% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 

averageInt = mean(imgInput(:));
stdInt = std(imgInput(:));
minInt = min(imgInput(:));
maxInt = max(imgInput(:));

if averageInt - stdInt*2 >= 0
    bottom10 = (maxInt - minInt)*0.1;
    imgOut = imgInput > bottom10;
else
    imgOut = imgInput > stdInt;
end
end