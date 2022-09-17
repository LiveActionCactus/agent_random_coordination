function undirectedCommsUpdate(obj, itr)
%UNTITLED3 generates an nxn distance matrix and mask based on homogeneous
%communication capabilities of the agents, given 2xn position matrix.

    comms_dist = obj.sim_env.agents{1,1}.comms.dist;
    agent_posns = formatAgentPosns(obj);

    diag_num_agents = eye( length(agent_posns) );       % repeated operation on matrix diagonal
    
    dist_mat = hypot( agent_posns(1,:)-agent_posns(1,:).', agent_posns(2,:)-agent_posns(2,:).');
    adj_mat = ( dist_mat <= comms_dist ) - diag_num_agents;
    deg_mat = diag_num_agents .* sum(adj_mat, 2);
    
    % store variables in sim_env
    obj.comms_data.udist_mat{1,itr} = dist_mat;
    obj.comms_data.adj_mat{1,itr} = adj_mat;
    obj.comms_data.deg_mat{1,itr} = deg_mat;

    calcRenStochConv(obj, itr);

end % end undirectedCommsUpdate