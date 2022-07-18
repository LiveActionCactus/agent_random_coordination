classdef Agent < handle
    %AGENT creates object of a single agent and tracks information local 
    %to that agent throughout the simulation

    %% References
    % https://www.mathworks.com/company/newsletters/articles/introduction-to-object-oriented-programming-in-matlab.html
    % https://www.mathworks.com/help/matlab/matlab_oop/methods-in-separate-files.html#:~:text=To%20define%20a%20method%20in,name%2C%20as%20with%20any%20function.
    % https://mrl.cs.nyu.edu/~dzorin/rendering/lectures/lecture2/sld017.htm

    properties
        sim_env = NaN;       % handle to simulation environment object all agents live in       
        id = NaN;            % integer id of each agent (1, inf)        
        comms = struct( ...
            'dist', 2.0, ...    % communication radius
            'in_comm', NaN ...  % container.Map; 1 -- in comms, 0 -- not
            )
        traj = struct( ...    % struct storing information req'd for trajectory
            'T', NaN, ...     % discretization time step size (t -> nT)
            'x_o', [], ...    % initial position (on boundary of surveillance region)
            'x_e', [], ...    % end point for trajectory
            'side_o', NaN ... % starting side; for single trajectory segment
            );  
        state = NaN;         % array storing current agent state [heading; x; y]
        est_state = NaN;     % array storing estmated information
        state_log = NaN;     % array logging all previous state information
        est_state_log = NaN; % array logging all previous est state info

    end % properties

    methods
        function obj = Agent(sim_env, id)
            % AGENT constructor for agent object, specifies simulation env
            % where agent lives and the id of the agent
            %
            % --Inputs--
            % sim_env : points to simulation environment object
            % id : integer value unique to each agent
            %
            % --Outputs--
            % obj : object of a single agent
            %

            obj.sim_env = sim_env;
            obj.id = id;
            obj.traj.T = 1.0;               % default time-step
            obj.state = zeros(3, 1);
            obj.state_log = zeros(3, obj.sim_env.sim_itrs);

            obj.setInitialEst();
            obj.setInitialPos();
            obj.genHeadingAngle(0.1);
            obj.findEndpoint();
        
        end % end Agent constructor

        setInitialEst(obj);                   % initializes information to be estimated
        setInitialPos(obj);                   % initializes agent on boundary, sets x_o and x
        genHeadingAngle(obj, rounding);       % generates new random heading angle for agent, sets head_ang property of Agent object
        findEndpoint(obj);                    % uses agent position and random heading to find endpoint of linear trajectory, sets x_e
        runAgent(obj, sim_itr);               % updates agent dynamics / behaviors based on simulation iteration
        
    end % methods
end % class