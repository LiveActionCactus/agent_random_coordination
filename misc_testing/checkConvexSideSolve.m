%FINDCONVEXSIDE determine which side of convex polygon agent is on

% [DONE] need to deal with numerical issue not allowing "side = 0" to return
% [DONE] need to capture side 3
% [DONE] better capture the "0" side numerically
% TODO: replicate error with ang = 0.7854 and curr_ang = 3.1416


% Labeling for a symmetric 4-gon (square)
%     2
%   -----
%   |   |
% 3 |   | 1
%   -----
%     0
%



sides = 4;               % axis aligned square
%curr_pos = [20; 0.0181];
curr_ang = acos(dot(curr_pos, [1; 0]) / (norm(curr_pos) * norm([1; 0])));
%curr_ang = acos(curr_pos(1,1))
%curr_ang = 3.1416;

ang = pi/sides; 
%ang = pi/(2*sides); 
eps = 1e-5;                 % TODO: make this a function of "rounding" var

side = NaN;

% cases required to capture the n=0 and n=n cases numerically
for n = 0:(sides-1)
    if n == 0
        if ((curr_ang <= (n*ang + eps) && curr_ang >= (n-1)*ang ))
            side = n;
            break
        end
    else
        if ((curr_ang <= (n*ang - eps) && curr_ang >= ((n-1)*ang - eps)))
            side = n;
            break
        end
    end % end if
end % end for sides

if isnan(side)
    disp(ang)
    disp(curr_ang)
    error("Side not assigned")
end % if side not properly assigned

disp('Side')
disp(side)
