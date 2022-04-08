classdef MultiAgentSim < handle
    %MULTIAGENTSIM runs the simulation of n agents within a specified
    %region

    %
    % ALL ANGLES ROUNDED TO 0.1 RADIANS; ALL POSITIONS TO 0.01
    %

    % https://www.mathworks.com/help/matlab/matlab_oop/class-constructor-methods.html
    % https://gamemath.com/book/geomtests.html#closest_point_aabb

    %
    % TODO: generalize constructor for convex vertices (bounds) argument
    %

    properties
        %boundary = [0 20; 0 20];  % matrix defining agent boundaries
        boundary = [0 100; 0 100];  % matrix defining agent boundaries
        initial_posns = [];       % initial position of gliders, may be blank
        numAgents = NaN;
        agents = {};              % array of agent objects
        n = NaN;                  % simulation time step
        N = NaN;                  % total steps in simulation (sim size)
        sim_itrs = NaN;           % number of simulations to run
        sim_conn_data = {};       % stored adjacency matrices inidicating comms connections
    
    end % properties

    methods
        function obj = MultiAgentSim(numAgents, N, sim_itrs)
            if numAgents == 0
                error("No agents in simulation!");
            end
            
            obj.n = 1;                          % initialize first time index to 1
            obj.N = N;                          % set max sim duration
            obj.sim_itrs = sim_itrs;
            obj.numAgents = numAgents;
            obj.initializeAgents();             % writes Agent objects to first row of obj.agents
            obj.initializeLogging();            % writes 3xN zero-array to second row of obj.agents
        
        end % end MultiAgentSim constructor
        
        initializeAgents(obj);
        initializeLogging(obj);
        resetAgents(obj);
        runSim(obj, plot_paths, gen_sim_step_dist, gen_total_sim_dist, plot_sim_step_distance);
        genSimStepDistanceMatrix(obj, sim_step);
        genTotalSimDistanceMatrix(obj, sim_itr);
        plotAgentPaths(obj, sim_itr);
        plotSimStepDistanceComms(obj)

    end % end methods
    
    methods(Static)
        init_pos = squareInitPos(bounds, rounding);         % generates initial position for agent on perimeter of convex polygon
        side = findConvexSide(sides, curr_ang);             % finds intersection side for convex polygon

    end % Static methods
end % classdef