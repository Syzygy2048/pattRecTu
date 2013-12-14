%{
Dieses Skript l�dt alle Bilder einer Klasse aus der MPEG7 Bilder Datenbank 
ein und wertet die Eigenschaften der Bilder mittels regionprops aus.
Das Skript kann z.B. �ber "superscript('bat')" aufgerufen werden.
Wir haben uns f�r folgende Objektklassen entschieden:
bat
beetle
cup
device 9
pencil
%}
function [] = superscript()

dirname = 'MPEG7_CE-Shape-1_Part_B';
classes = {'bat', 'beetle', 'cup', 'device9', 'pencil'};
D = dir(dirname);
I = cell(20, 1);
L = cell(20, 1);
Roundness = zeros(20, 20);
ConvexHull = zeros(20, 20);
Solidity = zeros(20, 20);
Eccentricity = zeros(20, 20);
for h = 1 : numel(classes)
    j = 1;
    for i = 1 : size(D, 1)
        if D(i).isdir == 0 && strncmp(D(i).name(1:numel(classes{h})), classes{h}, numel(classes{h}))
            disp(D(i).name);
            I_temp = imread(strcat(dirname, '/', [D(i).name]));
            I{j} = im2bw(I_temp, graythresh(I_temp));
            L{j} = bwlabel(I{j}, 8);
            STATS = regionprops(L{j}, 'all');
            Roundness(j, h) = roundness(STATS(1).Area, STATS(1).Perimeter);
            Size = size(STATS(1).ConvexHull);
            ConvexHull(j, h) = Size(1);
            Solidity(j, h) = STATS(1).Solidity;
            Eccentricity(j, h) = STATS(1).Eccentricity;
            j = j+1;
        end
    end
end

t = 1;
for i = 1:5
    for j = 1:20
        C(t) = i;
        C(t) = i;
        C(t) = i;
        t = t + 1;
    end
end

t=1;
RoundnessValueVector = zeros(100, 1);
for i = 1:5
    for j = 1:20
        RoundnessValueVector(t) = Roundness(j, i);
        t = t + 1;
    end
end

t=1;
ConvexHullValueVector = zeros(100, 1);
for i = 1:5
    for j = 1:20
        ConvexHullValueVector(t) = ConvexHull(j, i);
        t = t + 1;
    end
end

t=1;
SolidityValueVector = zeros(100, 1);
for i = 1:5
    for j = 1:20
        SolidityValueVector(t) = Solidity(j, i);
        t = t + 1;
    end
end

t=1;
EccentricityValueVector = zeros(100, 1);
for i = 1:5
    for j = 1:20
        EccentricityValueVector(t) = Eccentricity(j, i);
        t = t + 1;
    end
end

figure(1);
scatter(C, RoundnessValueVector);
figure(2);
scatter(C, ConvexHullValueVector);
figure(3);
scatter(C, SolidityValueVector);
figure(4);
scatter(C, EccentricityValueVector);