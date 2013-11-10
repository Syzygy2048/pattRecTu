function [class, error] = kNN(vectors, k)

nearestNeighbours = cell(k, 2);

for i=1:k
   nearestNeighbours{i, 1} = '';
   nearestNeighbours{i, 2} = 100000000; 
end

testCandidate = vectors{1}

s = size(vectors)
for i = 2:s(1)
    NNcandidate = vectors{i};
    dist = euclideanDistanceForKNN(testCandidate, NNcandidate);
    cand = {NNcandidate{1}, dist};
    nearestNeighbours = checkIfNearestNeighbour(nearestNeighbours, cand);
end

nearestNeighbours

end