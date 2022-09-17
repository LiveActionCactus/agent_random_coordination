function setInitialPos(obj)
%SETINITIALPOS initialize the agent on the perimiter of the
%bounds
%
% --Inputs--
% obj : Agent object
%
% --Outputs--
% (None) : updates Agent's properties pertaining to (re-)initial state
%

    obj.traj.x_o = MultiAgentSim.squareInitPos(obj.sim_env.boundary, 0.01);
    obj.state(2:3, 1) = obj.traj.x_o; 

end % end setInitialPos