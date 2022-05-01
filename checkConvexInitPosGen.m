function checkConvexInitPosGen(n, bounds, rounding)
%CHECKCONVEXINITPOSGEN plot randomly generated initial positions and look for
%proper r.v. distribution

addpath('../')

results = zeros(size(bounds,1), n);

for i = 1:n
    results(:,i) = MultiAgentSim.convexPolyInitPos(bounds, rounding);
end

figure()
subplot(2,2,1)
histogram(results(1,:), 100);
title('Hist of x values')

subplot(2,2,2)
histogram(results(2,:), 100);
title('Hist of y values')

subplot(2,2,[3 4])
scatter(results(1,:), results(2,:));
axis equal
title('Plotted initial positions')

end % end checkInitPosGen