function [ output ] = getBlocks( blurred_image, seperators , originalImage)
%GETBLOCKS Summary of this function goes here
%   INPUT

%  ---------------------
%  |BUC| CHIN| ENGLISH |
%  ---------------------

output = [];
[height, width] =size(blurred_image);
startBUC = round(0.1*width);
startCHIN  = round(0.34*width);
startENG = round(0.5*width);
endENG = round(0.95*width);


for i=2:numel(seperators)
    startY = seperators(i-1);
    endY = seperators(i);
    subRegions = { ...
              blurArea(originalImage(startY:endY, startBUC:startCHIN)) ...
              blurArea(originalImage(startY:endY, startCHIN:startENG)) ...
              blurArea(originalImage(startY:endY, startENG:endENG))};
    filledCells = 0;
    for i=1:3
        if (~isAreaEmpty(subRegions{i}))
            filledCells = filledCells +1;
        end
    end
    if filledCells ==0
        % ignore
    elseif filledCells == 3 
        % new Line
        output=[output; startY, endY];
    else
        %continue last line
        if (size(output,1)>0) 
            output(size(output,1),2) = endY;
        end
    end
end


end

