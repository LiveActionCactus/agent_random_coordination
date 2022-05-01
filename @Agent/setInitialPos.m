function setInitialPos(obj)
    %SETINITIALPOS initialize the agent on the perimiter of the
    %bounds
    
    % original case
    %obj.x_o = MultiAgentSim.squareInitPos(obj.sim_env.boundary, 0.01);
    
    % general case
    obj.x_o = MultiAgentSim.convexPolyInitPos(obj.sim_env.boundary, 0.01);
    obj.x = obj.x_o; 

end % end setInitialPos