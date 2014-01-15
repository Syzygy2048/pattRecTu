function discriminant()
A = [2 2 2 3; 2 1 3 1]';
A = [A, ones(4,1)];
B = [5 6 4; 2 3 4]';
B = [B, ones(3,1).*2];
C = [A; B];
M = [mean(A)];
C = [C; M];
M = [mean(B)];
C = [C; M];

sc = gscatter(C(:,1),C(:,2),C(:,3),'br','xo',[],'off');
set(sc,'LineWidth',2);

[X,Y] = meshgrid(linspace(0,10),linspace(0,10));
X = X(:); Y = Y(:);
[D,err,P,logp,coeff] = classify([X Y],[C(:,1),C(:,2)],C(:,3),'quadratic');

hold on;

gscatter(X,Y,D,'br','.',1,'off');
K = coeff(1,2).const;
L = coeff(1,2).linear;
Q = coeff(1,2).quadratic;

f = @(x,y) K + [x y]*L + sum(([x y]*Q) .* [x y], 2);

ez = ezplot(f,[0,10,0,10]);
set(ez,'Color','m','LineWidth',2)
axis([0 10, 0, 10])
xlabel('x')
ylabel('y')
title('{\bf Discriminant Functions for the Normal Density}');

hold off;

mu1 = [5, 6, 5];
mu2 = [0, 1, 1];
sigma = eye(3,3);
r1 = mvnrnd(mu1, sigma, 15)
r2 = mvnrnd(mu2, sigma, 15);

end