function genHeadingAngle(obj, rounding)
%GENHEADINGANGLE generate new random heading angle upon intersection with a
%boundary
%
% --Inputs--
% obj : Agent object
% rounding : precision of output heading angle
%
% --Outputs--
% (None) : generates new rand head_ang and boundary side of intersection
%

% TODO: need to generalize how "sides" is determined

    bounds = obj.sim_env.boundary;
    curr_pos = obj.state(2:3, 1);
    
    sides = 2*length(bounds);           % number of sides in convex polygon    
    rot_ang = (pi)/(sides);             % amount to rotate by per side
    interior_ang = 180 - (2*rot_ang);   % total interior angle at each vertex

    if ~isequal(size(curr_pos), size([1; 0]))
        disp('Curr pos not same size as [1 0]')
    end

    side = MultiAgentSim.findConvexSide(sides, curr_pos); % counts sides starting at 0 indexing up traveling CCW
    
    eps = 1e-2;             % prevent agents from hugging perimeter
    
    b_uw = pi + (((2*pi)/sides) * side) - eps;    % unwrapped upper bound
    a_uw = 0 + (((2*pi)/sides) * side) + eps;     % unwrapped lower bound
    
    head_ang_uw = a_uw + (b_uw-a_uw)*rand();
    head_ang = head_ang_uw - (2*pi) * floor(head_ang_uw/(2*pi));
    
    if head_ang > 10e-2
        head_ang = floor(head_ang) + floor( (head_ang-floor(head_ang))/rounding) * rounding; % rounds all values to "rounding" variable, if greater than 0
    end

    obj.traj.side_o = side;
    obj.state(1,1) = head_ang;

end % end genHeadingAngle