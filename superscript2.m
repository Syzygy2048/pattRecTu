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
function [] = superscript2()

dirname = 'MPEG7_CE-Shape-1_Part_B';
classes = {'bat', 'beetle', 'cup', 'device9', 'pencil'};
D = dir(dirname);
I = cell(20, 1);
L = cell(20, 1);
FeatureVectors = cell(100, 1);

t = 1;
for h = 1 : numel(classes)
    j = 1;
    for i = 1 : size(D, 1)
        if D(i).isdir == 0 && strncmp(D(i).name(1:numel(classes{h})), classes{h}, numel(classes{h}))
            disp(D(i).name);
            I_temp = imread(strcat(dirname, '/', [D(i).name]));
            I{j} = im2bw(I_temp, graythresh(I_temp));
            L{j} = bwlabel(I{j}, 8);
            STATS = regionprops(L{j}, 'all');
            FeatureVector = cell(5, 1);
            FeatureVector{1} = classes{h};
            FeatureVector{2} = roundness(STATS(1).Area, STATS(1).Perimeter);
            Size = size(STATS(1).ConvexHull);
            FeatureVector{3} = Size(1);
            FeatureVector{4} = STATS(1).Solidity;
            FeatureVector{5} = STATS(1).Eccentricity;
            FeatureVectors{t} = FeatureVector;
            j = j+1;
            t = t+1;
        end
    end
end

errors = zeros(20,1);
for i=1:20
    errors(i) = kNN(FeatureVectors, i);
end

plot(errors);
errors

end
