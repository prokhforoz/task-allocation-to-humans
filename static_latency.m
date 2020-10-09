%task allocation in static queue with latency penalty

landa=1*ones(1,N);
alpha=0.9;
x=sdpvar(M,N);
a=sdpvar(M,N);

for k=1:50
 alpha=alpha*0.8;
k
for m=1:M
    
    SUM=0;
for n=1:N
    SUM=SUM+W(n)*a(m,n)/(1+exp(-(b(m,n)*x(m,n)/a(m,n))+d(m,n)));
end

S1=0;
for n=1:N
    S1=landa(1,n)*a(m,n)+S1;
end

penalty=0;

for n=1:N
    penalty=penalty+sum(C(n:N))*x(m,n);
end

objective=-log(SUM-penalty)-S1;
ops=sdpsettings('solver','bmibnb');

optimize([sum(x(m,:))<=T,x(m,:)>=0,a(m,:)<=1,a(m,:)>=0],objective,ops);


for n=1:N
X(m,n,k)=value(x(m,n))/value(a(m,n));
A(m,n,k)=value(a(m,n));
end
end

for n=1:N
    landa(1,n)=landa(1,n)-alpha*(sum(value(a(1:M,n)))-1);
end
end

%compute task allocation as a binary variable
for m=1:M

for n=1:N
    
    f(m,n)=W(n)*[(1+exp(-(b(m,n)*X(m,n,k))+d(m,n)))-(b(m,n)*X(m,n,k))*exp(-(b(m,n)*X(m,n,k))+d(m,n))]/(1+exp(-(b(m,n)*X(m,n,k))+d(m,n)))^2;
    R(m,n)=f(m,n);

end
end
for n=1:N
    [bb,cc]=max(R(:,n));
    for m=1:M
        if m==cc
    A1(m,n)=1;
        else
            A1(m,n)=0;
        end
    end
    
end

%compute time allocation

for m=1:M
    
    SUM=0;
    
for n=1:N
    SUM=SUM+W(n)*A1(m,n)/(1+exp(-(b(m,n)*x(m,n))+d(m,n)));
end


penalty=0;

for n=1:N
    penalty=penalty+sum(C(n:N))*A1(m,n)*x(m,n);
end


objective=-log(SUM-penalty);
ops=sdpsettings('solver','bmibnb');

EQ=[];
for n=1:N
    EQ=[EQ,x(m,n)<=A1(m,n)*T];
end

optimize([sum(x(m,:))==T,x(m,:)>=0,EQ],objective,ops);

for n=1:N
   X1(m,n)=value(x(m,n));
end
end
 
bar(X1(1,:),'barwidth',0.4,'FaceColor',[0.2 0.2 0.5]);
hold on
bar(X1(2,:),'barwidth',0.4,'FaceColor',[0 0.5 0]);
bar(X1(3,:),'barwidth',0.4,'FaceColor',[0.5 0 0.5]);
bar(X1(4,:),'barwidth',0.4,'FaceColor',[0.5 0.5 0.5]);


xlabel('Task number','FontSize',12)
ylabel('Time allocation','FontSize',12)

set(gca,'fontsize', 11)
legend('1','2','3','4')
    



    



