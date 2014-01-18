%{
%}


data = load('data/perceptrondata.dat');
learndata1 = load('data/perceptrontarget1.dat'); 
learndata2 = load('data/perceptrontarget2.dat');
for i = 1:size(learndata1,1)
	if ~learndata1(i)
		learndata1(i) = -1;
	end
	if ~learndata2(i)
		learndata2(i) = -1;
	end
end

perco(data, learndata1, 10000);
perco(data, learndata2, 10000);