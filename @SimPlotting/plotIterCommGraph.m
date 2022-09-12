function plotIterCommGraph(obj)
%PLOTITERCOMMGRAPH Summary of this function goes here
%   Detailed explanation goes here

    num_agents = obj.sim_env.numAgents;
    sim_len = obj.sim_env.n;
    sim_data = obj.sim_env.sim_itrs_data;


    fig = figure();

    ax1 = subplot(2, 2, [1 3], "Parent", fig);
    axis([0 10 0 10])
    
    ax2 = subplot(2, 2, 2, "Parent", fig);
    %title("Communication graph at current step")
    axis([-1 1 -1 1])

    ax3 = subplot(2,2, 4, "Parent", fig);
    %title("Union of previous communication graphs")
    axis([-1 1 -1 1])

    hold on

    col = lines(num_agents);

    traj = {};
    for i = 1:num_agents
        traj{1,i} = animatedline('Color', col(i,:), 'Marker', '*', 'MarkerSize', 3, "DisplayName", string(i), 'Parent', ax1);
    end

    %legend('location', 'northeastoutside')

    poly = nsidedpoly(num_agents);
    g_vert = poly.Vertices;
    mask = tril(true(size(ones(3,3))), -1);

    for j = 1:sim_len
        axes(ax1)
        hold on

        for k = 1:4
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
            end
        end

        drawnow

        % TODO: plot comms circles around agents when in comms; visualize
        % when communicating to troubleshoot issues
        udist_mat = obj.sim_env.comms.comms_data.udist_mat{1,j};
        %disp(obj.sim_env.comms.comms_data.udist_mat{1,j})
        ugraph_mask = (triu( (obj.sim_env.comms.comms_data.udist_mat{1,j} <= obj.sim_env.agents{1,k}.comms.dist), 1) );
        %disp(ugraph_mask)
        [row, col, v] = find(ugraph_mask);
        %fprintf("(%i, %i) \n\n", row, col);
        
        % plot current comms graph (ASSUMES SYMMETRIC ADJ MATRIX)
        axes(ax2)
        adj = obj.sim_env.comms.comms_data.adj_mat{1,j};
        G = graph(adj);
        cla(ax2)
        plot(G, "XData", g_vert(:,1), "YData", g_vert(:,2), "NodeColor", "b", "EdgeColor", "r")
        title("Communication graph at current step")
        
        % plot union comms graph
        axes(ax3)
        union_g = obj.sim_env.comms.comms_data.uunion_graph{2,j};
        %disp(union_g)
        Gu = graph(union_g);
        cla(ax3)
        plot(Gu, "XData", g_vert(:,1), "YData", g_vert(:,2), "NodeColor", "b", "EdgeColor", "r");
        title("Union of previous communication graphs")

        fprintf("Sim step %i \n", j)

        fprintf("A1: (%f, %f); A2: (%f,%f); A3: (%f,%f); A4: (%f,%f) \n", ...
            sim_data.state{1,1}(2,j), sim_data.state{1,1}(3,j), ...
            sim_data.state{2,1}(2,j), sim_data.state{2,1}(3,j), ...
            sim_data.state{3,1}(2,j), sim_data.state{3,1}(3,j), ...
            sim_data.state{4,1}(2,j), sim_data.state{4,1}(3,j))
        fprintf("distance matrix \n")
        disp(udist_mat)
        fprintf("adjacency matrix \n")
        disp(adj)

        %disp(obj.sim_env.comms.comms_data.uunion_graph{2,j})
        fprintf("--- \n")
        pause()
    end
    
    % TODO: seems like sometimes agents outside a ball of radius 2.0 are in
    % comms
    % TODO: plot w/ consistent coloring
    % TODO: side-by-side plot of agent paths with graph connectivity
    % TODO: not recognizing first occurance of a spanning tree, watch
    % graphs closely

end % end plotIterCommGraph()