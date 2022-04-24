function ssd_plot = plotSimStepDistanceComms(obj)
%PLOTSIMSTEPDISTANCECOMMS plot the time-varying behavior of the
%communications in a single sim

    uppertri_ele = ( obj.numAgents * (obj.numAgents-1) ) / 2;   % analytic expression for number of upprer triangular elements
    ca_comm = zeros(obj.N, uppertri_ele);                       % flattened upper triangular elements
    n = linspace(1, obj.N, obj.N);                              % domain of single simulation
    ave_window = 2000;                                          % moving average window size

    for i = 1:obj.N
        ca_comm(i,:) = obj.sim_conn_data{2,i}(triu(true(obj.numAgents), 1))';
    end
  
    ca_comm = 1-ca_comm;

    ssd_plot{1,1} = figure();
    %set(ssd_plot, 'Visible', 'off');
    
    hold on
    for k = 1:uppertri_ele
        plot(n,ca_comm(:,k))
    end

    title("No communication probability vs. time (n=" + obj.numAgents + ")")
    xlabel("n-th step")
    ylabel("Probability of no comms")

    ylim([0.85 1.0])

    ssd_plot{1,2} = figure();
    %set(ssd_plot, 'Visible', 'off');
    
    hold on
    for k = 1:uppertri_ele
        plot(n, movmean(ca_comm(:,k), ave_window))
    end

    title("Moving ave (" + ave_window + ") -- No communication probability vs. time (n=" + obj.numAgents + ")")
    xlabel("n-th step")
    ylabel("Moving ave probability of no comms")

    ylim([0.95 1.0])

end % end plotSimStepDistanceComms