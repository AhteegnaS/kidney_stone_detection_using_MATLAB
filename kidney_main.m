%Clear the command window
clc
%clear the variables used in the previous execution
clear all
%close all the open windows
close all
%turn off if any warnings
warning off
% acces the input image from the location
[filename,pathname]=uigetfile('*.*','Pick a MATLAB code file');
filename=strcat(pathname,filename);
%read the scanned image
a=imread(filename);
%a=imread('kidney2.jpg');
%Display the the input image
imshow(a);
title('Input scanned kidney image');
%convert the RGB image into gray for arithmatic operations
b=rgb2gray(a);
figure;
imshow(b);
title('RGB to Gray converted Image');
%pixel information to be showed on the figure window
impixelinfo;
c=b>20;
figure;
imshow(c);
title('Adjust the contrast of an image');
%performs a flood-fill operation on background pixels of the input binary image
d=imfill(c,'holes');
figure;
imshow(d);
title('flood-fill operation on background pixels');
%Remove small objects from binary image
e=bwareaopen(d,1000);
figure;
imshow(e);
title('Remove small objects from binary image');
%Preprocessing operation, Repeat copies of array
PreprocessedImage=uint8(double(a).*repmat(e,[1 1 3]));
figure;
imshow(PreprocessedImage);
%Adjust image intensity values or colormap
PreprocessedImage=imadjust(PreprocessedImage, [0.3 0.7], [])+50;
figure;
imshow(PreprocessedImage);
u0=rgb2gray(PreprocessedImage);
figure;
imshow(u0);
m0=medfilt2(u0,[9 9]);
figure;
imshow(m0);
p0=m0>250;
figure;
imshow(p0);
[r c m]=size(p0);
x1=r/8;
y1=c/3;
row=[x1   x1+300   x1+300   x1];
col=[y1   y1        y1+60    y1+60];
BW=roipoly(p0,row,col);
figure;
imshow(BW);
k=p0.*double(BW);
figure;
imshow(k);
M=bwareaopen(k,4);
[ya number]=bwlabel(M);
if(number>=1)
disp('Stone is detected');
else
disp('No stone is detected');
end
