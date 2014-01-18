%{
Perceptron
%}

function [weight] = perco(X,t, maxEpoches)
	weight = zeros(2,1);
	bias = 0;
	learnFactor = 1;
	correct = zeros(size(X,1),1);
	
    epoches = 0;
	while ~all(correct(:)) && epoches < maxEpoches	
		epoches = epoches + 1;
		for i = 1:size(X,1)
			if (weight(1) * X(i,1) + weight(2) * X(i,2) + bias) * t(i) > 0
				correct(i) = 1;
			else
				correct(i) = 0;
				weight = weight + transpose(learnFactor * X(i,:) * t(i));
				%bias = bias + learnFactor * X(i,2) * t(i);	
			end
		end
	end
	fprintf(1,'%d of %d samples correctly classified\n', sum(correct), size(X,1));
	fprintf(1,'w_x = %d, w_y = %d\n', weight(1), weight(2));  
	%fprintf(1,'w_x = %d, w_y = %d, bias = %d\n', weight(1), weight(2), bias);  
end