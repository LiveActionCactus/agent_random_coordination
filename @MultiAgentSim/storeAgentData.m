function storeAgentData(obj, i)
%STOREAGENTDATA stores agents' properties each run of the simulation and
% according to the function flags
%
% --Inputs--
% obj : sim env object
%
% --Outputs--
% i : sim # in the multi-start case; 1 if not multi-started
% 

    %TODO: make a struct to store in the cell array
    for k = 1:obj.numAgents
        obj.sim_itrs_data.state{k,i} = obj.agents{1,k}.state_log;        % store Agents info for prev sim run
        obj.sim_itrs_data.est_state{k,i} = obj.agents{1,k}.est_state_log;
    end

    obj.sim_itrs_data.comms{1,i} = obj.comms.comms_data;                
end