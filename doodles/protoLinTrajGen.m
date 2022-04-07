clear all
close all
clc

x_n = [1; 1];    % define unit vector

head_ang = 2.4; %0.4; %4.200;
x_o = [20; 14]; %[14; 20];

% p, r, t -- all agent parameters
r = ([cos(head_ang); sin(head_ang)] .* x_n);  % rotated unit vector 
p = x_o; % shift the unit vector to agent position

% q, u, s -- boundary segment for intersection
b1 = [20; 20];
b2 = [0; 20];
q = b1;
s = b2 - b1;

% v x w = v_x w_y - v_y w_x
deno = ( r(1,1) * s(2,1) ) - ( r(2,1) * s(1,1) );

t_temp1 = (q-p);
t_temp2 = ( t_temp1(1,1) * s(2,1) ) - ( t_temp1(2,1) * s(1,1) ); 
t = t_temp2 ./ deno;

u_temp1 = q-p;
u_temp2 = ( u_temp1(1,1) * r(2,1) ) - ( u_temp1(2,1) * r(1,1) ); 
u = u_temp2 ./ deno;

x1 = p + (t .* r);
x2 = q + (u .* s);
