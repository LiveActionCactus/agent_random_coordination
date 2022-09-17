function calcRenStochConv(obj, itr)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    calcUndirectedUnionGraph(obj, itr, 0);   % comms obj; sim step; reset union flag
    
    G = obj.comms_data.adj_mat{1,itr} + eye(obj.sim_env.numAgents);
    G = G ./ sum(G, 2);

    if isequal(itr,1)
        S = G;
    else
        S = G* obj.comms_data.ren_sia_mat{1,(itr-1)};
    end
    
    obj.comms_data.ren_sia_mat{1,itr} = S; % cell array of SIA matrices
    
    % Estimation update routine
    num_agents = obj.sim_env.numAgents;
    est_state = zeros(num_agents,1);
    
    for i = 1:num_agents
        est_state(i,1) = obj.sim_env.agents{1,i}.est_state;  % agent 1 at top of vector
    end     

    % Perform est update
    if isequal(itr,1)
        est_update = est_state;
    else
        est_update = S*est_state;
    end
    
    % Assign update to agent properties
    for i = 1:num_agents
        obj.sim_env.agents{1,i}.est_state = est_update(i,1);
    end

end % end calcRenStochConv()