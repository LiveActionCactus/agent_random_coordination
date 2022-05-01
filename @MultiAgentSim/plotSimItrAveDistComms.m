function itr_comm_plot = plotSimItrAveDistComms(obj)
%PLOTSIMITRAVEDISTCOMMS plot the iterations communication occurances over the
%multi-start simulation.

% TODO: refactor this with plotSimStepDistanceComms to have a single graph
% plotting function

% https://www.johndcook.com/blog/standard_deviation/

    uppertri_ele = ( obj.numAgents * (obj.numAgents-1) ) / 2;   % analytic expression for number of upprer triangular elements
    ca_comm = zeros(obj.sim_itrs, uppertri_ele);                % flattened upper triangular elements
    
    cvar_comm = zeros(obj.sim_itrs, uppertri_ele);              % find running variance of each agent comms
    cvar_final = zeros(obj.sim_itrs, uppertri_ele);
    mvar_comm = zeros(1, uppertri_ele);

    obj.sim_conn_data{2,2} = zeros(1, uppertri_ele);            % track the number of sim iterations without comms
    agent_zeros = zeros(1, uppertri_ele);
    
    n = linspace(1, obj.sim_itrs, obj.sim_itrs);                % domain of single simulation
    ave_window = 2000;                                          % moving average window size
    %ave_window = 1;
    
    % generate analysis data for plotting
    for i = 1:obj.sim_itrs
        ca_comm(i,:) = obj.sim_conn_data{1,i}(triu(true(obj.numAgents), 1))';
        
        if isequal(i,1)
            mvar_comm = ca_comm(i,:);
            cvar_comm(i,:) = zeros(1, uppertri_ele);
            cvar_final(i,:) = cvar_comm(i,:);
        else
            mstd_prev = mvar_comm;
            mvar_comm = mstd_prev + (ca_comm(i,:) - mstd_prev)/i;
            cvar_comm(i,:) = cvar_comm((i-1),:) + (ca_comm(i,:)-mstd_prev).*(ca_comm(i,:)-mvar_comm);
            cvar_final(i,:) = cvar_comm(i,:) ./ (i-1);
        end

        obj.sim_conn_data{2,2} = obj.sim_conn_data{2,2} + (agent_zeros == ca_comm(i,:));
    end

    itr_comm_occur_plot = figure();
    %set(itr_comm_occur_plot, 'Visible', 'off');

    hold on
    for k = 1:uppertri_ele
        plot(n,ca_comm(:,k))
    end

    title("Communication occurances vs. Sim iteration (n=" + obj.numAgents + ")")
    xlabel("k-th multi-start")
    ylabel("Comm occurances")

    itr_comm_occur_std_plot = figure();
    %set(itr_comm_occur_std_plot, 'Visible', 'off');

    hold on
    for k = 1:uppertri_ele
        plot(n, movmean(cvar_final(:,k), ave_window))
    end

    title("Moving Ave (" + ave_window + ") comms occurances std. dev vs. Sim iteration (n=" + obj.numAgents + ")")
    xlabel("k-th multi-start")
    ylabel("Comm occurances std. dev")

    itr_comm_plot = {itr_comm_occur_plot, itr_comm_occur_std_plot};

end % plotSimItrAveDistComms