function updateMap(obj, n)
%UPDATEMAP update information map due to agent motion, comms, and 
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
    s_dist = obj.comms.dist;                % circular sensing region radius

    if isequal(n,1)
        prev_map = obj.map.map{1,n};            % TODO: need to actually choose previous map; map w/ out most recent move; each lattice point in [0, 1.0] (least -> most info)
    else
        prev_map = obj.map.map{1,n-1}; 
    end    
        
    upd_map  = zeros(size(prev_map));       % map information only from most recent move
    scale = obj.map.scale;                  % lattice quantization; dist between each adjacent lattice point
    decay = obj.map.decay_rt;               % rate of information decay

    % define subset of lattice as search space (in sim-space; (0,0) lower
    % left)
    search_lx = floor( max((posx - s_dist)*scale, env_lx) );            
    search_ly = floor( max((posy - s_dist)*scale, env_ly) );            
    search_ux = ceil( min((posx + s_dist)*scale, (env_ux)) );
    search_uy = ceil( min((posy + s_dist)*scale, (env_uy)) );
    
    % update map; search bottom-to-top and left-to-right
    for x = search_lx:search_ux                                 
        for y = search_ly:search_uy
            dist = sqrt( (x-posx)^2 + (y-posy)^2 );
            if dist <= s_dist
                my = env_uy - y + 1;                    % Note: dealing with matlab idx @ 1
                mx = x + 1;                             % Note: dealing with matlab idx @ 1
                upd_map(my,mx) = 1.0;      
            end  
        end
    end % end map search and update

    % update comms for single agent; based of decayed historical info &
    % kinematics
    decayed_map = prev_map.*decay;
%     disp('decayed map')
%     disp(decayed_map)
%     disp('upd map')
%     disp(upd_map)
%     pause()
    new_map = max(upd_map, decayed_map);                              
    
    obj.map.map{1,n} = new_map;             % store new information map at step n
end