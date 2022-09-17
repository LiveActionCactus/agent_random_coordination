function calcUndirectedUnionGraph(obj, itr, reset_union)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    num_agents = obj.sim_env.numAgents;
    adj_mat = obj.comms_data.adj_mat{1, itr};

    % Initialize data strcutures in Comms, if necessary
    if isequal(itr,1)
        obj.comms_data.uunion_graph = cell(2,obj.sim_env.N);
        obj.comms_data.rs_trees = 0;
        G = zeros(num_agents);          % was eye(num_agents), can't determine meaningful matrix rank w/ eye()
    else
        G = obj.comms_data.uunion_graph{2, itr-1};
    
    end % end init 

    % Check if rooted spanning tree exists and reset union if flagged
    if (sum(G, 'all') > num_agents) && (rank(G) >= num_agents)
        obj.comms_data.rs_trees = obj.comms_data.rs_trees + 1;

        if isequal(itr, 1)
            obj.comms_data.uunion_graph{1, itr} = itr;
        else
            obj.comms_data.uunion_graph{1, itr-1} = itr-1; % denote when spanning tree occurs
        end

        G = zeros(num_agents);

    end % end if rank denotes (non-trivial) spanning tree
    
    % The actual union update
    G = max(G, adj_mat);
    obj.comms_data.uunion_graph{2, itr} = G;

end