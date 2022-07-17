function runAgent(obj, sim_itr)
%RUNAGENT run one time step of the agent, updates all pertinent object
%properties
%
% --Inputs--
% obj : agent object
% sim_itr : simulation iteration / sim step
%
% --Outputs--
% (None) : updates agents referenced in sim object
%

% https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box
    
    obj.state(1:3, sim_itr) = [obj.head_ang; obj.x];  % store previous state info

    bounds = obj.sim_env.boundary;
    x_n = [1;1];
    x_new = obj.x + ([cos(obj.head_ang); sin(obj.head_ang)] .* x_n);
    x_new = round(x_new, 2);                    % enforce precision requirements for numerical issues
    
    if bounds(1,1) <= x_new(1,1) && x_new(1,1) <= bounds(1,2) && bounds(2,1) <= x_new(2,1) && x_new(2,1) <= bounds(2,2)
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