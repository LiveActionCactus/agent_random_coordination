function checkHeadAngGen(n, rounding)
%CHECKHEADANGGEN check the generation of random angles based on agent
%location

% TODO: build in more general way, for any convex symmetric polygon

results = zeros(n, 2);

for i = 1:n
    testSim = MultiAgentSim(1);     % n agents
    [results(i, 1), results(i,2)] = testSim.agents{1,1}.genHeadingAngle(rounding);
end

sides = [0, 1, 2, 3];                   % numbered sides for convex polygon
s_count = hist(results(:,2), sides);    % count for each side from data set

% split results up by side
plot_res = {1,4};
plot_res{1,1} = zeros(1, s_count(1,1));
plot_res{1,2} = zeros(1, s_count(1,2));
plot_res{1,3} = zeros(1, s_count(1,3));
plot_res{1,4} = zeros(1, s_count(1,4));

% results(:,1) = round(rad2deg(results(:,1)));       % convert to degrees, round to single degree

idx = [1, 1, 1, 1];         % indices for each side
for i = 1:length(results)
    if results(i,2) == 0
        plot_res{1,1}(1, idx(1,1)) = results(i,1);
        idx(1,1) = idx(1,1) + 1;
    elseif results(i,2) == 1
        plot_res{1,2}(1, idx(1,2)) = results(i,1);
        idx(1,2) = idx(1,2) + 1;
    elseif results(i,2) == 2
        plot_res{1,3}(1, idx(1,3)) = results(i,1);
        idx(1,3) = idx(1,3) + 1;
    elseif results(i,2) == 3
        plot_res{1,4}(1, idx(1,4)) = results(i,1);
        idx(1,4) = idx(1,4) + 1;
    else
        disp(results(i,:))
        error('No valid side for given boundaries')
    end
end % end for loop

figure(10)
subplot(2,2,1)
histogram(plot_res{1,1}(1,:), 500);
title('Covex side 0')

subplot(2,2,2)
histogram(plot_res{1,2}, 500);
title('Convex side 1')
 
subplot(2,2,3)
histogram(plot_res{1,3}(1,:), 500);
title('Convex side 2')
 
subplot(2,2,4)
histogram(plot_res{1,4}, 500);
title('Convex side 3')

end % end checkHeadAngGen