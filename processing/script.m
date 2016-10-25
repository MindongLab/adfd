
clear
clc
close all
a = blurImg('images/image-1432.png');

step = 5;
[height, width] =size(a);
tt = [];
for i = 1:height-step+1
    tt = [tt averageDarkness( a(i:i+step-1, round(0.1*width):round(0.9*width))) ];
end

seperator = [];
for i = 50:2300
   
    if (tt(i)<=tt(i-1) && tt(i)<=tt(i+1) )%&& 0.009<tt(i)&& tt(i)<0.06)
        seperator = [seperator i];
    end
end
I = 255*uint8(imread('images/image-1432.png'));
imshow(I);
hold on;
for i =1:numel(seperator)
    line([1,width],[seperator(i),seperator(i)]);

end

%plot(tt)