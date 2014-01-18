function [] = kNN(testData, trainingData, testClasses, trainingClasses, k)


% create test set cells

testSize = size(testData);

testSet = cell(testSize(1),1);

for i=1:testSize(1)
   c = cell(testSize(2)+1,1);
   c{1} = int2str(testClasses(i));
   for j=2:testSize(2)+1
      c{j} = testData(i, j-1); 
   end
   testSet{i} = c;
end

% create traing set

trainingSize = size(trainingData);
trainingSet = cell(trainingSize(1),1);

for i=1:trainingSize(1)
   c = cell(trainingSize(2)+1,1);
   c{1} = int2str(trainingClasses(i));
   for j=2:trainingSize(2)+1
      c{j} = trainingData(i, j-1); 
   end
   trainingSet{i} = c;
end

nearestNeighbours = cell(k, 2);

testSize = size(testSet);
traingSize = size(trainingSet);
correct = 0;

for i = 1:testSize(1)
    testCandidate = testSet{i};
    for j=1:k
        nearestNeighbours{j, 1} = '';
        nearestNeighbours{j, 2} = 100000000; 
    end
    for j=1:traingSize(1)
        NNcandidate = trainingSet{j};
        dist = euclideanDistanceForKNN(testCandidate, NNcandidate);
        cand = {NNcandidate{1}, dist};
        nearestNeighbours = checkIfNearestNeighbour(nearestNeighbours, cand);
    end
    correct = correct + checkIfCorrect(nearestNeighbours, testCandidate{1});
end

'total'
k

s = size(testSet);

correct/s(1)

error = 1-(correct/s(1));

end