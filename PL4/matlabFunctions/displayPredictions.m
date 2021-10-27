function  displayPredictions(predictedLabels)
y=predictedLabels;
labels='1234567890';

[rows,columns]=size(predictedLabels);
if(rows ~=5 || columns~=10)
    disp("Predited labels matrix needs to be 5x10");
    return
end

figure(10); clf;

%--------------------------- plot the grid 5 x 10 
axis equal;
axis([0 1 0 0.5]);
hold on;
plot( [ 0 0 1 1 0 ], [ 0 .5 .5 0 0 ] );
for i = 1:9, plot( [i/10 i/10],[0 .5] ); end
for i = 1:4, plot( [0 1],[i/10 i/10] );  end

%--------------------------- display recognized numerals
for i=1:5,
    for j = 1:10,
        inx = j+(i-1)*10;
        if y(inx) ~= -1,
            character = labels(y(inx)); 
            
            h=text(0.05+(j-1)/10,-0.05+(5-i+1)/10,character);
            set(h,'fontsize',25,'VerticalAlignment','middle',...
                'HorizontalAlignment','center');
        end
    end
end

