%dataset distribution------------------------------------------------------
% dimensoes=[];
% for i=1:6
%     class=append("../dataset/train/",num2str(i));
%     class=append(class,"/"); 
%     myFiles = dir(fullfile(class,'*.jpg')); %gets all wav files in struct
%     lengTrain=length(myFiles);
%     
%     class=append("../dataset/test/",num2str(i));
%     class=append(class,"/"); 
%     myFiles = dir(fullfile(class,'*.jpg')); %gets all wav files in struct
%     lengTest=length(myFiles);
%     
%     dimensoes=[dimensoes; [lengTrain, lengTest]];
%     
% end
% 
% disp(dimensoes);

%color channel distribution per class--------------------------------------
% historyR=[];
% historyB=[];
% historyG=[];
% path="../dataset/train/";
% for i=1:6
%     class=append(path,num2str(i));
%     class=append(class,"/");
%     [r,g,b]=datasetTransformation(class);
%     historyR=[historyR, r];
%     historyB=[historyB, b];
%     historyG=[historyG, g];
% end

% scatter(1:6,historyR,30,'red');
% hold on;
% scatter(1:6,historyG,30,'green');
% hold on;
% scatter(1:6,historyB,30,'blue');
% legend('Red channel','Green channel','Blue channel');


%predictions for each image------------------------------------------------
% predictions=[];
% truth=[];
% for i=[1,4]
%     rootPath="../dataset/test/";
%     rootPath=append(rootPath,num2str(i));
%     rootPath=append(rootPath,"/");
%     myFiles = dir(fullfile(rootPath,'*.jpg'));
% 
%     predictions=[];
%     truth=[];
%     for k = 1:length(myFiles)
%         fileName = myFiles(k).name;
%         fileName = append(rootPath, fileName);
%         [meanR,meanG,meanB] =computeMeanChannels(fileName);
% 
%         FISMAT=readfis('FIS_sugeno_gaussmf.fis');
%         prediction = evalfis(FISMAT,[meanR,meanG,meanB]);
%         
%         predictions=[predictions prediction*6+1];
%         truth=[truth i];
%     end
%     hold on;
%     scatter(1:length(myFiles),predictions,15);
% end
% legend("Class 1","Class 4");
% 
% disp(MSE(predictions,truth));

%mostrar threshold effect--------------------------------------------------
img=imread("../dataset/train/4/Muestra109_2.jpg");
[BW,maskedRGBImage] = createMask(img);

%imshow(img);
imshow(maskedRGBImage);

