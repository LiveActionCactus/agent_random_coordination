function setInitialPos(obj)
    %SETINITIALPOS initialize the agent on the perimiter of the
    %bounds
    
    obj.x_o = MultiAgentSim.squareInitPos(obj.sim_env.boundary, 0.01);
    obj.x = obj.x_o; 

end % end setInitialPos