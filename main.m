%{

simpleData = [0 0; 0 1; 1 0; 1 1];
and = [-1; -1; -1; 1];
or = [-1; 1; 1; 1];
xor = [-1; 1; 1; -1];

disp(transpose(perco(simpleData, and, 50)));
disp(transpose(perco(simpleData, or, 50)));
disp(transpose(perco(simpleData, xor, 50)));


data = load('data/perceptrondata.dat');
learndata1 = load('data/perceptrontarget1.dat'); 
learndata2 = load('data/perceptrontarget2.dat');

for i = 1:size(learndata1,1)
	if ~learndata1(i)
		learndata1(i) = -1;
	end
	if ~learndata2(i)
		learndata2(i) = -1;
	end
end

disp(transpose(perco(data, learndata1, 9)));
disp(transpose(perco(data, learndata2, 3)));

%}
load('data/strokefeatures.mat');
data = features_class(:, 1:20);

% wir wollen gerade anzahl damit wir jeden 2. in test und trainingsset
% stecken können
s = size(data);
data = data(1:s(1)-1,:);
s = size(data);

classes = features_class(:, 21);

classes = classes(1:s(1),:);

% normalize data
for i=1:s(2)
    maximum = max(data(:,i));
    data(:,i) = data(:,i)/maximum;
end

% create test set cells

testSet = zeros(s(1)/2,s(2));
testClasses = zeros(s(1)/2,1);

for i=1:s(1)/2
   for j=1:s(2)
      testSet(i,j) = data(i*2, j);
   end
   testClasses(i) = classes(i*2);   
end

% create traing set

trainingSet = zeros(s(1)/2,s(2));
trainingClasses = zeros(s(1)/2,1);

for i=1:s(1)/2
   for j=1:s(2)
      trainingSet(i,j) = data(i*2-1, j); 
   end
   trainingClasses(i) = classes(i*2-1);   
end

%kNN(testSet, trainingSet, testClasses, trainingClasses, 3);

percoTestClasses = testClasses;
percoTrainingClasses = trainingClasses;

for i=1:s(1)/2
      if percoTestClasses(i) <= 3
         percoTestClasses(i) = -1;
      else
         percoTestClasses(i) = 1; 
      end
      if percoTrainingClasses(i) <= 3
         percoTrainingClasses(i) = -1;
      else
         percoTrainingClasses(i) = 1; 
      end
end

mahalanobis(testSet, trainingSet, testClasses, trainingClasses);
%perco(trainingSet, percoTrainingClasses, testSet, percoTestClasses, 1000);
%kNN(testSet, trainingSet, percoTrainingClasses, percoTrainingClasses, 3);

%}
