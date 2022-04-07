function findEndpoint(obj)
%FINDENDPOINT find the endpoint of an agent's path given starting point and
%heading angle

% https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect/565282#565282
% https://math.stackexchange.com/questions/1966404/find-a-2d-unit-vector-perpendicular-to-a-given-vector
% https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box

% TODO: generalize for any convex symmetric polygon
% TODO: make this work for array of vertices, as opposed to shortcut 2
% points for axis-aligned box

    if isnan(obj.head_ang)
        error('No valid heading angle to find endpoint')
    end
    
    bounds = obj.sim_env.boundary;
    x_n = [1; 1];    % define unit vector
    
    r = ([cos(obj.head_ang); sin(obj.head_ang)] .* x_n);  % rotated unit vector 
    p = obj.x_o;                                         
    
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
    
    x1 = p + (t .* r);
    x2 = q_vec + (u .* s_vec);
    
    if(sum((abs(x2 - x1) < 10e-2), 'all'))
        x1(:,(obj.side_o+1)) = [inf; inf];
        test = (x1 <= (bounds(:,2) + 10e-5)) & (x1 >= (bounds(:,1) - 10e-5));
        test(:, obj.side_o+1) = [0;0];
        idx = find(sum(test) >= 2);
        obj.x_e = x1(:,idx);

        if isempty(idx)
            error('No intersection solution found!... but inside loop... F')
        end

        %
        % TEST TEST TEST
        % 
        if length(idx) > 1
            dist = zeros(1,length(idx));
            for i = 1:length(idx)
                % check distances, choose furthest away
                dist(1,i) = sqrt( sum( ( obj.x - x1(:,idx(1,i)) ).^2 ) );
            end
            [m, ix] = max(dist);         % returns max distance and index of that value
            obj.x_e = x1(:,idx(ix));          % endpoint is the furthest away point
                
%             disp(x2)
%             disp(obj.head_ang)
%             disp(obj.x_o)
%             disp(x1)
%             disp(test)
%             disp(idx)
%             disp(obj.x)
%             disp((obj.x - x1(:,idx(1,i))).^2)
%             disp(dist)
%             disp(obj.x_e)
%             disp(ix)
%             disp(m)
%             disp('Non-unique endpoint solution')
%             pause
            
        end % end if non-unique endpoint solution (probably numerical issues)
        %
        % END TEST
        %
    else
        error('No valid intersection found for possible trajectories')
    end % end if intersection solution exists

    %
    % TEST TEST TEST
    %
    [r, c] = size(obj.x_e);
    if c > 1
        disp(obj.head_ang)
        disp(obj.x_o)
        disp(x1)
        disp(test)
        disp(idx)
        error('Non-unique endpoint solution')
    end
    
    if isempty(obj.x_e)
        disp(obj.x_o)
        disp(obj.head_ang)
        disp(x1)
        disp(test)
        disp(idx)
        error('x_e is empty')
    end
    %
    % END TEST
    %

end % end findEnpoint