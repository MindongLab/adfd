I = imread('segments_eng/page_0030_line_25.png');

iblur = imgaussfilt(I,1.5);
ibright = imsharpen(iblur,'Radius', 2, 'Amount',20);
imshow(ibright);
ocr(ibright,'TextLayout','Block','Language','English','CharacterSet','ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,;()- ')