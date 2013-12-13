function [] = kNN_Evaluation(k)

wineData = csvread('dataset/wine.data');

numberOfNearestNeighbours = 9;
k = numberOfNearestNeighbours;

% normalize data
for i=2:14
    maximum = max(wineData(:,i));
    wineData(:,i) = wineData(:,i)/maximum;
end

% create test set cells

testSet = cell(30,1);

for i=1:10
   c = cell(14,1);
   c{1} = '1';
   for j=2:14
      c{j} = wineData(i, j); 
   end
   testSet{i} = c;
end
for i=11:20
   c = cell(14,1);
   c{1} = '2';
   for j=2:14
      c{j} = wineData(i-10+59, j); 
   end
   testSet{i} = c;
end
for i=21:30
   c = cell(14,1);
   c{1} = '3';
   testSet{i} = c;
   for j=2:14
      c{j} = wineData(i-20+130, j); 
   end
   testSet{i} = c;
end

% create training set cells

trainingSet = cell(59+71+48-30, 1);

for i=11:59
   c = cell(14,1);
   c{1} = '1';
   for j=2:14
      c{j} = wineData(i, j); 
   end
   trainingSet{i-10} = c;
end
for i=11:71
    c = cell(14,1);
    c{1} = '2';
   for j=2:14
      c{j} = wineData(i+59, j); 
   end
   trainingSet{i+59-20} = c;
end
for i=11:48
   c = cell(14,1);
   c{1} = '3';
   for j=2:14
      c{j} = wineData(i+130, j); 
   end
   trainingSet{i+130-30} = c;
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