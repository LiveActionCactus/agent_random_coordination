function bounds = genRegularPolygonBounds(radius, num_vertices)
%GENREGULARPOLYGONBOUNDS generate array of vertices corresponding to the
%specified regular polygon

    r = radius;
    n = num_vertices;
    bounds = [];

    org = (3*pi/2)- (pi/n);
    for i = 1:n
        bounds(:,i) = [r*cos(2*pi*((i-1)/n) + org); r*sin(2*pi*((i-1)/n) + org)];
    end

    %bounds = round((bounds + abs(bounds(:,1))), 2);
    %bounds = bounds + abs(bounds(:,1));
    %bounds = bounds + [abs(min(bounds(1,:))); abs(min(bounds(2,:)))];
    bounds = bounds + abs(bounds(:,end)) + abs(bounds(:,1));


end % end genRegularPolygonBounds