%% Core Multi-Agent Simulation Functionality
% This is the jumping off point for testing core classes and functions
%
% By: Patrick Ledzian
% Created: 13 July 2022
% Last edit: 17 July 2022

%% TODO
% -1) double check paper to make sure Ren is implemented correctly
% (spanning tree calculation)
% 0) fit spanning tree distributions to math
% 1) pretty up the state average consensus dynamics plots
% 2) write-up results!
% 3) build "flags" struct that can be passed as arg to MultiAgentSim to
% specify actions to take
% 4) implement 2-D map that each agent holds
% 5) implement value iteration / DP over the map

%% Run the simulation

close all
clear all
clc

% TODO: build "flags" struct that can be passed as arg to MultiAgentSim to
% specify actions to take

testSim = MultiAgentSim(4, 500, 5000);     % n agents; steps in sim; num sims
testSim.runSim();
testSim.plotting.plotAgentPaths(1, 1);     % num_plots; labels
testSim.plotting.plotRenStochMat();

disp('Done')


