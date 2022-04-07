function init_pos = squareInitPos(bounds, rounding)
%SQUAREINITIALPOS static function that defines a random initial condition
%(x,y) that lies on the parameter of a square.

    % https://matlab.fandom.com/wiki/FAQ#Why_is_0.3_-_0.2_-_0.1_.28or_similar.29_not_equal_to_zero.3F

    len = bounds(end,end);    % length of side of square
    unwrap_box = 4*len;     % box perimeter in 1-D; [0, len) x-axis, [len, 2*len) y-axis, [2*len, 3*len) y-axis2, [3*len, 4*len] x-axis2     
    pos = rand(1,1)*unwrap_box;

    switch pos
        case pos*(pos >= 0 && pos < len)
            init_pos = [pos; 0];
        case pos*(pos >= len && pos < 2*len)
            init_pos = [0; (pos-len)];
        case pos*(pos >= 2*len && pos < 3*len)
            init_pos = [len; (pos-(2*len))];
        case pos*(pos >= 3*len && pos <= 4*len)
            init_pos = [(pos-(3*len)); len];
        otherwise
            error("No valid initial condition generated");
    end % end switch

    init_pos = floor(init_pos) + floor( (init_pos-floor(init_pos))/rounding) * rounding; % rounds all values to "rounding" variable

    % if initial position is a vertex of the space, re-run (avoids
    % numerical issues)
%     if ismembertol(init_pos, bounds, 10e-04)
%         init_pos = MultiAgentSim.squareInitPos(bounds, rounding);
%     end
end