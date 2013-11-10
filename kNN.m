function [error] = kNN(vectors, k)

nearestNeighbours = cell(k, 2);

s = size(vectors);
correct = 0;

for i = 1:s(1)
    testCandidate = vectors{i};
    for j=1:k
        nearestNeighbours{j, 1} = '';
        nearestNeighbours{j, 2} = 100000000; 
    end
    for j=1:s(1)
        if j ~= i
            NNcandidate = vectors{j};
            dist = euclideanDistanceForKNN(testCandidate, NNcandidate);
            cand = {NNcandidate{1}, dist};
            nearestNeighbours = checkIfNearestNeighbour(nearestNeighbours, cand);
        end
    end
    correct = correct + checkIfCorrect(nearestNeighbours, testCandidate{1});
end

'total'
k
correct/s(1)

error = 1-(correct/s(1));

end