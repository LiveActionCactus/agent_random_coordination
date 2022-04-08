function runSim(obj, plot_paths, gen_sim_step_dist, gen_total_sim_dist, plot_sim_step_distance)
%RUNSIM run one time-step of the simulation

    plot_freq = 1000;           % modulus base for print/plot frequency

    % run iteration in the multi-start monte-carlo simulations
    for i = 1:obj.sim_itrs
        
        % run steps in a single simulation
        for n = 1:obj.N
            obj.n = n;
            
            for k = 1:obj.numAgents
                obj.agents{1,k}.runAgent(i)
            end
    
            % Generate distance matrix for each step of the sim
            if gen_sim_step_dist
                obj.genSimStepDistanceMatrix(n);
            end
       
        end % end for step in sim size

        if plot_sim_step_distance && gen_sim_step_dist
            obj.plotSimStepDistanceComms();
        end

        % Generate distance matrix for each iteration of the multi-start
        % case of the simulation
        if gen_total_sim_dist
            obj.genTotalSimDistanceMatrix(i)
            obj.sim_conn_data{2,1} = sum(cat(3,obj.sim_conn_data{:}),3) ./ obj.sim_itrs;
        end

        % Plot agent paths every i-th iteration of the multi-start case for
        % the simulation
        if mod(i,plot_freq) == 0
            fprintf("Sim %i Complete \n", i)

            if plot_paths
                obj.plotAgentPaths(i);     % plot every n-th sim
            end
        
        end % end if every mod-th sim run

        obj.resetAgents();          % reset Agent properties for simulation restartS
    
    end % end "sim_itrs"-times multi-start simulations

end % end runSim