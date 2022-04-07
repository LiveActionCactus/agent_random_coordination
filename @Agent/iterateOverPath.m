function iterateOverPath(obj)
%ITERATEOVERPATH use time step, agent start point, and endpoint to
%determine position

    x_n = [1; 1];
    x_ang = ([cos(obj.head_ang); sin(obj.head_ang)] .* x_n);        % normalized vector w/ heading angle
    obj.x = obj.x_o + (obj.sim_env.n .* obj.T .* x_ang);

end