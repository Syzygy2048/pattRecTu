%{
	from: http://www.mathworks.de/de/help/stats/mahal.html
	d = mahal(Y,X) computes the Mahalanobis distance (in squared units) of each observation in Y from the reference sample in matrix X.
	If Y is n-by-m, where n is the number of observations and m is the dimension of the data, d is n-by-1. X and Y must have the same
	number of columns, but can have different numbers of rows. X must have more rows than columns.
	
%}
function [error] = mahalanobis(trainA, trainB, trainC, test)
	meanA = mean(trainA(:,:)); %normally you should do mean(trainA(:,2:end)) to not average the class, but since the class is always the same, it doesn't matter
	meanB = mean(trainB(:,:)); %same
	meanC = mean(trainC(:,:)); %same

	%The covariance matrices are diagonal. To implement this, the off-diagonal elements of each matrix are simply set to zero.
	% --> so basically all we need is the variance of each of the 13 attributes
	varA = [0 0 0 0 0 0 0 0 0 0 0 0 0 0];
	for i = 1:size(trainA,1)
		varA = varA + (trainA(i,:)-meanA).^2;
	end
	
	varB = [0 0 0 0 0 0 0 0 0 0 0 0 0 0];
	for i = 1:size(trainB,1)
		varB = varB + (trainB(i,:)-meanB).^2;
	end
	
	varC = [0 0 0 0 0 0 0 0 0 0 0 0 0 0];
	for i = 1:size(trainC,1)
		varC = varC +(trainC(i,:)-meanC).^2;
	end
	
	%All classes have identical covariance matrices. To implement this, calculatethe sum in the equation for estimating the
	%covariance matrix for each class, add the sums for all the classes together and take n to b e the total numb er of 
	%elements in the training set
	cov = (varA(2:end) + varB(2:end) + varC(2:end)) / (size(trainA,1) + size(trainB,1) + size(trainC,1));
	cov = diag(cov);
	
	%For observation I, the Mahalanobis distance is defined by d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)', where mu and SIGMA are the
	%sample mean and covariance of the data in X. (matlab)
	%If the covariance matrix is diagonal, then the resulting distance measure is called a normalized Euclidean distance. (wiki)
	correct = 0;
	for i = 1:size(test,1)
		distA = (test(i,2:end) - meanA(2:end)) * inv(cov) * (test(i,2:end) - meanA(2:end))';
		distB = (test(i,2:end) - meanB(2:end)) * inv(cov) * (test(i,2:end) - meanB(2:end))';
		distC = (test(i,2:end) - meanC(2:end)) * inv(cov) * (test(i,2:end) - meanC(2:end))';
		
		%check if classified correctly
		if distA < distB && distA < distC
			if test(i,1) == 1
				correct = correct + 1;
			end
		elseif distB < distC
			if test(i,1) == 2
				correct = correct + 1;
			end
		else
			if test(i,1) == 3
				correct = correct + 1;
			end
		end			
	end
	
	fprintf(1,'%d of %d samples correctly classified', correct, size(test,1));

	error = 1 - correct/size(test,1);
end