function genSimStepDistanceMatrix(obj, sim_step)
%GENSIMSTEPDISTANCEMATRIX generate a distance matrix for each step of a
%single simulation iteration, keep a running average.

    x_pos = zeros(1, obj.numAgents);    % numAgents x sim_size matrix
    y_pos = zeros(1, obj.numAgents);

    for i = 1:obj.numAgents
        x_pos(1,i) = obj.agents{1,i}.x(1,1);
        y_pos(1,i) = obj.agents{1,i}.x(2,1);
    end

    dist_mat = ( hypot( x_pos-x_pos.', y_pos-y_pos.' ) < obj.agents{1,1}.comm_dist);
    dist_mat = dist_mat .* ~eye(obj.numAgents);

    obj.sim_conn_data{1, sim_step} = dist_mat;

    % cumulative average
    if isequal(sim_step,1)
        obj.sim_conn_data{2,sim_step} = dist_mat;
        obj.sim_conn_data{3,1} = dist_mat;
        obj.sim_conn_data{3,2} = dist_mat;
    else
        obj.sim_conn_data{2,sim_step} = ( dist_mat + ((sim_step-1).*obj.sim_conn_data{2,(sim_step-1)}) ) ./ sim_step; % log transient of cumulative average
        obj.sim_conn_data{3,1} = dist_mat + obj.sim_conn_data{3,1};                                                   % cumulative connections
        obj.sim_conn_data{3,2} = ( dist_mat + ((sim_step-1).*obj.sim_conn_data{3,2}) ) ./ sim_step;                   % cumulative average of conns
    end

end % end genSimStepDistanceMatrix