function agent_posns = formatAgentPosns(obj)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    agent_posns = zeros(2,obj.sim_env.numAgents);

    for i = 1:obj.sim_env.numAgents
        agent_posns(:, i) = obj.sim_env.agents{1,i}.state(2:3, 1);
    end

end % end formatAgentPosns