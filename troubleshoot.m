[in, on] = inpolygon(x1(1,:), x1(2,:), bounds(1,:), bounds(2,:));

scatter(bounds(1,:), bounds(2,:))
hold on
scatter(x1(1,:), x1(2,:))

axis([(min(bounds(1,:))-1) (max(bounds(1,:))+1) (min(bounds(2,:))-1) (max(bounds(2,:))+1)])

