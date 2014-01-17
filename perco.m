%{
Perceptron
%}

function [weight] = perco(X,t, maxEpcohes)
	weight = zeros(2,1);
	bias = 0;
	learnFactor = 0.1;
	correct = zeros(size(X,1),1);
	
    epcohes = 0;
	while ~all(correct(:)) | epcohes > maxEpcohes	
        epcohes = epcohes + 1;
		for i = 1:size(X,1)
			if(correct(i) ~= 1)
				if (weight(1) * X(i,1) + weight(2) * X(i,2) + bias) * t(i) > 0
					correct(i) = 1;
				else
					disp(i);
					weight = transpose(weight) + learnFactor * X(i,:) * t(i);
				end
			end	
		end
	end
end