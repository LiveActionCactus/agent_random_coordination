function genHeadingAngle(obj, rounding)
%GENHEADINGANGLE generate new random heading angle upon intersection with a
%boundary

% TODO: need to generalize how "sides" is determined

    bounds = obj.sim_env.boundary;
    curr_pos = obj.x;
    
    sides = 2*length(bounds);           % number of sides in convex polygon    
    rot_ang = (pi)/(sides);             % amount to rotate by per side
    interior_ang = 180 - (2*rot_ang);   % total interior angle at each vertex

    test1 = size(curr_pos);
    test2 = size([1; 0]);
    if ~isequal(test1, test2)
        disp(test1)
        disp(test2)
        disp(isempty(curr_pos))
        disp(curr_pos)
        disp('Curr pos not same size as [1 0]')
    end

    curr_ang = acos(dot(curr_pos, [1; 0]) / (norm(curr_pos) * norm([1; 0]))); % returns values between [0, pi] wrt x-basis vector
    if isnan(curr_ang)
        curr_ang = 0;
    end
    
    side = findConvexSide(sides, curr_ang); % counts sides starting at 0 indexing up traveling CCW
    
    eps = 1e-2;             % prevent agents from hugging perimeter
    
    b_uw = pi + (((2*pi)/sides) * side) - eps;    % unwrapped upper bound
    a_uw = 0 + (((2*pi)/sides) * side) + eps;     % unwrapped lower bound
    
    head_ang_uw = a_uw + (b_uw-a_uw)*rand();
    head_ang = head_ang_uw - (2*pi) * floor(head_ang_uw/(2*pi));
    
    if head_ang > 10e-2
        head_ang = floor(head_ang) + floor( (head_ang-floor(head_ang))/rounding) * rounding; % rounds all values to "rounding" variable, if greater than 0
    end

    obj.side_o = side;
    obj.head_ang = head_ang;

end % end genHeadingAngle