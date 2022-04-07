function checkInitPosGen(n, bounds, rounding)
%CHECKINITPOSGEN plot randomly generated initial positions and look for
%proper r.v. distribution

results = zeros(length(bounds), n);

for i = 1:n
    results(:,i) = MultiAgentSim.squareInitPos(bounds, rounding);
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