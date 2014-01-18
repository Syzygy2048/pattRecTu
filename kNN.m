function [] = kNN(data, classes, k)

s = size(data);
if mod(s(1),2) ~= 0
   data = data(1:s(1)-1,:);
   s = size(data);
end

% normalize data
for i=1:s(2)
    maximum = max(data(:,i));
    data(:,i) = data(:,i)/maximum;
end

% create test set cells

testSet = cell(s(1)/2,1);

for i=1:s(1)/2
   c = cell(s(2)+1,1);
   c{1} = int2str(classes(i*2));
   for j=2:s(2)+1
      c{j} = data(i, j-1); 
   end
   testSet{i} = c;
end

% create traing set

trainingSet = cell(s(1)/2,1);

for i=1:s(1)/2
   c = cell(s(2)+1,1);
   c{1} = int2str(classes(i*2-1));
   for j=2:s(2)+1
      c{j} = data(i, j-1); 
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