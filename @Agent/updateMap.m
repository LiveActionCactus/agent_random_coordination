function updateMap(obj, n)
%UPDATEMAPONMOVE update information map due to agent motion, comms, and 
%based off lattice points inside the agent sensing region. Assumes the 
%sensing region is circular and the same as the communication region.
%
% -- Inputs --
% obj   : sim env object
% n     : sim itr num
%
% -- Outputs --
% (None) : updates agents referenced in sim object
%

    % variable assignment (in sim-space; (0,0) lower left)
    env_lx = obj.sim_env.boundary(1,1);         % env lower x bound
    env_ly = obj.sim_env.boundary(2,1);         % env lower y bound
    env_ux = obj.sim_env.boundary(1,2);         % env upper x bound
    env_uy = obj.sim_env.boundary(2,2);         % env upper y bound
    posx = obj.state(2,1);                      % x position
    posy = obj.state(3,1);                      % y position 
    s_dist = obj.comms.dist;     % circular sensing region radius
    map = obj.map.map;           % map to be updated; each lattice point in [0, 1.0] (least -> most info)
    scale = obj.map.scale;       % lattice quantization; dist between each adjacent lattice point

    % define subset of lattice as search space (in sim-space; (0,0) lower
    % left)
    search_lx = floor( max((posx - s_dist)*scale, env_lx) );            
    search_ly = floor( max((posy - s_dist)*scale, env_ly) );            
    search_ux = ceil( min((posx + s_dist)*scale, (env_ux)) );         % Note: dealing with matlab idx @ 1
    search_uy = ceil( min((posy + s_dist)*scale, (env_uy)) );
    
    % update map; search bottom-to-top and left-to-right
    
    fprintf("curx %d, cury %d, lx %d, ly %d, ux %d, uy %d \n", posx, posy, search_lx, search_ly, search_ux, search_uy);
    for x = search_lx:search_ux                                 
        for y = search_ly:search_uy
            dist = sqrt( (x-posx)^2 + (y-posy)^2 );
            if dist <= (s_dist + eps)
                % convert to map-space -- (1,1) in upper left (y,x) for
                % (rows,cols)
                %y_offset = env_uy - y + 1;                      % sets origin (0,0) to lower left corner
                my = env_uy - y + 1;
                mx = x + 1;
                map(my,mx) = 1.0;                    
                %pause()                            
            end  
        end
    end % end map search and update

    % check if agent in-comms with another agent

    disp(map)
    pause()
    obj.map.map = map;                              % TODO: maybe not assigning properly... issue with consistently getting all lattice points labelled
end