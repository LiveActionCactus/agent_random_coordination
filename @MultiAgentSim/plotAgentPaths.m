function plotAgentPaths(obj, sim_itr)
% PLOTAGENTPATHS plot the paths on a single figure

    % Triangle is beginning of path
    % Square is end of path
    figure()
    hold on
    for i = 1:obj.numAgents
        h = plot( obj.agents{(sim_itr+1),i}(2,:), obj.agents{(sim_itr+1),i}(3,:), '-*', 'MarkerSize', 3 );
        plot (obj.agents{(sim_itr+1),i}(2,1), obj.agents{(sim_itr+1),i}(3,1), '-^', 'Color', h.Color, 'MarkerFaceColor', h.Color )
        plot( obj.agents{(sim_itr+1),i}(2,end), obj.agents{(sim_itr+1),i}(3,end), '-s', 'Color', h.Color, 'MarkerFaceColor', h.Color )
    end

    axis([0, obj.boundary(1,2), 0, obj.boundary(2,2)])

end % end plotAgentPaths