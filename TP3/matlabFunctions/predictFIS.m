rootPath="../Maturity/Class 6/";
myFiles = dir(fullfile(rootPath,'*.jpg'));

for k = 1:length(myFiles)
    fileName = myFiles(k).name;
    fileName = append(rootPath, fileName);
    [meanR,meanG,meanB] =computeMeanChannels(fileName);
    
    FISMAT=readfis('FIS_gaussmf.fis');
    predictions = evalfis(FISMAT,[meanR,meanG,meanB]);
    hold on;
    scatter(k,predictions,15,'red');
        
end