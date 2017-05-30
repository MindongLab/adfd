function SplitEnglish
   imgs  = dir('segments');
   for i=3:size(imgs)
       splitOne(strcat('segments/',imgs(i).name), ...
                strcat('segments_eng/',imgs(i).name));
   end
end

function splitOne(inputFile, outputFile)
    a = imread(inputFile);%'segments/page_1748_line_35.png');
    [h,w] = size(a);
    imwrite(a(:,round(0.48*w):w),outputFile);
end