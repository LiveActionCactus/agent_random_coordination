% https://blogs.mathworks.com/loren/2008/06/11/interpolation-in-matlab/
% https://blogs.mathworks.com/loren/2008/07/17/interpolating-polynomials/
% https://stats.stackexchange.com/questions/29781/when-conducting-multiple-regression-when-should-you-center-your-predictor-varia
% 
%

%
% Seems like we have to use non-linear shapes for regression fitting when
% the model is monotone increasing. (monotonicity shape primative)

clear all
close all

%% Square vs Rectangular Boundaries vs. No communication probability

xgen_square = [100, 400, 1600, 6400];
ygen_square = [0.887, 0.96, 0.9925, 0.9975];

xgen_rect = [100, 200, 400, 800, 1600];
ygen_rect = [0.887, 0.949, 0.96, 0.9855, 0.992];

x_rect = [100, 400, 800, 1600];
y_rect = [0.887, 0.96, 0.9855, 0.992];

x = xgen_square;

% Exponential fit for square boundary results 
a1 = 0.9912;
b1 = 9.911e-07;
c1 = -0.1553;
d1 = -0.003982;

y1 = a1.*exp(b1.*x) + c1.*exp(d1.*x);

x1ev = linspace(0,6500,13000);
y1ev = a1.*exp(b1.*x1ev) + c1.*exp(d1.*x1ev);

% Exponential fit for rectangular boundary results
x = xgen_rect;
xm = x_rect;

a2 = 0.9918;
b2 = 2.962e-07;
c2 = -0.1558;
d2 = -0.003964;

y2 = a2.*exp(b2.*xm) + c2.*exp(d2.*xm);

x2ev = linspace(0,6500,13000);
y2ev = a2.*exp(b2.*x2ev) + c2.*exp(d2.*x2ev);


figure()
subplot(2,2,1)
plot(xgen_square, ygen_square, 'b', xgen_square, y1, 'ro', x1ev, y1ev, 'r')
xlabel("Boundary area")
ylabel("Probability of no communication")
title("Square boundaries")

subplot(2,2,2)
plot(xgen_rect, ygen_rect, 'm', xm, y2, 'go', x2ev, y2ev, 'g')
xlabel("Boundary area")
ylabel("Probability of no communication")
title("Rectangular boundaries")

subplot(2,2,[3 4])
plot(x1ev, y1ev, 'r', x2ev, y2ev, 'g')
legend('Square', 'Rect')

xlabel("Boundary area")
ylabel("Probability of no communication")
title("Fitted no communication trend vs Boundary area")

%% Square vs Rectangular Boundaries vs. Ave steps in communication

xgen_square = [100, 400, 1600, 6400];
ygen_square = [22.42, 6.64, 1.935, 0.57];

xgen_rect = [100, 200, 400, 1600];
ygen_rect = [12.245, 6.64, 3.59, 1.90];

x = xgen_square;

% Exponential fit for square boundary results 
a1 = 33.22;
b1 = -0.005276;
c1 = 2.894;
d1 = -0.0002539;

y1 = a1.*exp(b1.*x) + c1.*exp(d1.*x);

x1ev = linspace(0,6500,13000);
y1ev = a1.*exp(b1.*x1ev) + c1.*exp(d1.*x1ev);

% Exponential fit for rectangular boundary results
x = xgen_rect;

a2 = 23.39;
b2 = -0.009923;
c2 = 3.735;
d2 = -0.0004208;

y2 = a2.*exp(b2.*x) + c2.*exp(d2.*x);

x2ev = linspace(0,6500,13000);
y2ev = a2.*exp(b2.*x2ev) + c2.*exp(d2.*x2ev);

figure()
subplot(2,2,1)
plot(xgen_square, ygen_square, 'b', xgen_square, y1, 'ro', x1ev, y1ev, 'r')
xlabel("Boundary area")
ylabel("Ave step in communication")
title("Square boundaries")

subplot(2,2,2)
plot(xgen_rect, ygen_rect, 'm', x, y2, 'go', x2ev, y2ev, 'g')
xlabel("Boundary area")
ylabel("Ave step in communication")
title("Rectangular boundaries")

subplot(2,2,[3 4])
plot(x1ev, y1ev, 'r', x2ev, y2ev, 'g')
legend('Square', 'Rect')

xlabel("Boundary area")
ylabel("Ave step in communication")
title("Fitted ave steps with comms trend vs Boundary area")