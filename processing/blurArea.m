
function output = blurArea(I)
%figure
%subplot(1,3,1)

iblur = imgaussfilt(I,8);
%subplot(1,3,2)
%imshow(iblur);

ibright = imsharpen(iblur,'Radius', 10, 'Amount',50);
%subplot(1,3,3);
%imshow(ibright);
output = ibright;
end

