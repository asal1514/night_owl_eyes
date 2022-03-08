function Number=final_gui(I1,fig)
clc
% close all
% clear all
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
% I1=imread('6.jpg');
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
I2=rgb2gray(I1);
I3=I1(:,:,1);
I4=I1(:,:,2);
I5=I1(:,:,3);
if fig==1
    figure(2),imshow(I5);
    title('Gray level image')
end
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
I22 = imadjust(I5);
if fig==1
figure(3),imshow(I22);
title('image adjusted')
end
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
BWs = edge(I22, 'sobel', (graythresh(I22) * .1));
if fig==1
figure(4), imshow(BWs), title('binary gradient mask')
end
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);

% se0 = strel('disk', 3);
%  BWsdil = imdilate(BWs, se0 );
if fig==1
figure(5), imshow(BWsdil), title('dilated gradient mask')
end
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
BWdfill = imfill(BWsdil, 'holes');
if fig==1
figure(6), imshow(BWdfill);
title('binary image with filled holes')
end
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
se = strel('disk',3);

ff3 = imclose(~BWdfill,se);
if fig==1
figure(9),imshow(ff3)
end

%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 se1 = strel('line',6,90);
 ff4 = ~imerode(~ff3,se1);
if  fig==1
 figure(10),imshow(ff4)
 end

%%
% %%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
ff5 = ~bwareaopen(~ff4,200,4);
if fig==1
figure(12),imshow(ff5)
end
% %%
% %%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
ff7=bwlabel(~ff5);
if fig==1
figure(14),imshow(ff7)
end
Number=max(ff7(:));
if (Number>1)
  fprintf('Number of objects in the image are: %d\n',Number);
else
   fprintf('Number of object in the image is: %d\n',Number);
end;

%%
%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
if fig==1
figure(1),imshow(I1);
title('Main Image')
end
%%