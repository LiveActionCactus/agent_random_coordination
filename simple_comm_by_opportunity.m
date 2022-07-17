%% Core Multi-Agent Simulation Functionality
% This is the jumping off point for testing core classes and functions
%
% By: Patrick Ledzian
% Date: 13 July 2022

%% Run the simulation

close all
clear all
clc

testSim = MultiAgentSim(4, 20, 10);     % n agents; steps in sim; num sims
testSim.runSim();
testSim.plotting.plotAgentPaths(5);

disp('Done')


