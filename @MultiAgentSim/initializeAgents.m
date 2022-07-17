function initializeAgents(obj)
%INITIALIZEAGENTS initialize agents that live in the simulation
%
% --Inputs--
% obj : sim env object
%
% --Outputs--
% (None) : initializes Agent objects and stores objects in sim property
%

    if ~isempty(obj.agents)
        for i = 1:length(obj.agents)
            obj.agents{1,i}.delete()
        end
    end
    
    for i = 1:obj.numAgents
        obj.agents{1,i} = Agent(obj, i);
    end

end % end initializeAgents