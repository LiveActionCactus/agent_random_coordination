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
        T = 1.0;             % discretization time step size (t -> nT)
        x_o = [];            % initial position (on boundary of surveillance region)
        side_o = NaN;        % starting side; for single trajectory segment
        x = [];              % current position
        x_e = [NaN; NaN];    % end point for trajectory
        head_ang = NaN;      % current heading angle [0 2*pi)
        comm_dist = 2;       % communication radius
        state = NaN;             % TODO: use this instead of obj.agents; stores history of agent states; agents will also store local map and local comms perspective
        
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
            obj.state = zeros(3, obj.sim_env.sim_itrs);

            obj.setInitialPos();
            obj.genHeadingAngle(0.1);
            obj.findEndpoint();
        
            
        end % end Agent constructor

        setInitialPos(obj)                    % initializes agent on boundary, sets x_o and x
        genHeadingAngle(obj, rounding);       % generates new random heading angle for agent, sets head_ang property of Agent object
        findEndpoint(obj);                    % uses agent position and random heading to find endpoint of linear trajectory, sets x_e
        runAgent(obj, sim_itr);               % updates agent dynamics / behaviors based on simulation iteration
        
    end % methods
end % class