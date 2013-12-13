function [distance] = euclideanDistanceForKNN(vector1, vector2)

s = size(vector1);

v1 = [vector1{2:s(1)}];
v2 = [vector2{2:s(1)}];

distance = norm(v1 - v2);

end