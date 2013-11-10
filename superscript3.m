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
FeatureVectors = cell(20, 1);

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
            FeatureVector = cell(6, 1);
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

for i=1 : size(FeatureVectors)
    if FeatureVectors{i}{4} < 0.75 
		if FeatureVectors{i}{2} > 0.012
			FeatureVectors{i}{6} = 'bat';
		else if FeatureVectors{i}{5} < 0.88
			FeatureVectors{i}{6} = 'beetle';
		else
			FeatureVectors{i}{6} = 'bat';
		end		
	else if FeatureVectors{i}{5} > 0.96
		FeatureVectors{i}{6} = 'pencil';
	else if FeatureVectors{i}{5} < 0.46 and FeatureVectors{i}{3} > 300
		FeatureVectors{i}{6} = 'device9';
	else
		FeatureVectors{i}{6} = 'cup';
	end
end

correct = 0;
for i = 1 : size(FeatureVectors)
	if FeatureVectors{i}{1} = FeatureVectors{i}{6}
		correct = correct + 1;
	else
		disp(i + ' ' + FeatureVectors{i}{1} + ' is classified as ' + FeatureVectors{i}{6});
	end
end
disp('correct = ' + correct/size(FeatureVectors));
