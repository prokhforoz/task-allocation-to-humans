clear all
%initial condition for static queue

%Number of tasks
N=15;

%Number of human operator
M=4;

%Importance weight of tasks
W=[20;12;15;3;10;7;8;2;10;20;12;13;5;10;16];

%Number of scheduling time for one working day
T=10;

%Human operators performance parameters:

b=[1 2 4 1 10 6 5 6 7 8 5 6 7 1 3;6 7 10 2 5 6 7 1 2 8 6 1 7 3 4;...
    1 2 5 4 1 3 2 5 1 9 6 7 8 4 2;1 4 5 2 7 1 8 2 9 1 7 2 7 4 3];


d=[1 2 7 1 2 4 2 7 1 7 8 2 3 5 9;7 10 6 4 3 6 7 5 1 5 5 8 2 3 4;...
    10 2 4 7 1 2 4 6 1 8 3 2 5 1 6;7 6 2 1 3 2 7 1 6 7 2 1 8 1 2];


%penalty coefficient
C=0.0001*[10; 9; 4; 6; 7; 1; 4; 10; 8; 6; 1; 2; 1; 2; 1];

%probability for dynmaic queue
p=[0.2,0.2,0.2,0.2,0.2];

%number of types of tasks
J=5;

%rate of arriving tasks
landa=1.5;

w=1*[20 10 5 4 1;1 2 1 5 8;2 4 5 8 9;9 8 7 3 5;4 8 2 9 7; 6 10 4 7 9;1 4 8 9 3;5 8 5 9 5;1 4 7 1 4;...
    7 8 20 10 2;1 8 9 4 7;2 6 8 7 1; 9 8 2 5 6; 7 8 9 3 6;1 4 8 9 2];
c=[10 5 4 1 7; 9 7 9 2 1; 4 2 1 2 3; 6 5 2 1 2; 7 7 6 2 1; 1 9 8 6 7; 4 7 6 5 8; 10 9 8 6 7; 8 9 8 1 2;...
    6 7 6 5 3 ; 1 8 7 6 5; 2 8 7 9 6; 1 6 2 5 4; 2 3 2 6 7; 1 6 8 9 6]*10^-4;
