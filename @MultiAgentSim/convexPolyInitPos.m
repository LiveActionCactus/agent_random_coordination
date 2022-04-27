function init_pos = convexPolyInitPos(bounds, rounding)
%CONVEXPOLYINITPOS chooses from a uniform distribution the initial
%positions of agents so that they lie on the perimeter of a convex polygon

    % http://www.sunshine2k.de/coding/java/Polygon/Convex/polygon.htm#:~:text=Ok%2C%20so%20to%20check%20the,then%20it%20is%20not%20convex.
    % https://community.esri.com/t5/arcgis-pro-questions/identify-the-shape-of-polygon/m-p/1094308#M45045
    % https://stackoverflow.com/questions/42023522/random-sampling-of-points-along-a-polygon-boundary

    % TODO: check if convex polygon, rejeect if not

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
    if perim_map_idxs(1,end) < length(bounds) 
        vec = bounds(:, (perim_map_idxs(1,end)+1)) - bounds(:, perim_map_idxs(1,end));
        target = bounds(:, (perim_map_idxs(1,end)+1));
        base = bounds(:, perim_map_idxs(1,end));
    elseif isequal(perim_map_idxs(1,end), length(bounds))
        vec = bounds(:, 1) - bounds(:, (perim_map_idxs(1,end)));
        target = bounds(:, 1);
        base = bounds(:, (perim_map_idxs(1,end)));
    else
        error("Issue with convexPolyInitPos generation")
    end

    vec_norm = vec ./ norm(vec);                % normalize vector between vertices

    % test for direction of movement along perimeter
    init_pos1 = base + offset_dist.*vec_norm;    % +- between terms determines direction
    init_pos2 = base - offset_dist.*vec_norm;    % +- between terms determines direction
    dist1 = sqrt( (target(1,1) - init_pos1(1,1))^2 + (target(2,1) - init_pos1(2,1))^2);
    dist2 = sqrt( (target(1,1) - init_pos2(1,1))^2 + (target(2,1) - init_pos2(2,1))^2);
    
    if (dist1 < dist2)
        init_pos = init_pos1;
    elseif (dist1 > dist2)
        init_pos = init_pos2;
    else
        disp('Vertex init pos')
        init_pos = base;
    end

    init_pos = round(init_pos, 2);

    %init_pos = [init_pos, bounds(:, perim_map_idxs(1,end)), [base_vert; offset_dist]];
end