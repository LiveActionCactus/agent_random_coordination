function plotSimStepDistanceComms(obj)
%PLOTSIMSTEPDISTANCECOMMS plot the time-varying behavior of the
%communications in a single sim
%
% --Inputs--
% (None) : simulation object
%
% --Outputs--
% (None) : creates a single figure for a single sim
%

    uppertri_ele = ( obj.numAgents * (obj.numAgents-1) ) / 2;   % analytic expression for number of upprer triangular elements
    ca_comm = zeros(obj.N, uppertri_ele);                       % flattened upper triangular elements
    n = linspace(1, obj.N, obj.N);                              % domain of single simulation
    
    for i = 1:obj.N
        ca_comm(i,:) = obj.sim_conn_data{2,i}(triu(true(obj.numAgents), 1))';
    end
  
    ca_comm = 1-ca_comm;

    figure()
    hold on
    for k = 1:uppertri_ele
        plot(n,ca_comm(:,k))
    end

    title("No communication probability vs. time")
    xlabel("n-th step")
    ylabel("Probability of no comms")

end % end plotSimStepDistanceComms