function genTotalSimDistanceMatrix(obj, sim_itr)
%GENTOTALSIMDISTANCEMATRIX for a finished simulation iteration, generate an adjacency 
%matrix indicating which agents communicated

% TODO: generalize comm_dist for heterogeneous agent case

    x_pos = zeros(obj.N, obj.numAgents);    % numAgents x sim_size matrix
    y_pos = zeros(obj.N, obj.numAgents);
    for i = 1:obj.numAgents
        x_pos(:,i) = obj.agents{(sim_itr+1), i}(2,:)';
        y_pos(:,i) = obj.agents{(sim_itr+1), i}(3,:)';
    end

    cum_dist_mat = zeros(obj.numAgents, obj.numAgents);
    dist_mat = zeros(obj.numAgents, obj.numAgents);
    for i = 1:obj.N
        dist_mat = ( hypot( x_pos(i,:)-x_pos(i,:).', y_pos(i,:)-y_pos(i,:).' ) ...
            < obj.agents{1,1}.comm_dist);
        cum_dist_mat = cum_dist_mat + dist_mat;
    end

    obj.sim_conn_data{1,sim_itr} = cum_dist_mat .* ~eye(obj.numAgents);

end % end genDistanceMatrix