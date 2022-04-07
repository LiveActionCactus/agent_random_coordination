function resetAgents(obj)
%RESETAGENTS reset agent properties to run sim again

    for i = 1:obj.numAgents
        obj.agents{1,i}.setInitialPos();
        obj.agents{1,i}.genHeadingAngle(0.1);
        obj.agents{1,i}.findEndpoint();
    end % end for each agent

end % end resetAgents