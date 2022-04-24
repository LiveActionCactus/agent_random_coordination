classdef SimAnalysis < handle
    %SimAnalysis perform different types of simulations and process the
    %results into reports

    % mathworks.com/matlabcentral/answers/101273-how-can-i-put-existing-figures-in-different-subplots-in-another-figure-in-matlab-6-5-r13

    properties
        test = 0;

    end

    methods
        function obj = SimAnalysis()
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            
        end

        function steadyStateCommProb(obj, bounds, numAgents, N, sim_itrs)
            %STEADYSTATECOMMPROB for specified number of agents and
            %boundary vertices for the convex covering generate total
            %response for communication probability

            %TODO: create figure handle for first arg plots
            %TODO: create variable for plot frequency, maybe call it
            %seperately from runSim, but require the variable to have
            %values
            sim = MultiAgentSim(bounds, numAgents, N, sim_itrs); 
            [ssd_plot, ssd_conn_data, itr_comm_plot, agent_path_plot] = sim.runSim(1,1,0,1);        % plot paths; plot agent single itr; plot agent multi-start; plot comms

            subplt = figure();
            tcl = tiledlayout(subplt, 2,1);
            p1 = gca(ssd_plot{1,1});
            p2 = gca(ssd_plot{1,2});
            p1.Parent = tcl;
            p1.Layout.Tile = 1;
            p2.Parent = tcl;
            p2.Layout.Tile = 2;

%             comm_steps = ssd_conn_data{1,1}(triu(true(sim.numAgents), 1))';
%             comm_prob = ssd_conn_data{1,2}(triu(true(sim.numAgents), 1))';
%             
%             figure()
%             subplot(1,2,1)
%             bar(comm_steps)
%             xlabel('Dist matrix idx')
%             ylabel('Number of steps in communication')
%             title(sprintf('Steps in communication \n vs \nAgent pairing'))
% 
%             subplot(1,2,2)
%             bar(comm_prob)
%             xlabel('Dist matrix idx')
%             ylabel('Prob of comm as fcn of sim step')
%             title(sprintf('Communication chance \n vs \n Agent pairing'))
            
        end % end steadyStateCommProb

        function multiStartData(obj, bounds, numAgents, N, sim_itrs)
            % produces data: itr_comm_plot
            sim = MultiAgentSim(bounds, numAgents, N, sim_itrs); 
            [ssd_plot, ssd_conn_data, itr_comm_plot, agent_path_plot] = sim.runSim(1,0,1,0);        % plot paths; plot agent single itr; plot agent multi-start; plot comms

            if ~isequal(agent_path_plot, 0)
                set(agent_path_plot, 'Visible', 'on')
            end

            subplt = figure();
            tcl = tiledlayout(subplt, 2,1);
            p1 = gca(itr_comm_plot{1,1});
            p2 = gca(itr_comm_plot{1,2});
            p1.Parent = tcl;
            p1.Layout.Tile = 1;
            p2.Parent = tcl;
            p2.Layout.Tile = 2;

            ave_comm = sim.sim_conn_data{2,1};
            ave_comm_flat = ave_comm(triu(true(sim.numAgents), 1))';
            
            figure()
            subplot(1,2,1)
            bar(ave_comm_flat)
            xlabel('Dist matrix idx')
            ylabel('Multi-start Ave. steps in communication')
            title( sprintf("Multi-start ave communication \n vs \n Agent pairing (n=" + sim.numAgents + "; itr=" + sim.sim_itrs + ")" ) )

            subplot(1,2,2)
            bar(sim.sim_conn_data{2,2})
            xlabel('Dist matrix idx')
            ylabel('Multi-start itrs with no comms')
            title( sprintf("Multi-start no communication \n vs \n Agent pairing (n=" + sim.numAgents + "; itr=" + sim.sim_itrs + ")" ) )

        end % end multiStartData
    
    end % ends methods

    methods(Static)
        function clearEmptyFigs()
            figs = get(groot, "Children");
            for f = 1:length(figs)
                if isempty(gca(figs(f)).Title.String)
                    close(figs(f))
                end
            end
        end

    end % end Static methods

end