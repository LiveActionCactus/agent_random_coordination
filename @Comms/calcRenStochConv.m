function calcRenStochConv(obj, itr)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    num_agents = obj.sim_env.numAgents;
    adj_mat = obj.comms_data.adj_mat{1, itr};

    if isequal(itr,1)
        obj.comms_data.ren_stoch_mat = cell(2,obj.sim_env.N);
        obj.comms_data.trees = 0;
        G = zeros(num_agents);          % was eye(num_agents)
    else
        G = obj.comms_data.ren_stoch_mat{2, itr-1};
    end

    if (sum(G, 'all') > num_agents) && (rank(G) >= num_agents)
        obj.comms_data.trees = obj.comms_data.trees + 1;

        if isequal(itr, 1)
            obj.comms_data.ren_stoch_mat{1, itr} = itr;
        else
            obj.comms_data.ren_stoch_mat{1, itr-1} = itr-1; % denote when spanning tree occurs
        end

        G = zeros(num_agents);

    end % end if rank denotes (non-trivial) spanning tree
    
    G = max(G, adj_mat);
    %G_r = rank(G.*-eye(num_agents));   % we can do this later
    %matrices{3,i} = G_r;

    obj.comms_data.ren_stoch_mat{2, itr} = G;

end % end calcRenStochConv()