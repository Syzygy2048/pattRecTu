function [nearestNeighbours] = checkIfNearestNeighbour(existingNearestNeighbours, candidate)

s = size(existingNearestNeighbours);

lastExisting = existingNearestNeighbours{s(1), 2};
if(candidate{2} < lastExisting)
    existingNearestNeighbours{s(1), 1} = candidate{1};
    existingNearestNeighbours{s(1), 2} = candidate{2};
    existingNearestNeighbours = mySort(existingNearestNeighbours);
end

nearestNeighbours = existingNearestNeighbours;

end