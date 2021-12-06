function [meanRAll,meanGAll,meanBAll] = datasetTransformation(class)
%DATASETTRANSFORMATION Summary of this function goes here
%   Detailed explanation goes here
    
    path = class;
   
    myFiles = dir(fullfile(path,'*.jpg')); %gets all wav files in struct
    meanRAll=[];
    meanBAll=[];
    meanGAll=[];
    for k = 1:length(myFiles)
      fileName = myFiles(k).name;
 
        image = imread(append(path, fileName));
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
        
        meanRAll=[meanRAll meanR];
        meanBAll=[meanBAll meanB];
        meanGAll=[meanGAll meanG];
    end
    
    meanRAll=mean(meanRAll);
    meanGAll=mean(meanGAll);
    meanBAll=mean(meanBAll);
    
end

