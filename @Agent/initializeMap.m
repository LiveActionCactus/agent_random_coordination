function initializeMap(obj)
%INITIALIZEMAP initializes lattice structure where each point stores
%information about how surveilled it is, from the perspective of the agent.
%This information is updated each time step and by communicating with other
%agents passing by.

% Assumes orthogonal basis with origin at (0,0)
% basically just handles rectangles and squares
boundx = max(obj.sim_env.boundary(1,:));
boundy = max(obj.sim_env.boundary(1,:));

obj.map.map = cell(1,obj.sim_env.N);                                           % TODO: i think this works, but not certain; need to initialize all maps to 0
for i = 1:obj.sim_env.N
    obj.map.map{1,i} = zeros((boundx*obj.map.scale)+1, (boundy*obj.map.scale)+1);  % +1 bc bounds are [0,bound] and map is [1, bound]
end
%pause()

end