function runAgent(obj, sim_itr)
%RUNAGENT run one time step of the agent, updates all pertinent object
%properties
%
% --Inputs--
% obj : agent object
% sim_itr : simulation iteration / sim step
%
% --Outputs--
% (None) : updates agent properties according to itr step, when applicable
%

% https://stackoverflow.com/questions/18295825/determine-if-point-is-within-bounding-box
    
    x = obj.state; %[obj.head_ang; obj.x];
    obj.state_log(1:3, sim_itr) = x;  % store previous state info

    bounds = obj.sim_env.boundary;
    x_n = [1;1];
    x_new = x(2:3, 1) + ([cos(x(1,1)); sin(x(1,1))] .* x_n);
    x_new = round(x_new, 2);                    % enforce precision requirements for numerical issues
    
    if bounds(1,1) <= x_new(1,1) && x_new(1,1) <= bounds(1,2) && bounds(2,1) <= x_new(2,1) && x_new(2,1) <= bounds(2,2)
        obj.state(2:3, 1) = x_new;
    else
        % TODO: carry distance information through the reflection off
        % boundary instead of cutting traj off
        obj.state(2:3, 1) = obj.traj.x_e;                        
        obj.traj.x_o = obj.traj.x_e;
        if isempty(x)
            error('x empty')
        end
        obj.genHeadingAngle(0.1);
        obj.findEndpoint();

    end % if inside bounds

end % end runAgent