%{this function calculates the mahalanobis distance
%}
function [error] = mahalanobis(M)

	correct = 0;

	covM = diag(cov(M(:,2:end))); %simplification possibly applied wrong | possibly not allowed, might need to implement this

	for i = 1:size(M,1)
		
		for j = 1:size(M,1)
			if j ~= i	%leave one out crossvalidation
		
			end
		end

	end

	error = 1 - correct/size(M,1);
end