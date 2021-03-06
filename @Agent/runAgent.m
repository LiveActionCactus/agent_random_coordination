function runAgent(obj, sim_itr)
%RUNAGENT run one time step of the agent, updates all pertinent object
%properties

% https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box
    
    obj.sim_env.agents{(sim_itr+1), obj.id}(1, obj.sim_env.n) = obj.head_ang;
    obj.sim_env.agents{(sim_itr+1), obj.id}(2:3, obj.sim_env.n) = obj.x;

    bounds = obj.sim_env.boundary;
    x_n = [1;1];
    x_new = obj.x + ([cos(obj.head_ang); sin(obj.head_ang)] .* x_n);
    x_new = round(x_new, 2);                % enforce precision requirements for numerical issues
    
    % TODO: generalize for convex shapes
    [in_poly, on_poly] = inpolygon(x_new(1,1), x_new(2,1), bounds(1,:), bounds(2,:));
    if in_poly
        obj.x = x_new;
    else
        obj.x = obj.x_e;                        % causing a problem sometimes, leaving obj.x empty
        obj.x_o = obj.x_e;
        if isempty(obj.x)
            error('x empty')
        end
        obj.genHeadingAngle(0.1);
        obj.findEndpoint();

    end % if inside bounds

end % end runAgent