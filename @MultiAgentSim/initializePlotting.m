function initializePlotting(obj)
%INITIALIZEPLOTTING creates plotting object and stores instance in sim env
%as property. Plotting obj acts on data in the sim env and agents in order
%to produce graphics.
%
% --Inputs--
% obj : sim env object
%
% --Outputs--
% (None) : initializes SimPlotting object and stores obj in sim property
%
    
    obj.plotting = SimPlotting(obj);

end