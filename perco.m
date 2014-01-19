%{
Perceptron
X = datavectors, t = target, maxEpoches = max iterations
%}

function [weight] = perco(trainingSet,trainingClasses, testSet, testClasses, maxEpoches)
    X = trainingSet;
    t = trainingClasses;
	X = [ones(size(X,1),1), X];			%homogenize
	weight = zeros(size(X,2),1);			%bias is weight(1)
	learnFactor = 0.1;
	correct = zeros(size(X,1),1);
	
    epoches = 0;
	while ~all(correct(:)) && epoches < maxEpoches	
		epoches = epoches + 1;
		for i = 1:size(X,1)
			if (dot(weight, X(i,:))) * t(i) > 0
				correct(i) = 1;
			else
				correct(i) = 0;
				weight = weight + transpose(learnFactor * X(i,:) * t(i));
			end
		end
		
    end
    
    testCorrect = 0;
    for i=1:size(testSet,1)
        	if (dot(weight, X(i,:))) * t(i) > 0
				testCorrect = testCorrect + 1;
            end
    end
	
    'asdasd'
    testCorrect/size(X,1)
	
	fprintf(1,'%d of %d samples correctly classified\n', sum(correct), size(X,1));
	figure
	scatter(X(:,2),X(:,3),50,t,'fill');
	hold on;
	
	%startpos = (0,0) + norm(vector) * offset; endpos = (0,0) + normal * length + norm(vector) * offset
	%disp(weight(2:end));
	%disp(norm(weight(2:end)));
	%disp(weight(2:end)/norm(weight(2:end)));
	%disp(weight(2:end)/norm(weight(2:end)) * -weight(1));
	sigm = atand(weight(2)/weight(3));
    
    x=[0,1];
    y = (-weight(1) - weight(2)*x)/weight(3);
    plot(x,y);
    
	%line([x1 x2], [y1 y2]);	
	%plot(p1, [x2 y2]);
	hold off;
end