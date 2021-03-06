function init_pos = convexPolyInitPos(bounds, rounding)
%CONVEXPOLYINITPOS chooses from a uniform distribution the initial
%positions of agents so that they lie on the perimeter of a convex polygon

    % http://www.sunshine2k.de/coding/java/Polygon/Convex/polygon.htm#:~:text=Ok%2C%20so%20to%20check%20the,then%20it%20is%20not%20convex.
    % https://community.esri.com/t5/arcgis-pro-questions/identify-the-shape-of-polygon/m-p/1094308#M45045
    % https://stackoverflow.com/questions/42023522/random-sampling-of-points-along-a-polygon-boundary

    % TODO: check if convex polygon, rejeect if not
    % TODO; I THINK THIS IS RUNNING VERY SLOWLY

    num_vert = length(bounds);
    side_len = zeros(length(num_vert));

    % for n-1 sides
    for i = 1:(num_vert-1)
        dist = sqrt( (bounds(1,i+1) - bounds(1,i))^2 + (bounds(2,i+1) - bounds(2,i))^2 );
        side_len(1,i) = dist;
    end

    % for the n-th side
    dist = sqrt( (bounds(1,num_vert) - bounds(1,1))^2 + (bounds(2,num_vert) - bounds(2,1))^2 );
    side_len(1,num_vert) = dist;

    perim_map = round(cumsum(side_len), 2);               % unwraps perimeter to 1-D with vertices as indices
    perim_map = [0 perim_map];                            % now length num_vert+1

    % generate random number on unwrapped perimeter (1-D)
    init_mapped = round(perim_map(1,(num_vert+1))*rand(1,1), 2);    % 1-D initial position, need to map to 2-D
    perim_bool = perim_map <= init_mapped;
    perim_map_idxs = find(perim_bool == max(perim_bool)); % indices of perim_map less than random init position

    base_vert = perim_map(1, perim_map_idxs(1,end));      % unwrapped base vertex; use with init_mapped and following vertex 
    offset_dist = abs(init_mapped - base_vert);           % amount to walk

    % generate parametric equation for a line between base vertex and next
    target = [];
    base = [];
    if (perim_map_idxs(1,end) < length(bounds))
        target = bounds(:, perim_map_idxs(1,end)+1);
        base = bounds(:, (perim_map_idxs(1,end)));
        vec = target-base;
        vec_norm = vec ./ norm(vec);                % normalize vector between vertices
    elseif isequal(perim_map_idxs(1,end), length(bounds))
        target = bounds(:,1);
        base = bounds(:,perim_map_idxs(1,end));
        vec = target-base;
        vec_norm = vec ./ norm(vec);                % normalize vector between vertices
    elseif isequal(perim_map_idxs(1,end), (length(bounds)+1))
        target = bounds(:, 2);
        base = bounds(:, 1);
        vec = target - base;
        vec_norm = vec ./ norm(vec);                % normalize vector between vertices
%     elseif isequal(base_vert, init_mapped) && isequal(offset_dist, 0)        % captures edge case; last vertex w/ agent initialized there                                                               
%         vec = [0;0];
%         target = bounds(:,1);
%         base = bounds(:,1);
%         vec_norm = [0;0];
    else    
        disp(offset_dist)
        disp(base_vert)
        disp(init_mapped)
        disp(perim_map)
        disp(perim_bool)
        disp(perim_map_idxs)    
        disp(length(bounds))
        disp(bounds)
        error("Issue with convexPolyInitPos generation")
    end

    % test for direction of movement along perimeter
%     disp(base)
%     disp(vec_norm)
%     disp(offset_dist)
    init_pos1 = base + offset_dist.*vec_norm;    % +- between terms determines direction
    init_pos2 = base - offset_dist.*vec_norm;    % +- between terms determines direction
    dist1 = sqrt( (target(1,1) - init_pos1(1,1))^2 + (target(2,1) - init_pos1(2,1))^2);
    dist2 = sqrt( (target(1,1) - init_pos2(1,1))^2 + (target(2,1) - init_pos2(2,1))^2);
    
    if (dist1 < dist2)
        init_pos = init_pos1;
    elseif (dist1 > dist2)
        init_pos = init_pos2;
    else
        init_pos = base;
    end

    init_pos = round(init_pos, 2);

%     if(init_pos(1,1) < 0)
%         pause
end