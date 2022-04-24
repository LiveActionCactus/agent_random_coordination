%% Communication at Opportunity Sim -- Square Boundary Analysis
% By: Patrick Ledzian
% Date: 10 April 2022
% Last update: 24 April 2022

% Overview:
% Generate simulation data to provide insight as to how often agents
% interact when bouncing around in a closed, axis-aligned rectangle, as
% well as the relationship between the rectangular skew of the boundary
% (vs. a perfect square) and the random interactions between agents. 
% Each agent chooses a new random heading (uniform distribution [0, pi)])
% whenever it intersects with a boundary. Longer-term goal is to determine
% what conditions result in reliably connected communications graphs
% between agents, independent of agent starting position. As well as to
% determine how long agents must randomly interact before said
% communication graphs are connected. 
%

close all
clear all
clc

a = SimAnalysis();