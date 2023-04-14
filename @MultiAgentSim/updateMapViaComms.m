function updateMapViaComms(obj, n)
%UPDATEMAPVIACOMMS union each agent's locally stored information map with
%all other agents currently in communication with it.

    % update map based off communications               % TODO: possibly redundant
    for i = 1:obj.numAgents
        if isequal(obj.agents{1,i}.comms.in_comm, 1)
            adj = obj.comms.comms_data.adj_mat{1,n};
            curr_map = obj.agents{1,i}.map.map{1,n};
            for j = 1:obj.numAgents
                if isequal(adj(i,j), 1)
                    rec_map = obj.agents{1,j}.map.map{1,n};  % map to be recieved via comms
                    curr_map = max(curr_map, rec_map);
                end
            end % end checking all agents for in comms

            obj.agents{1,i}.map.map{1,n} = curr_map;         % update agent's stored map         % TODO: make logging a fcn of sim step for plotting
        end % end is the agent in comms

        %obj.agents{1,i}.comms.in_comm = 0;              % agent is no
        %longer in comms // HANDLED IN UNDIRECTEDCOMMSUPDATE()
        
    end % end iterating over all agents

end