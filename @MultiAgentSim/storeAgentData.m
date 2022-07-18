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
        obj.sim_itrs_data{k,i} = struct("state", obj.agents{1,k}.state_log);        % store Agents info for prev sim run
    end

    obj.sim_itrs_data{obj.numAgents+1,i} = obj.comms.comms_data;                % TODO: find better place / way for this
end