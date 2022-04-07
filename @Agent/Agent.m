classdef Agent < handle
    %Agent creates single agent, tracks data throughout
    %simulation

    % https://www.mathworks.com/company/newsletters/articles/introduction-to-object-oriented-programming-in-matlab.html
    % https://www.mathworks.com/help/matlab/matlab_oop/methods-in-separate-files.html#:~:text=To%20define%20a%20method%20in,name%2C%20as%20with%20any%20function.
    % https://mrl.cs.nyu.edu/~dzorin/rendering/lectures/lecture2/sld017.htm

    properties
        sim_env = NaN;       % handle to simulation environment all agents live in       
        id = NaN;            % integer id of each agent (1, inf)
        T = 1;               % discretization time step size (t -> nT)
        x_o = [];            % initial position (on boundary of surveillance region)
        side_o = NaN;        % starting side; for single trajectory segment
        x = [];              % current position
        x_e = [NaN; NaN];    % end point for trajectory
        head_ang = NaN;      % current heading angle [0 2*pi)
        
    end % properties

    methods
        function obj = Agent(sim_env, id)
            obj.sim_env = sim_env;
            obj.id = id;

            obj.setInitialPos();
            obj.genHeadingAngle(0.1);
            obj.findEndpoint();
        
            
        end % end Agent

        setInitialPos(obj)                    % initializes agent on boundary, sets x_o and x
        genHeadingAngle(obj, rounding);       % generates new random heading angle for agent, sets head_ang
        findEndpoint(obj);                    % uses agent position and random heading to find endpoint of linear trajectory, sets x_e
        iterateOverPath(obj);                 % uses start point and endpoint to define path
        runAgent(obj, sim_itr);
        
    end % methods
end % class