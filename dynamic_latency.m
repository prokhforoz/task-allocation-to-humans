%task allocation in static queue with latency penalty


N=15;
Landa=zeros(1,N,J);
alpha=0.9;
x=sdpvar(M,N,J);
a=sdpvar(M,N,J);
% SUM=zeros(5,1);
% penalty=zeros(5,1);

l1=0;
for m=1:M
    SUM=0;
  for n=1:N
    for j=1:J
    SUM=SUM+w(n,j)*p(j)*a(m,n,j)/(1+exp(-(b(m,n)*x(m,n,j)/a(m,n,j))-d(m,n)));
    end
  end
S(m)=SUM;
penalty=0;
for n=1:N
    for j=1:J
    penalty=penalty+p(j)*[c(n,j)*(l1-n+1)*x(m,n,j)+landa*x(m,n,j)*(-x(m,n,j))+x(m,n,j)^2/2];
    end
end
Penalty(m)=penalty;
end



for k=1:50
 alpha=alpha*0.8;
k
for m=1:M
  
    
    S1=0;
for n=1:N
    for j=1:J
    S1=Landa(1,n)*a(m,n,j)+S1;
    end
end

objective=-log(S(m)-Penalty(m))-S1;
ops=sdpsettings('solver','bmibnb');

eq=[];
for j=1:J
    eq=[eq,sum(x(m,:,j))==T];
end
optimize([eq,x(m,:,:)>=0,a(m,:,:)<=1,a(m,:,:)>=0],objective,ops);

for n=1:N
    for j=1:J
X(m,n,j,k)=value(x(m,n,j))/value(a(m,n,j));
A(m,n,j,k)=value(a(m,n,j));
    end
end

end
for n=1:N
    for j=1:J
    Landa(1,n,j)=Landa(1,n,j)-alpha*(sum(value(a(1:M,n,j)))-1);
    end
end
end

%compute task allocation as a binary variable
for m=1:M

for n=1:N
    for j=1:J
    f(m,n,j)=w(n,j)*[(1+exp(-(b(m,n)*X(m,n,j,k-1))-d(m,n)))-(b(m,n)*X(m,n,j,k-1))*exp(-(b(m,n)*X(m,n,j,k-1))-d(m,n))]/(1+exp(-(b(m,n)*X(m,n,j,k-1))-d(m,n)))^2;
    R(m,n,j)=f(m,n,j);

    end
end
end

for n=1:N
    for j=1:J
    [bb,cc]=max(R(:,n,j));
    for m=1:M
        if m==cc
    A1(m,n,j)=1;
        else
            A1(m,n,j)=0;
        end
    end
  end
    
end



%compute time allocation
for m=1:M
  SUM=0;
  for n=1:N
    for j=1:J
    SUM=SUM+w(n,j)*p(j)*A1(m,n,j)/(1+exp(-(b(m,n)*x(m,n,j)/A1(m,n,j))-d(m,n)));
    end
  end
S(m)=SUM;
penalty=0;
for n=1:N
    for j=1:J
    penalty=penalty+p(j)*[c(n,j)*(l1-n+1)*A1(m,n,j)*x(m,n,j)+landa*x(m,n,j)*A1(m,n,j)*(-x(m,n,j))+(A1(m,n,j)*x(m,n,j))^2/2];
    end
end
Penalty(m)=penalty;
end



for m=1:M
    
objective=-log(S(m)-Penalty(m));
ops=sdpsettings('solver','bmibnb');

EQ=[];
for n=1:N
    for j=1:J
    EQ=[EQ,x(m,n,j)<=A1(m,n,j)*T];
    end
end

eq=[];
for j=1:J
    eq=[eq,sum(x(m,:,j))==T,x(m,:,j)>=0];
end
optimize([eq,EQ],objective,ops);

for n=1:N
    for j=1:J
   X2(m,n,j)=value(x(m,n,j));
end
end
end




    



