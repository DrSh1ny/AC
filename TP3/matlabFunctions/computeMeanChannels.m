function [meanR,meanG,meanB] = computeMeanChannels(path)
%DATASETTRANSFORMATION Summary of this function goes here
%   Detailed explanation goes here
    

    image = imread(path);
    [BW,maskedRGBImage] = createMask(image);

    %Masks within range
    maskedRGBImage = normalize(maskedRGBImage,'range');
    redChannel = maskedRGBImage(:,:,1); % Red channel
    greenChannel = maskedRGBImage(:,:,2); % Green channel
    blueChannel = maskedRGBImage(:,:,3); % Blue channel

    indices = find(BW);

    %Thresholds
    thresholdRed = redChannel(indices);
    thresholdGreen = greenChannel(indices);
    thresholdBlue = blueChannel(indices);

    %Averages
    meanR = mean2(thresholdRed);
    meanG = mean2(thresholdGreen);
    meanB = mean2(thresholdBlue);

end

