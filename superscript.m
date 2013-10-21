function [] = superscript(class)

dirname = 'MPEG7_CE-Shape-1_Part_B';
D = dir(dirname);
I = cell(20, 1);
STATS = cell(20, 1);
j = 1;
for i = 1 : size(D, 1)
    if D(i).isdir == 0 && strncmp(D(i).name(1:numel(class)), class, numel(class))
        disp(D(i).name);
        I_temp = imread(strcat(dirname, '/', [D(i).name]));
        I{j} = im2bw(I_temp, graythresh(I_temp));
        STATS{j} = regionprops(I{j}, 'all');
        j = j+1;
    end
end

STATS{3}