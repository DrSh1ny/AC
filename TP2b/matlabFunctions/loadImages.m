function [trainXIm,trainYIm,testXIm,testYIm] = loadImages(path,trainPortion)
    [trainX,trainY,testX,testY]=loadDataset(path,trainPortion);
    originalX=[trainX testX];
    originalY=[trainY testY];
    
    originalX = normalize(originalX,'range');
    
    preictal=originalX(:,find(originalY==1));
    ictal=originalX(:,find(originalY==2));
    posictal=originalX(:,find(originalY==3));
    
    imagesPreictal=zeros(29,29,1,1);
    for i=[1:29:size(preictal,2)-29]
        image=preictal(:,i:i+28);
        imagesPreictal=cat(4,imagesPreictal,image);
    end
    imagesPreictal=imagesPreictal(:,:,:,2:end);
    imagesPreictalY=repmat([1],1,size(imagesPreictal,4));
    
    imagesIctal=zeros(29,29,1,1);
    for i=[1:29:size(preictal,2)-29]
        image=ictal(:,i:i+28);
        imagesIctal=cat(4,imagesIctal,image);
    end
    imagesIctal=imagesIctal(:,:,:,2:end);
    imagesIctalY=repmat([2],1,size(imagesIctal,4));
    
    imagesPosictal=zeros(29,29,1,1);
    for i=[1:29:size(preictal,2)-29]
        image=posictal(:,i:i+28);
        imagesPosictal=cat(4,imagesPosictal,image);
    end
    imagesPosictal=imagesPosictal(:,:,:,2:end);
    imagesPosictalY=repmat([3],1,size(imagesPosictal,4));
    
    trainXIm=cat(4,imagesPreictal,imagesIctal);
    trainXIm=cat(4,trainXIm,imagesPosictal);
    
    trainYIm=cat(2,imagesPreictalY,imagesIctalY);
    trainYIm=cat(2,trainYIm,imagesPosictalY);
    
    totalSize=size(trainYIm,2);
    middleIdx=round(totalSize*trainPortion);
    permutations=randperm(size(trainXIm, 4));
    trainXIm = trainXIm(:,:,:,permutations);
    trainYIm = trainYIm(:,permutations);
    
    testXIm=trainXIm(:,:,:,middleIdx+1:end);
    testYIm=trainYIm(:,middleIdx+1:end);
    
    trainXIm=trainXIm(:,:,:,1:middleIdx);
    trainYIm=trainYIm(:,1:middleIdx);
    
    trainYIm=categorical(trainYIm)';
    testYIm=categorical(testYIm)';
end

