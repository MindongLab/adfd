clear
clc
close all

for i=28:1768
    fprintf(2, 'Image %d\n', i);
    processOneImage(strcat('images/image-',int2str(i),'.png'),'segments/',strcat('page_',int2str(i)));
end