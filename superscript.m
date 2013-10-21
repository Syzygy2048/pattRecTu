%{
Dieses Skript lädt alle Bilder einer Klasse aus der MPEG7 Bilder Datenbank 
ein und wertet die Eigenschaften der Bilder mittels regionprops aus.
Das Skript kann z.B. über "superscript('bat')" aufgerufen werden.
Wir haben uns für folgende Objektklassen entschieden:
bat
beetle
cup
device 9
pencil
%}
function [] = superscript(class)

dirname = 'MPEG7_CE-Shape-1_Part_B';
D = dir(dirname);
I = cell(20, 1);
L = cell(20, 1);
j = 1;
for i = 1 : size(D, 1)
    if D(i).isdir == 0 && strncmp(D(i).name(1:numel(class)), class, numel(class))
        disp(D(i).name);
        I_temp = imread(strcat(dirname, '/', [D(i).name]));
        I{j} = im2bw(I_temp, graythresh(I_temp));
        L{j} = bwlabel(I{j}, 8);
        STATS = regionprops(L{j}, 'all');
        s = size(STATS);
        STATS(1).Area
        if s(1) > 1
           STATS(2).Area
        end
        j = j+1;
    end
end
