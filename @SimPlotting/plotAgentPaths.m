function plotAgentPaths(obj, num_plots, labels)
%PLOTAGENTPATHS plots specified number of figures, each representing a
%different run of the simulation and the paths the agents followed.
%
% --Inputs--
% obj :         SimPlotting object which has a pointer to SimEnv object
% num_plots :   number/samples of agent path plots to generate
% labels : 1 -- label figures; 0 -- or don't
%
% --Outputs--
% figure(s) : produces a new figure for each sample of stored agent paths
%

    plot_itrs = (obj.sim_env.sim_itrs / num_plots) .* [1:num_plots];
    col = lines(obj.sim_env.numAgents);
    
    % Triangle is beginning of path
    % Square is end of path
    for k = 1:num_plots
        j = plot_itrs(1,k);
        data = obj.sim_env.sim_itrs_data.state;          % stored agents' state info (num_agents x sim_itr) cell array

        figure()
        hold on

        for i = 1:obj.sim_env.numAgents
            h = plot( data{i,j}(2,:), data{i,j}(3,:), '-*', 'MarkerSize', 3, 'Color', col(i,:) );
            plot( data{i,j}(2,1), data{i,j}(3,1), '-^', 'Color', h.Color, 'MarkerFaceColor', h.Color )
            plot( data{i,j}(2,end), data{i,j}(3,end), '-s', 'Color', h.Color, 'MarkerFaceColor', h.Color )
        end

        if isequal(labels, 1)
            title("Agent trajectories -- Sim itr: " + plot_itrs(1,k) + " Sim steps: " + obj.sim_env.N)
        end
    end

    axis([0, obj.sim_env.boundary(1,2), 0, obj.sim_env.boundary(2,2)])

end