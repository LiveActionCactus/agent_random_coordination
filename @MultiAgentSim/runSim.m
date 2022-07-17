function runSim(obj)
%RUNSIM increment simulation by one, update agent dynamics and stored-state
%information when applicable.
%
% --Inputs--
% obj : sim env object
%
% --Outputs--
% (None) : updates agents referenced in sim object
%

    multi_start_freq = floor(obj.sim_itrs / 10); % decimate multi-start indices
    per = 0;    % percent complete

    % run multi-start simulation loop
    for i = 1:obj.sim_itrs
        
        % run steps in a single simulation
        for n = 1:obj.N
            obj.n = n;
            
            for k = 1:obj.numAgents
                obj.agents{1,k}.runAgent(n)
            end
       
        end % end for step in sim size

        % Print simple multi-start sim status
        if mod(i, multi_start_freq) == 0
            per = per + 10;
            fprintf("Sim %i%% Complete \n", per)
        end
        
        obj.storeAgentData(i);
        obj.initializeAgents();
        %obj.resetAgents();                          % reset Agent properties for simulation restarts
    
    end % end "sim_itrs"-times multi-start simulations

end % end runSim