%{
Perceptron
%}

function [weight] = perco(X,t, maxEpoches)
	X = [ones(size(X,1),1), X];			%homogenize
	weight = zeros(size(X,2),1);		%bias (weight(1)) and weight is zero at the start
	learnFactor = 0.5;
	correct = zeros(size(X,1),1);
	
    epoches = 0;
	while ~all(correct(:)) && epoches < maxEpoches	
		epoches = epoches + 1;
		for i = 1:size(X,1)
			if (dot(weight, X(i,:))) * t(i) > 0
				correct(i) = 1;
				%weight = weight + transpose(learnFactor * X(i,:));
			else
				correct(i) = 0;
				weight = weight + transpose(learnFactor * X(i,:) * t(i));
			end
		end
	end
	fprintf(1,'%d of %d samples correctly classified\n', sum(correct), size(X,1));
	%fprintf(1,'w_x = %d, w_y = %d\n', weight(1), weight(2));  
	%fprintf(1,'w_x = %d, w_y = %d, bias = %d\n', weight(1), weight(2), bias);  
end