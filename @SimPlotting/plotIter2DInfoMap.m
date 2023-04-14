function plotIter2DInfoMap(obj)
%PLOTITER2DINFOMAP plots each sim step of multi-agent simulation, shows the
%agent kinematics and the information map that each agent holds at each
%step

    % TODO: generalize for variable environment dimensions (right now
    % 10x10)

    num_agents = obj.sim_env.numAgents;
    sim_len = obj.sim_env.n;
    sim_data = obj.sim_env.sim_itrs_data;
    obs_metric = zeros(5, sim_len);             % store sum of lattice point values for each agent & shared state

    fig = figure();

    % agent trajectories
    ax1 = subplot(2, 4, [1 2 5 6], "Parent", fig);
    colormap(ax1, "default")
    axis([0 10 0 10])
    
    % TODO: generalize plotting to N agents

    % agent 1: 2-D information map
    ax2 = subplot(2, 4, 3, "Parent", fig);
    colormap(ax2, winter(100))
    title("Agent 1 Info Map")
    axis([1 11 1 11])

    % agent 2: 2-D information map
    ax3 = subplot(2,4, 4, "Parent", fig);
    colormap(ax3, winter(100))
    title("Agent 2 Info Map")
    axis([1 11 1 11])

    % agent 3: 2-D information map
    ax4 = subplot(2, 4, 7, "Parent", fig);
    colormap(ax4, winter(100))
    title("Agent 3 Info Map")
    axis([1 11 1 11])

    % agent 4: 2-D information map
    ax5 = subplot(2,4, 8, "Parent", fig);
    colormap(ax5, winter(100))
    title("Agent 4 Info Map")
    axis([1 11 1 11])
    set(gca,'YDir','reverse')           % matlab is plotting the y-axis flipped for some unknown reason; this flips it back

    hold on

    col = lines(num_agents);

    traj = {};
    for i = 1:num_agents
        traj{1,i} = animatedline('Color', col(i,:), 'Marker', '*', 'MarkerSize', 3, "DisplayName", string(i), 'Parent', ax1);
    end

    for j = 1:sim_len
        % plot agent trajectories
        axes(ax1)
        hold on
        for k = 1:4
            % TODO: animatedline handles keep deleting; need to hold open
            if isvalid(traj{1,i})
                addpoints(traj{1,k}, sim_data.state{k,1}(2,j), sim_data.state{k,1}(3,j))
                title("Agent trajectories -- Step: " + j)
    
                if isequal(j,1)
                    plot(sim_data.state{k,1}(2,1), sim_data.state{k,1}(3,1), '-^', 'Color', col(k,:), 'MarkerFaceColor', col(k,:), 'HandleVisibility','off', 'Parent', ax1)
    
                    label = string(k);
                    text(sim_data.state{k,1}(2,1), sim_data.state{k,1}(3,1), label)
                
                elseif isequal(j,sim_len)
                    plot(sim_data.state{k,1}(2,end), sim_data.state{k,1}(3,end), '-s', 'Color', col(k,:), 'MarkerFaceColor', col(k,:), 'HandleVisibility','off', 'Parent', ax1)
                
                end
                
                drawnow
            end
        end % end plot agent trajectories

        axes(ax2)
        imagesc(sim_data.info_map_2d{1,1}{1,j})
        colormap(ax2, winter(100))
        map1 = sim_data.info_map_2d{1,1}{1,j};
        info1 = sum(map1, 'all');              % observed map info vs optimal (full info)
        title("Agent 1: " + round(info1, 1) + "/100 observed")
        axis([1 11 1 11])
        
        axes(ax3)
        imagesc(sim_data.info_map_2d{2,1}{1,j})
        colormap(ax3, winter(100))
        map2 = sim_data.info_map_2d{2,1}{1,j};
        info2 = sum(map2, 'all');              % observed map info vs optimal (full info)
        title("Agent 2: " + round(info2, 1) + "/100 observed")
        axis([1 11 1 11])

        axes(ax4)
        imagesc(sim_data.info_map_2d{3,1}{1,j})
        colormap(ax4, winter(100))
        map3 = sim_data.info_map_2d{3,1}{1,j};
        info3 = sum(map3, 'all');              % observed map info vs optimal (full info)
        title("Agent 3: " + round(info3, 1) + "/100 observed")
        axis([1 11 1 11])

        axes(ax5)
        imagesc(sim_data.info_map_2d{4,1}{1,j})
        colormap(ax5, winter(100))
        map4 = sim_data.info_map_2d{4,1}{1,j};
        info4 = sum(map4, 'all');              % observed map info vs optimal (full info)
        title("Agent 4: " + round(info4, 1) + "/100 observed")
        axis([1 11 1 11])
        set(gca,'YDir','reverse')           % matlab is plotting the y-axis flipped for some unknown reason; this flips it back
        
        obs_metric(1:4,j) = [info1; info2; info3; info4];
        obs_metric(5, j) = sum( min([map1(:), map2(:), map3(:), map4(:)], [], 2), "all" );

        %pause()

    end % end sim plotting

% plot observation metric; shared info state + each agent individually

figure()
plot(obs_metric(1,:), 'DisplayName','agent 1')
hold on
plot(obs_metric(2,:), 'DisplayName','agent 2')
plot(obs_metric(3,:), 'DisplayName','agent 3')
plot(obs_metric(4,:), 'DisplayName','agent 4')
plot(obs_metric(5,:), 'LineWidth', 3, 'DisplayName','shared')
yline(100, "--", 'DisplayName', 'optimal')
ylim([0 125])

xlabel("Sim step")
ylabel("Observed information")
title("Agent map information vs sim step (decay rt: " + obj.sim_env.agents{1,1}.map.decay_rt + ")")
legend

end