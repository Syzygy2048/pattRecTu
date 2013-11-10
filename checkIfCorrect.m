function [correct] = checkIfCorrect(nearestNeighbours, reference)

s = size(nearestNeighbours);
nn = cell(s(1), 1);

for i=1:s(1)
    nn{i, 1} = nearestNeighbours{i, 1};
end

[uniqueClasses, d, indx] = unique(nn); 
counts = accumarray(indx(:),1,[],@sum);

cmp = strcmp(uniqueClasses, reference);
s=size(cmp);

ind = 0;
for i=1:s
   if cmp(i) == 1
       ind = i;
   end
end

if ind == 0
    correct = false;
else 

if counts(ind) == max(counts)
   correct = true;
else
    correct = false;
end
end

end