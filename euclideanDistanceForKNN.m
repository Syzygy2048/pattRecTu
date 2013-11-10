function [distance] = euclideanDistanceForKNN(vector1, vector2)

v1 = [vector1{2}, vector1{3}, vector1{4}, vector1{5}];
v2 = [vector2{2}, vector2{3}, vector2{4}, vector2{5}];

distance = norm(v1 - v2);

end