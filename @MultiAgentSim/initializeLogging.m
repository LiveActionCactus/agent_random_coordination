function initializeLogging(obj)
%INITIALIZELOGGING set simulation properties for logging agent behavior

for l = 1:obj.numAgents
    obj.agents{2,l} = zeros(3,obj.N);       % row 1: heading; row 2: x-pos; row 3: y-pos
end