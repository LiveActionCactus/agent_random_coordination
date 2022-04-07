%% Simple Communication at Opportunity Sim
% By: Patrick Ledzian
% Date: 23 March 2022

% Algorithm Outline
% - [DONE] initialize agents w/ initial positions
% - [DONE] initialize heading w/ test for feasability
% - [DONE] iterate all paths simultaneously in nT
% -- generate distance matrix from vector of agent positions
% --- check for sufficient closeness
% ---- if close populate graph nodes and edges
% -- [DONE] check if inside bounding box
% --- [DONE] if not, assign new random heading
% 

% TODO: approx 1 in 5k times the agent path will leave boundaries...

% Version 2.0
% track the adjacent quadrants of each agent (function of communication
% distance) and only perform 2-norm calculations between agents in the
% adjacent quadrants. Will need to discretize the map. This may run faster
% for a large number of agents.

%% Run the simulation

clear all
close all


%% Run the simulation
clc
close all

rounding = 0.1;
testSim = MultiAgentSim(4, 100, 10000);     % n agents; steps in sim; num sims

testSim.runSim(1);                  % plot agent paths (1/0; yes/no)

disp('Done')

%% Test simulation modules

%n = 10000;                     % number of times to run sim
%bounds = [0 20; 0 20];         % vertices of the simulation space
% %checkInitPosGen(n, bounds, rounding);    % sim iterations, convex polygon vertices, 
%checkHeadAngGen(n, rounding);


