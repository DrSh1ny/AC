trainPercentage=0.9;

for i=1:6
    class=append("../Maturity/Class ",num2str(i));
    class=append(class,"/"); 
    myFiles = dir(fullfile(class,'*.jpg')); %gets all wav files in struct
    
    division=round(length(myFiles)*trainPercentage);
    
    for k = 1:division
        fileName = myFiles(k).name;
        fullFileName=append(class,fileName);
        
        targetClassFolder=append("../dataset/train/",num2str(i)); 
        copyfile(fullFileName,targetClassFolder);

    end
    
    for j = division:length(myFiles)
        fileName = myFiles(j).name;
        fullFileName=append(class,fileName);
        
        targetClassFolder=append("../dataset/test/",num2str(i));
        
        copyfile(fullFileName,targetClassFolder);
    end
end

