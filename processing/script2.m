clear
clc
close all

for i=1500:1500
    fprintf(2, '[2]Image %d\n', i);
    processOneImage(strcat('images/image-',int2str(i),'.png'),'segments/',strcat('page_',int2str(i)));
end