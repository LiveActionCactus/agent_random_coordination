classdef SimPlotting < handle
    %SIMPLOTTING creates an object that handles the plotting of simulation
    %data. Simulation data can be either local to a specific agent or
    %pertaining to the simulation at a more global scope.

    %
    % TODO:
    % 1) figure out what to do with "plotSimStepDistanceComms"
    %
    
    properties
        sim_env = NaN;          % handle to simulation environment object all agents live and data is stored

    end

    methods
        function obj = SimPlotting(sim_env)
            % SIMPLOTTING constructor for plotting object, specifies 
            % simulation env to access data from
            %
            % --Inputs--
            % sim_env : points to simulation environment object
            %
            % --Outputs--
            % obj : plotting object
            %

            obj.sim_env = sim_env;              % simulation environment with all data for plotting

        end % end SimPlotting constructor

        plotAgentPaths(obj, num_plots, labels);       % plot agent paths in sim env
        plotRenStochMat(obj);
    end

end % SIMPLOTTING