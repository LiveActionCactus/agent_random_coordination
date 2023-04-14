function undirectedCommsUpdate(obj, itr)
%UNDIRECTEDCOMMSUPDATE generates an nxn distance matrix and mask based on homogeneous
%communication capabilities of the agents, given 2xn position matrix.

    comms_dist = obj.sim_env.agents{1,1}.comms.dist;
    agent_posns = formatAgentPosns(obj);
    %assignin("base","agent_posns",agent_posns)

    diag_num_agents = eye( length(agent_posns) );       % repeated operation on matrix diagonal
    
    dist_mat = hypot( agent_posns(1,:)-agent_posns(1,:).', agent_posns(2,:)-agent_posns(2,:).');
    adj_mat = ( dist_mat <= comms_dist ) - diag_num_agents;
    deg_mat = diag_num_agents .* sum(adj_mat, 2);
    
    % store variables in sim_env
    obj.comms_data.udist_mat{1,itr} = dist_mat;
    obj.comms_data.adj_mat{1,itr} = adj_mat;
    obj.comms_data.deg_mat{1,itr} = deg_mat;
    
    adj_check = sum(adj_mat, 2);            % if agent in comms row vec 
    for k = 1:obj.sim_env.numAgents
        if adj_check(k) > 0
            obj.sim_env.agents{1,k}.comms.in_comm = 1;          % in comms
        else
            obj.sim_env.agents{1,k}.comms.in_comm = 0;          % not in comms
        end % end check if agent in comms
    end % end loop over agents

    calcRenStochConv(obj, itr);             % TODO: THIS SHOULD ONLY BE RUN IF FLAGGED

end % end undirectedCommsUpdate