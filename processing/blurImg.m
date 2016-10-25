
function output = blurImg(filename)
%figure
%subplot(1,3,1)

% Convert from BW image to 256-gray
I = 255*uint8(imread(filename));
%imshow(I);

iblur = imgaussfilt(I,8);
%subplot(1,3,2)
%imshow(iblur);

ibright = imsharpen(iblur,'Radius', 10, 'Amount',50);
%subplot(1,3,3);
%imshow(ibright);
output = ibright;
end

