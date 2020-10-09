clear all
%initial condition for static queue

%Number of tasks
N=20;
%Number of human operator
M=4;

%Importance weight of tasks
W=abs(normrnd(10,2,N,1));

%Number of scheduling time for one working day
T=5;

%Human operators performance parameters:

for m=1:M
b(m,:)=abs(normrnd(7,2,N,1));
d(m,:)=abs(normrnd(2,1,N,1));
end


%penalty coefficient
C=0.2*abs(normrnd(0.1,1,N,1));

%probability for dynmaic queue
p=[0.25,0.25,0.25,0.25];

%number of types of tasks
J=4;
landa=4;

w=abs(normrnd(10,2,N,J));
c=0.01*abs(normrnd(10,2,N,J));

