function initializeMap(obj)
%INITIALIZEMAP initializes lattice structure where each point stores
%information about how surveilled it is, from the perspective of the agent.
%This information is updated each time step and by communicating with other
%agents passing by.

% Assumes orthogonal basis with origin at (0,0)
% basically just handles rectangles and squares
boundx = max(obj.sim_env.boundary(1,:));
boundy = max(obj.sim_env.boundary(1,:));

obj.map.map = zeros((boundx*obj.map.scale), (boundy*obj.map.scale)); 

end