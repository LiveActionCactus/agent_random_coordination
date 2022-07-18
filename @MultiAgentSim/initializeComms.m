function initializeComms(obj)
%INITIALIZEPLOTTING creates comms object for updating global comms data in
% SimEnv and local comms data in Agent objects
%
% --Inputs--
% obj : sim env object
%
% --Outputs--
% (None) : initializes Coms object and stores obj in sim property
%
    
    obj.comms = Comms(obj);

end % end initializeComms()