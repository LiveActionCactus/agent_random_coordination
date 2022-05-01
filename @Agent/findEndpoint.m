function findEndpoint(obj)
%FINDENDPOINT find the endpoint of an agent's path given starting point and
%heading angle

% https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect/565282#565282
% https://math.stackexchange.com/questions/1966404/find-a-2d-unit-vector-perpendicular-to-a-given-vector
% https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box

% TODO: generalize for any convex symmetric polygon
% TODO: make this work for array of vertices, as opposed to shortcut 2
% points for axis-aligned box
% TODO: i think "inpolygon" runs very slowly...

    if isnan(obj.head_ang)
        error('No valid heading angle to find endpoint')
    end
    
    bounds = obj.sim_env.boundary;
    x_n = [1; 1];    % define unit vector
    
    r = ([cos(obj.head_ang); sin(obj.head_ang)] .* x_n);  % rotated unit vector 
    p = obj.x_o;                                         
    
    % TODO: generalize
%     s_vec = [
%         ([bounds(1,2); 0] - bounds(:,1)) ...
%         (bounds(:,2) - [bounds(1,2); 0]) ...
%         ([0; bounds(2,2)] - bounds(:,2)) ...
%         (bounds(:,1) - [0; bounds(2,2)])
%         ];
    
      s_vec = [diff(bounds,1,2), (bounds(:,1)-bounds(:,end))];
    
    % TODO: generalize
%     q_vec = [
%         bounds(:,1) ... 
%         [bounds(1,2); 0] ...
%         bounds(:,2) ...
%         [0; bounds(2,2)]
%         ];
      q_vec = bounds;

    % v x w = v_x w_y - v_y w_x         % 2-D cross product -> 1-D solution
    deno = (r(1,1) .* s_vec(2,:)) - (r(2,1) .* s_vec(1,:));
    
    u_temp1 = q_vec-p;
    u_temp2 = (r(2,1) .* u_temp1(1,:)) - (r(1,1) .* u_temp1(2,:));
    u = u_temp2 ./ deno;
    
    t_temp1 = (u_temp1(1,:) .* s_vec(2,:)) - (u_temp1(2,:) .* s_vec(1,:));
    t = t_temp1 ./ deno;
    
    %x1 = round((p + (t .* r)), 2);
    %x2 = round((q_vec + (u .* s_vec)), 2);
    x1 = (p + (t .* r));
    x2 = (q_vec + (u .* s_vec));
    
    if(sum((abs(x2 - x1) < 10e-2), 'all'))
        %x1(:,(obj.side_o+1)) = [inf; inf];
        %test = (x1 <= (bounds(:,2) + 10e-5)) & (x1 >= (bounds(:,1) - 10e-5));           % TODO: generalize for convex polygon
        %test(:, obj.side_o+1) = [0;0];
        %x_r = round(x1,1);              % hopefully solves numerical issues with polygon boundaries
        %x_r = fix(x1);
        [in_poly, on_poly] = inpolygon(x1(1,:), x1(2,:), bounds(1,:), bounds(2,:));
        idx = find(in_poly >= 1);
        obj.x_e = x1(:, in_poly);

        % choose furthest away solution (throws away trivial soln)
        if length(idx) > 1
            dist = zeros(1,length(idx));
            for i = 1:length(idx)
                % check distances, choose furthest away
                dist(1,i) = sqrt( sum( ( obj.x - x1(:,idx(1,i)) ).^2 ) );
            end
            [m, ix] = max(dist);         % returns max distance and index of that value
            obj.x_e = x1(:,idx(ix));          % endpoint is the furthest away point
                
        end % end if non-unique endpoint solution

        % TODO: handle empty idx
        if isempty(idx)
            disp(obj.side_o)
            disp(obj.x)
            disp(obj.head_ang)
            disp(x1)
            disp(x2)
            disp(in_poly)
            assignin("base","x_o",obj.x_o)
            assignin("base","x1",x1)
            assignin("base","x2",x2)
            error('No intersection solution found!... but inside loop... F')
        end

    else
        error('No valid intersection found for possible trajectories')
    end % end if intersection solution exists

    %
    % TEST TEST TEST
    % trying to capture highly unlikely errors (less than 1 in 10k sims...)
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

    obj.x_e = round(obj.x_e, 2);

end % end findEnpoint