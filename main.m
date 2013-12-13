%{we need to read the data from the wine.data file and need to prepare it for evaluation:
 the data is found in the following format:
	1,14.23,1.71,2.43,15.6,127,2.8,3.06,.28,2.29,5.64,1.04,3.92,1065
%} the first value is the the class, rest is values.

%data is read into a matrix, each row is a data set, each column is a specific attribute, first column is class
M = csvread('wine.data');

%normalizing all values
for i = 2:size(M,2)
	M(:,i) = M(:,i)/norm(M(:,i));
end


mahalanobis(M);


