function [ output ] = isAreaEmpty( blurred_area )
%ISAREAEMPTY Summary of this function goes here
%   Detailed explanation goes here
    [height, width]=size(blurred_area);
    step = 5;
    output =1;
    for i=round(width*0.1):min(width-step+1,round(width*0.9))
        if (averageDarkness(blurred_area(:,i:i+step-1)) > 0.3) 
            output= 0;
            break;
        end
    end

end

