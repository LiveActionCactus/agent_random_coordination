function plotRenStochMat(obj)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    rs_trees_int = {};
    rs_trees = [];
    
    for i = 1:obj.sim_env.sim_itrs
       rs_trees_int{1,i} = cat(1, obj.sim_env.sim_itrs_data{5,i}.ren_stoch_mat{1,:});
       rs_trees(i,:) = cat(1, rs_trees_int{1,i}(1:5));
    end
    
    assignin('base', 'rs_trees', rs_trees_int)
    assignin('base', 'rs_trees', rs_trees)
    
    figure()
    hold on

    subplot(2,2,1)
    hist(rs_trees(:,1), 60)
    xlabel("Sim steps")
    ylabel("Occurances")
    title("Sim steps to 1st spanning tree")

    subplot(2,2,2)
    hist(rs_trees(:,2), 60)
    xlabel("Sim steps")
    ylabel("Occurances")
    title("Sim steps to 2nd spanning tree")

    subplot(2,2,3)
    hist(rs_trees(:,3), 60)
    xlabel("Sim steps")
    ylabel("Occurances")
    title("Sim steps to 3rd spanning tree")

    subplot(2,2,4)
    hist(rs_trees(:,4), 60)
    xlabel("Sim steps")
    ylabel("Occurances")
    title("Sim steps to 4th spanning tree")

end % end plotRenStochMat()