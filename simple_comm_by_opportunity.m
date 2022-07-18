%% Core Multi-Agent Simulation Functionality
% This is the jumping off point for testing core classes and functions
%
% By: Patrick Ledzian
% Created: 13 July 2022
% Last edit: 17 July 2022

%% Run the simulation

close all
clear all
clc

testSim = MultiAgentSim(4, 500, 7000);     % n agents; steps in sim; num sims
testSim.runSim();
testSim.plotting.plotAgentPaths(5, 1);  % num_plots; labels
testSim.plotting.plotRenStochMat();

disp('Done')


