function setInitialEst(obj)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    inits = linspace(0, 1, obj.sim_env.numAgents);
    obj.est_state = inits(1, obj.id);

end % end setInitialEst()