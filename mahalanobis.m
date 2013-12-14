%{
	from: http://www.mathworks.de/de/help/stats/mahal.html
	d = mahal(Y,X) computes the Mahalanobis distance (in squared units) of each observation in Y from the reference sample in matrix X.
	If Y is n-by-m, where n is the number of observations and m is the dimension of the data, d is n-by-1. X and Y must have the same
	number of columns, but can have different numbers of rows. X must have more rows than columns.
	For observation I, the Mahalanobis distance is defined by d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)', where mu and SIGMA are the
	sample mean and covariance of the data in X. mahal performs an equivalent, but more efficient, computation.
%}

function [error] = mahalanobis(trainA, trainB, trainC, test)
	meanA = mean(trainA(:,2:end));
	meanB = mean(trainB(:,2:end));
	meanC = mean(trainC(:,2:end));
	meanA
	meanB
	meanC
	

	
	
	
	
	
	

	
end