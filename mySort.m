function [out] = mySort(in)

s = size(in);
values = zeros(s(1));

for i=1:s(1)
    values(i) = in{i, 2};
end

cmp = inline('sign(m(x)-m(y))', 'm', 'x', 'y');

order = quicksort(values, cmp);

out = cell(s);
for i=1:s(1)
    out{i, 1} =    in{order(i), 1};
    out{i, 2} =    in{order(i), 2};
end
end