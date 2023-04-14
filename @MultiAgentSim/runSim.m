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

    multi_start_freq = floor(obj.sim_itrs / 10); % decimate multi-start indices % TODO: fix this, it doesn't work if sim_itrs ~= 10
    per = 0;    % percent complete

    % run multi-start simulation loop
    for i = 1:obj.sim_itrs
        
        obj.initializeAgents();             % reset agents for sim run
        
        %TODO: need to run all of this once w/ initialization and then
        %iterate in the sim loop
        % run steps in a single simulation
        for n = 1:obj.N
            obj.n = n;
            obj.comms.undirectedCommsUpdate(n);
            
            for k = 1:obj.numAgents             % we need to update all of the agents' individual information states before decision making
                obj.agents{1,k}.updateMap(n);   % populate maps based off individual agent dynamics
            end

            obj.updateMapViaComms(n);           % update agent maps based off comms graph; map update via comms w/ other agents

            for k = 1:obj.numAgents
                obj.agents{1,k}.runAgent(n)     % update agent dynamics last; boundary or in-comms update  %TODO: THIS DOESN'T SEEM RIGHT, WE SHOULD UPDATE DYNAMICS FIRST THEN DO ALL THE PROPERTIES UPDATES...
            end

            %obj.comms.undirectedCommsUpdate(n);
        end % end for step in sim size

        % Print simple multi-start sim status
        if mod(i, multi_start_freq) == 0
            per = per + 10;
            fprintf("Sim %i%% Complete \n", per)
        end
        
        % TODO: this should be written to a .mat file to reduce runtime
        % overhead; also provides some level of fault tolerance if 
        % something crashes
        obj.storeAgentData(i);      % store state information between sim restarts
    
    end % end "sim_itrs"-times multi-start simulations

end % end runSim