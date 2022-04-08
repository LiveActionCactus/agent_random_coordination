function side = findConvexSide(sides, curr_pos)
%FINDCONVEXSIDE determine which side of convex polygon agent is on, shapes
%live in domain of [0, pi].

% [DONE] need to deal with numerical issue not allowing "side = 0" to return
% [DONE] need to capture side 3
% [DONE] better capture the "0" side numerically

% Labeling for a symmetric 4-gon (square)
%     2
%   -----
%   |   |
% 3 |   | 1
%   -----
%     0
%

    ang = pi/sides; 
    eps = 1e-5;                 % TODO: make this a function of "rounding" var
    side = NaN;

    curr_ang = acos(dot(curr_pos, [1; 0]) / (norm(curr_pos) * norm([1; 0]))); % returns values between [0, pi] wrt x-basis vector
    if isnan(curr_ang)
        curr_ang = 0;
    end
    
    % cases required to capture the n=0 and n=n cases numerically
    for n = 0:(sides-1)
        if n == 0
            if ((curr_ang <= (n*ang + eps) && curr_ang >= (n-1)*ang ))
                side = n;
                return
            end
        else
            if ((curr_ang <= (n*ang - eps) && curr_ang >= ((n-1)*ang - eps)))
                side = n;
                return
            end
        end % end if
    end % end for sides
    
    if isnan(side)
        disp(ang)
        disp(curr_ang)
        disp(curr_pos)
        error("Side not assigned")
    end % if side not properly assigned

end % end findConvexSide