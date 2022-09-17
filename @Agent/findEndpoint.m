function findEndpoint(obj)
%FINDENDPOINT find the endpoint of an agent's path given starting point and
%heading angle
%
% --Inputs--
% obj : sim env object
%
% --Outputs--
% (None) : updates agents referenced in sim object
%

% https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect/565282#565282
% https://math.stackexchange.com/questions/1966404/find-a-2d-unit-vector-perpendicular-to-a-given-vector
% https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box

% TODO: generalize for any convex symmetric polygon
% TODO: make this work for array of vertices, as opposed to shortcut 2
% points for axis-aligned box

    head_ang = obj.state(1,1);
    x = obj.state(2:3, 1);

    if isnan(head_ang)
        error('No valid heading angle to find endpoint')
    end
    
    bounds = obj.sim_env.boundary;
    x_n = [1; 1];    % define unit vector
    
    r = ([cos(head_ang); sin(head_ang)] .* x_n);  % rotated unit vector 
    p = obj.traj.x_o;                                         
    
    s_vec = [
        ([bounds(1,2); 0] - bounds(:,1)) ...
        (bounds(:,2) - [bounds(1,2); 0]) ...
        ([0; bounds(2,2)] - bounds(:,2)) ...
        (bounds(:,1) - [0; bounds(2,2)])
        ];
    
    q_vec = [
        bounds(:,1) ... 
        [bounds(1,2); 0] ...
        bounds(:,2) ...
        [0; bounds(2,2)]
        ];
    
    % v x w = v_x w_y - v_y w_x         % 2-D cross product -> 1-D solution
    deno = (r(1,1) .* s_vec(2,:)) - (r(2,1) .* s_vec(1,:));
    
    u_temp1 = q_vec-p;
    u_temp2 = (r(2,1) .* u_temp1(1,:)) - (r(1,1) .* u_temp1(2,:));
    u = u_temp2 ./ deno;
    
    t_temp1 = (u_temp1(1,:) .* s_vec(2,:)) - (u_temp1(2,:) .* s_vec(1,:));
    t = t_temp1 ./ deno;
    
    x1 = round((p + (t .* r)), 2);
    x2 = round((q_vec + (u .* s_vec)), 2);
    
    if(sum((abs(x2 - x1) < 10e-2), 'all'))
        x1(:,(obj.traj.side_o+1)) = [inf; inf];
        test = (x1 <= (bounds(:,2) + 10e-5)) & (x1 >= (bounds(:,1) - 10e-5));
        test(:, obj.traj.side_o+1) = [0;0];
        idx = find(sum(test) >= 2);
        obj.traj.x_e = x1(:,idx);

        % if numerical issues cause more than one intersection solution,
        % choose the one that is furthest away (we see that we are 
        % choosing between current position and desired solution (further).
        if length(idx) > 1
            dist = zeros(1,length(idx));
            for i = 1:length(idx)
                % check distances, choose furthest away
                dist(1,i) = sqrt( sum( ( x - x1(:,idx(1,i)) ).^2 ) );
            end
            [m, ix] = max(dist);         % returns max distance and index of that value
            obj.traj.x_e = x1(:,idx(ix));          % endpoint is the furthest away point
                
        end % end if non-unique endpoint solution

        % TODO: handle empty idx; causes error in 1 of 20k sims
        % if numerical issues leave idx empty we need to do a brute-force
        % search of all sides
        if isempty(idx)
            disp(obj.traj.side_o)
            disp(x)
            disp(x1)
            disp(x2)
            disp(test)
            error('No intersection solution found!... but inside loop... F')
        end

    else
        error('No valid intersection found for possible trajectories')
    end % end if intersection solution exists

    %
    % TEST TEST TEST
    % trying to capture highly unlikely errors (less than 1 in 10k sims...)
    %
    [r, c] = size(obj.traj.x_e);
    if c > 1
        disp(head_ang)
        disp(obj.traj.x_o)
        disp(x1)
        disp(test)
        disp(idx)
        error('Non-unique endpoint solution')
    end
    
    if isempty(obj.traj.x_e)
        disp(obj.traj.x_o)
        disp(head_ang)
        disp(x1)
        disp(test)
        disp(idx)
        error('x_e is empty')
    end
    %
    % END TEST
    %

    obj.traj.x_e = round(obj.traj.x_e, 2);

end % end findEnpoint