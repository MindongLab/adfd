function [  ] = processOneImage( file, outputDir, outputPrefix )


a = blurImg(file);
seperator = getSeperators(a);

I = 255*uint8(imread(file));

[height,width]=size(I);

blocks = getBlocks(a,seperator,I);
for i =1:size(blocks,1)
    startY = blocks(i,1)-6;
    endY = blocks(i,2)+6;
    thisRegion = I(startY:endY, :);
    outputFile = strcat(outputDir,outputPrefix,'_line_',int2str(i),'.png');
    imwrite(thisRegion,outputFile);
end

%for i=1:numel(seperator)
%line([1,width],[seperator(i),seperator(i)]);
%end
%for i = 0.05:0.025:0.95
%    line([1,width],[i*height,i*height]);
%end

end

