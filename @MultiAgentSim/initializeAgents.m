function initializeAgents(obj)
%INITIALIZEAGENTS initialize agents that live in the simulation
    
    for i = 1:obj.numAgents
        obj.agents{1,i} = Agent(obj, i);
    end

end % end initializeAgents