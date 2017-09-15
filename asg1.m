clear all; close all; clc;

%% Author: Andrew Petersen
%  Course: CEC 495
%  Date modifoed: 9/14/17
%  Submit to: http: bit.ly/cec495a

%% To locate centroid %%
% Istats(maxIndex).BoundingBox;
% 
% hold on;
% rectangle('Position', [Istats(maxIndex).BoundingBox],...
%     'LineWidth',2, 'EdgeColor','g');
% 
% hold on;
% plot(Istats(maxIndex).Centroid(1), Istats(maxIndex).Centroid(2),'r*');
% text(Istats(maxIndex).Centroid(1)+10, Istats(maxIndex).Centroid(2)+10,...
%     'Object', 'fontsize',20,'color','r','fontweight','bold');


StartingFrame = 1;
EndingFrame = 448;

Xcentroid = [];
Ycentroid = [];

for k = StartingFrame : EndingFrame-1
    rgb1 = imread(['ant/img',sprintf('%2.3d',k),'.jpg']);
    rgb2 = imread(['ant/img',sprintf('%2.3d',k+1),'.jpg']);
    diff1 = abs(rgb1-rgb2);
    hsv = rgb2hsv(diff1);
    I = hsv(:, :, 3);
    Ithresh = I > .08;
    [labels, number] = bwlabel(Ithresh,8);            
    if number > 0
        Istats = regionprops(labels,'basic','Centriod');
        [values,index] = sort([Istats.Area],'descend');
        [maxVal, maxIndex] = max([Istats.Area]);
        Istats(maxIndex).Centroid;
        Istats(maxIndex).Centroid(1);
        Istats(maxIndex).Centroid(2);
        Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
        Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
    end
end

imshow(rgb2);
hold on
plot(Xcentroid,Ycentroid,'-');