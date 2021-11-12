function [trainX,trainY,testX,testY] = loadDataset(path,trainPortion)
    dataset=load(path);
    totalX=dataset.FeatVectSel;
    totalY=dataset.Trg;
    
    totalX=totalX';
    totalY=totalY';
    
    [rows,cols]=size(totalY);
    divideIndex=round(trainPortion*cols);
    
    trainX=totalX(:,1:divideIndex);
    trainY=totalY(:,1:divideIndex);
    testX=totalX(:,divideIndex:end);
    testY=totalY(:,divideIndex:end);
    
    newTrainX=[];
    newTrainY=[];
    [rows,cols]=size(trainX);
    i=1;
    while i<=cols
        if trainY(i)==1
            initialSample=i;
            while trainY(i)==1
                i=i+1;
            end
            endSample=i-1;
            duration=endSample-initialSample;
            ictalX=trainX(:,initialSample:endSample);
            ictalY=trainY(initialSample:endSample);
            
            if initialSample-duration<1
                preictalX=trainX(:,1:initialSample-1);
                preictalY=trainY(1:initialSample-1);
            else
                preictalX=trainX(:,initialSample-duration-1:initialSample-1);
                preictalY=trainY(initialSample-duration-1:initialSample-1);
            end
            
            if endSample+duration>cols
                interictalX=trainX(:,endSample+1:end);
                interictalY=trainY(endSample+1:end);
            else
                interictalX=trainX(:,endSample+1:endSample+duration+1);
                interictalY=trainY(endSample+1:endSample+duration+1);
            end
            
            interictalY(:)=2;
            bitX=[preictalX,ictalX,interictalX];
            bitY=[preictalY,ictalY,interictalY];
            
            newTrainX=[newTrainX bitX];
            newTrainY=[newTrainY bitY];
        end
        i=i+1;
    end
    trainX=newTrainX;
    trainY=newTrainY+1;
    
    
    newTestX=[];
    newTestY=[];
    [rows,cols]=size(testX);
    i=1;
    while i<=cols
        if testY(i)==1
            initialSample=i;
            while testY(i)==1
                i=i+1;
            end
            endSample=i-1;
            duration=endSample-initialSample;
            ictalX=testX(:,initialSample:endSample);
            ictalY=testY(initialSample:endSample);
            
            if initialSample-duration<1
                preictalX=testX(:,1:initialSample-1);
                preictalY=testY(1:initialSample-1);
            else
                preictalX=testX(:,initialSample-duration-1:initialSample-1);
                preictalY=testY(initialSample-duration-1:initialSample-1);
            end
            
            if endSample+duration>cols
                interictalX=testX(:,endSample+1:end);
                interictalY=testY(endSample+1:end);
            else
                interictalX=testX(:,endSample+1:endSample+duration+1);
                interictalY=testY(endSample+1:endSample+duration+1);
            end
            
            interictalY(:)=2;
            bitX=[preictalX,ictalX,interictalX];
            bitY=[preictalY,ictalY,interictalY];
            
            newTestX=[newTestX bitX];
            newTestY=[newTestY bitY];
        end
        i=i+1;
    end
    testX=newTestX;
    testY=newTestY+1;
end

