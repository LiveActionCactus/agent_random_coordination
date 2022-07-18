function plotRenStochMat(obj)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    
    plot_trees = 6;
    rs_trees_int = {};
    rs_trees = [];
    
    comms = obj.sim_env.sim_itrs_data.comms;
    assignin('base','comms',comms)

    for i = 1:obj.sim_env.sim_itrs
       rs_trees_int{1,i} = cat(1, comms{1,i}.uunion_graph{1,:});

       % prune sim_itrs without enough spanning trees
       if ~(length(rs_trees_int{1,i}) < plot_trees)
            rs_trees(i,:) = cat(1, rs_trees_int{1,i}(1:plot_trees));
       end

    end % end 

    per_res = (length(rs_trees) / obj.sim_env.sim_itrs) * 100;
    fprintf("%i%% sim runs have at least %i spanning trees \n", per_res, plot_trees)
    
    figure()
    hold on

    for i = 1:plot_trees
        subplot(2,5,i)
        hist(rs_trees(:,i), 60)
        xlabel("Sim steps")
        ylabel("Occurances")
        title("Sim steps to " + i + " spanning tree(s)")
    end

    % Plot hists in one figure
    figure()
    hold on
    
    for i = 1:plot_trees
        if isequal(mod(i,2), 0)
            histogram(rs_trees(:,i), 60, 'FaceColor','red','EdgeColor','red', 'FaceAlpha', 0.7);
        else
            histogram(rs_trees(:,i), 60, 'FaceColor','blue','EdgeColor','blue');
        end
    end

    % Plot convergence of average consesus law acting on estimated states
    est_state_log = obj.sim_env.sim_itrs_data.est_state;
    est_state = cat(1, est_state_log{:,1});                     % for 1st sim iteration
    x = linspace(0, length(est_state)-1, length(est_state));

    figure()
    hold on
    
    for i = 1:obj.sim_env.numAgents
        plot(x, est_state(i,:))
    end

    ylim([0.0, 1.0])
    xlim([0.0, 200.0])
    grid on
    
    % NEED 100% TREES CONVERAGE OR ELSE THESE INDICES DONT LINE UP
    for k=1:plot_trees
        xline(rs_trees(1,k), "-.", "stree")                     % for 1st sim iteration
    end
     
    title(obj.sim_env.boundary(1,2) + "x" + obj.sim_env.boundary(2,2) + " bounds; " + obj.sim_env.numAgents + " agents; " + plot_trees + " spanning trees")
    xlabel("Sim step")
    ylabel("Information value")

end % end plotRenStochMat()