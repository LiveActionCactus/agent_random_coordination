classdef MultiAgentSim < handle
    %MULTIAGENTSIM creates a simulation environment and enforces rules
    %for living within the environment. Instantiates N agents inside the 
    %env and runs a simulation of them.
    
    %% To help limit numerical issues:
    % ALL ANGLES ROUNDED TO 0.1 RADIANS; ALL POSITIONS TO 0.01
    %

    %% References 
    % https://www.mathworks.com/help/matlab/matlab_oop/class-constructor-methods.html
    % https://gamemath.com/book/geomtests.html#closest_point_aabb

    % TODO:
    % 1) add in conservation of movement in agent reflections off
    % boundaries; not the current crude estimation

    properties
        boundary = [0 10; 0 10];  % matrix defining axis-aligned simulation boundaries;
        initial_posns = [];       % initial position of agents
        numAgents = NaN;          % number of agents in simulation; only supports a priori knowledge of this
        agents = {};              % 1xN array of agent objects
        n = NaN;                  % current simulation time step
        N = NaN;                  % total steps in simulation
        sim_itrs = NaN;           % number of simulations to run if multi-starting the sim; use to gain meta-data
        sim_itrs_data = struct();    % TODO: each sim iteration should have its complete data stored by the simulation instance. A plotting class can act on it later
        plotting = NaN;           % object of SimPlotting class
        comms = NaN;              % object of Comms class

    end % properties

    methods
        function obj = MultiAgentSim(numAgents, N, sim_itrs)
            % MULTIAGENTSIM constructor for simulation environment.
            % Initializes sim properties and number of agents in the env.
            %
            % --Inputs--
            % numAgents : number of agents to initialize in sim env 
            % N : total number of steps to run in simulation
            % sim_itrs : number of times to re-run simulation
            %
            % --Outputs--
            % obj : object of simulation environment
            %

            if numAgents == 0
                error("No agents in simulation!");
            end
            
            obj.n = 1;                          % initialize first simulation index to 1
            obj.N = N;                          % set max sim steps / indices
            obj.sim_itrs = sim_itrs;
            obj.numAgents = numAgents;
            obj.initializeAgents();             % stores Agent objects to first row of obj.agents
            obj.initializePlotting();           % creates SimPlotting object
            obj.initializeComms();              % creates Comms object
        
        end % end MultiAgentSim constructor
        
        initializeAgents(obj);
        initializePlotting(obj);
        resetAgents(obj);
        runSim(obj);
        storeAgentData(obj, i);
        plotSimStepDistanceComms(obj);           % TODO: put into communications class (or remove?)

    end % end methods
    
    methods(Static)
        init_pos = squareInitPos(bounds, rounding);         % generates initial position for agent on perimeter of convex polygon
        side = findConvexSide(sides, curr_ang);             % finds intersection side for convex polygon

    end % Static methods
end % classdef