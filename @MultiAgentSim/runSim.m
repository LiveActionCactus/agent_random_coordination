function runSim(obj, plot_paths)
%RUNSIM run one time-step of the simulation

    freq = 1000;               % modulus base for print/plot frequency
    for i = 1:obj.sim_itrs
        
        for n = 1:obj.N
            obj.n = n;
            
            for k = 1:obj.numAgents
                obj.agents{1,k}.runAgent(i)
            end
    
            if n >= obj.N
                if mod(i,freq) == 0
                    fprintf("Sim %i Complete \n", i)

                    if plot_paths
                        obj.plotAgentPaths(i);     % plot every n-th sim
                    end
                
                end % end if every 10-th sim run

            end % end if sim complete
        
        end % end for step in sim size

        obj.resetAgents();
    
    end % end "sim_itrs"-times multi-start simulations

end % end runSim