classdef Comms < handle
    %COMMS tracks and updates agent-agent communications at both the local
    %(Agent) level and global (SimEnv) level

    properties
        sim_env = NaN
        comms_data = struct();    % skeleton of comms data struct, built out in constructor

    end % end properties

    methods
        function obj = Comms(sim_env)
            %COMMS constructor for communications object
            %
            % --Inputs--
            % sim_env : simulation environment housing sim data and Agents
            %
            % --Outputs--
            % obj : object of Comms class
            %

            obj.sim_env = sim_env;
            obj.comms_data.adj_mat   = cell(1,obj.sim_env.N);
            obj.comms_data.deg_mat   = cell(1,obj.sim_env.N);
            obj.comms_data.udist_mat = cell(1,obj.sim_env.N);

        end % end Comms constructor

        initializeComms(obj);
        undirectedCommsUpdate(obj, itr);
        calcRenStochConv(obj, itr);
    
    end
end