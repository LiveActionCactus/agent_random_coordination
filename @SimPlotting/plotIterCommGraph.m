function plotIterCommGraph(obj)
%PLOTITERCOMMGRAPH Summary of this function goes here
%   Detailed explanation goes here

    num_agents = obj.sim_env.numAgents;
    sim_len = obj.sim_env.n;
    sim_data = obj.sim_env.sim_itrs_data;


    figure()
    hold on
    axis([0 10 0 10])
    col = lines(num_agents);

    traj = {};
    for i = 1:num_agents
        traj{1,i} = animatedline('Color', col(i,:), 'Marker', '*', 'MarkerSize', 3);
    end

    assignin("base","traj",traj)

    for j = 1:sim_len
        for k = 1:4
            if isvalid(traj{1,i})
                %scatter(sim_data.state{k,1}(2,j), sim_data.state{k,1}(3,j))
                addpoints(traj{1,k}, sim_data.state{k,1}(2,j), sim_data.state{k,1}(3,j))
                title("Agent trajectories -- itr: " + j)
    
                if isequal(j,1)
                    plot(sim_data.state{k,1}(2,1), sim_data.state{k,1}(3,1), '-^', 'Color', col(k,:), 'MarkerFaceColor', col(k,:))
                elseif isequal(j,sim_len)
                    plot(sim_data.state{k,1}(2,end), sim_data.state{k,1}(3,end), '-s', 'Color', col(k,:), 'MarkerFaceColor', col(k,:))
                end
            end
        end
        drawnow

        fprintf("Sim step %i \n", j)
        disp(obj.sim_env.comms.comms_data.uunion_graph{2,j})
        fprintf("--- \n")
        pause()
    end
    
    % TODO: seems like sometimes agents outside a ball of radius 2.0 are in
    % comms
    % TODO: plot w/ consistent coloring
    % TODO: side-by-side plot of agent paths with graph connectivity

end % end plotIterCommGraph()