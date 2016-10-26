function [ seperator ] = getSeperators( blured_image )
    seperator = [];
    stepLeft = 5;
    stepRight = 4;
    a=blured_image;
    [height, width] =size(a);
    tt = [];
    for i = 1+stepLeft:height-stepRight
        tt = [tt averageDarkness( a(i-stepLeft:i+stepRight, round(0.1*width):round(0.9*width))) ];
    end

    % find the first 0.9
    firstLine = round(0.05*height);
    for i=firstLine:round(0.3*height)
        if tt(i)>0.9
            firstLine=i;
            break;
        end
    end

    seperator = [];
    for i = firstLine:round(0.95*height)

        if (tt(i)<=tt(i-1) && tt(i)<=tt(i+1) )%&& 0.009<tt(i)&& tt(i)<0.06)
            if (numel(seperator)>0 && i-seperator(numel(seperator))<=5) 
                % avoid consective seperators
                continue;
            end
            seperator = [seperator i];
        end
    end


end

