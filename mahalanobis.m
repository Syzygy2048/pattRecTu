%{
	from: http://www.mathworks.de/de/help/stats/mahal.html
	d = mahal(Y,X) computes the Mahalanobis distance (in squared units) of each observation in Y from the reference sample in matrix X.
	If Y is n-by-m, where n is the number of observations and m is the dimension of the data, d is n-by-1. X and Y must have the same
	number of columns, but can have different numbers of rows. X must have more rows than columns.
	
%}
function [error] = mahalanobis(testData, trainingData, testClasses, trainingClasses)
    trainingClass1 = [];
    trainingClass2 = [];
    trainingClass3 = [];
    trainingClass4 = [];
    trainingClass5 = [];
    trainingClass6 = [];
    
    for i=1:size(trainingData, 1)
        if trainingClasses(i) == 1
            trainingClass1 = [trainingClass1; trainingData(i)];
        elseif trainingClasses(i) == 2
            trainingClass2 = [trainingClass2; trainingData(i)];
        elseif trainingClasses(i) == 3
            trainingClass3 = [trainingClass3; trainingData(i)];
        elseif trainingClasses(i) == 4
            trainingClass4 = [trainingClass4; trainingData(i)];
        elseif trainingClasses(i) == 5
            trainingClass5 = [trainingClass5; trainingData(i)];
        elseif trainingClasses(i) == 6
            trainingClass6 = [trainingClass6; trainingData(i)];
        end
    end
    
    
	mean1 = mean(trainingClass1(:,:)); %normally you should do mean(trainA(:,2:end)) to not average the class, but since the class is always the same, it doesn't matter
	mean2 = mean(trainingClass2(:,:)); %same
	mean3 = mean(trainingClass3(:,:)); %same
    mean4 = mean(trainingClass4(:,:)); %same
	mean5 = mean(trainingClass5(:,:)); %same
    mean6 = mean(trainingClass6(:,:)); %same
    
    

	%The covariance matrices are diagonal. To implement this, the off-diagonal elements of each matrix are simply set to zero.
	% --> so basically all we need is the variance of each of the 13 attributes
	var1 = zeros(1, 20);
	for i = 1:size(trainingClass1,1)
		var1 = var1 + (trainingClass1(i,:)-mean1).^2;
	end
	
	var2 = zeros(1, 20);
	for i = 1:size(trainingClass2,1)
		var2 = var2 + (trainingClass2(i,:)-mean2).^2;
	end
	
	var3 = zeros(1, 20);
	for i = 1:size(trainingClass3,1)
		var3 = var3 + (trainingClass3(i,:)-mean3).^2;
    end
    
    var4 = zeros(1, 20);
	for i = 1:size(trainingClass4,1)
		var4 = var4 + (trainingClass4(i,:)-mean4).^2;
    end
    
    var5 = zeros(1, 20);
	for i = 1:size(trainingClass5,1)
		var5 = var5 + (trainingClass5(i,:)-mean5).^2;
    end
    
    var6 = zeros(1, 20);
	for i = 1:size(trainingClass6,1)
		var6 = var6 + (trainingClass6(i,:)-mean6).^2;
	end
	
	%All classes have identical covariance matrices. To implement this, calculatethe sum in the equation for estimating the
	%covariance matrix for each class, add the sums for all the classes together and take n to b e the total numb er of 
	%elements in the training set
	cov = (var1(1:end) + var2(1:end) + var3(1:end) + var4(1:end) + var5(1:end) + var6(1:end)) / (size(trainingClass1,1) + size(trainingClass2,1) + size(trainingClass3,1) + size(trainingClass4,1) + size(trainingClass5,1) + size(trainingClass6,1));
	cov = diag(cov);
	
	%For observation I, the Mahalanobis distance is defined by d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)', where mu and SIGMA are the
	%sample mean and covariance of the data in X. (matlab)
	%If the covariance matrix is diagonal, then the resulting distance measure is called a normalized Euclidean distance. (wiki)
	correct = 0;
	for i = 1:size(testData,1)
		dist1 = (testData(i,:) - mean1(:)) * inv(cov) * (testData(i,:) - mean1(:))';
        dist2 = (testData(i,:) - mean2(:)) * inv(cov) * (testData(i,:) - mean2(:))';
        dist3 = (testData(i,:) - mean3(:)) * inv(cov) * (testData(i,:) - mean3(:))';
        dist4 = (testData(i,:) - mean4(:)) * inv(cov) * (testData(i,:) - mean4(:))';
        dist5 = (testData(i,:) - mean5(:)) * inv(cov) * (testData(i,:) - mean5(:))';
        dist6 = (testData(i,:) - mean6(:)) * inv(cov) * (testData(i,:) - mean6(:))';
        
        dists = [dist1 dist2 dist3 dist4 dist5 dist6];
		
		%check if classified correctly
		if dist1 == min(dists)
			if testClasses(i,1) == 1
				correct = correct + 1;
			end
		elseif dist2 == min(dists)
			if testClasses(i,1) == 2
				correct = correct + 1;
            end
        elseif dist3 == min(dists)
			if testClasses(i,1) == 3
				correct = correct + 1;
            end
        elseif dist4 == min(dists)
			if testClasses(i,1) == 4
				correct = correct + 1;
            end
        elseif dist5 == min(dists)
			if testClasses(i,1) == 5
				correct = correct + 1;
			end
		else
			if testClasses(i,1) == 6
				correct = correct + 1;
			end
		end			
	end
	
	fprintf(1,'%d of %d samples correctly classified', correct, size(testData,1));

	error = 1 - correct/size(testData,1);
end