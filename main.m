%{
	we need to read the data from the wine.data file and need to prepare it for evaluation:
	the data is found in the following format:
	1,14.23,1.71,2.43,15.6,127,2.8,3.06,.28,2.29,5.64,1.04,3.92,1065
	the first value is the the class, rest is values.
%} 

%data is read into a matrix, each row is a data set, each column is a specific attribute, first column is class
M = csvread('wine.data');

%normalizing all values
for i = 2:size(M,2)
	M(:,i) = M(:,i)/norm(M(:,i));
end

%splitting the values into a test and trainings set for mahalanobis
% The dataset consists of 178 instances, such that the class 1 has 59 samples; class 2 has 71 samples; and class 3 has 48 samples. 
trainA = [];
trainB = [];
trainC = [];
test = [];
for i = 1:size(M,1)
	if(i<30)
		trainA = [trainA; M(i,:)];
    elseif(i < 60)
		test = [test; M(i,:)];
    elseif(i < 95)
		trainB = [trainB; M(i,:)];
    elseif(i < 131)
		test = [test; M(i,:)];
    elseif(i < 155)
		trainC = [trainC; M(i,:)];
	else
		test = [test; M(i,:)];
	end
end

mahalanobis(trainA, trainB, trainC, test);
