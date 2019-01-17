%Jenny Be Hw 1 problem 3: backward substitution of Uw=f
% Input:  U =  nxn upper triangular matrix, f = column vector, q = upper bandwidth
% Output: w = column vector

function [w] = bandbackward(U,f,q)
n=length(f);
w(n)=f(n)/U(n,n);
for i=(n-1):-1:1
    s=0; %sum= 0 for each iteration i
    for j=(i+1):min(i+q,n)
         s= s+ U(i,j)*w(j); %sum of U*found w
   end
    w(i)= (f(i)-s)/U(i,i);
end
w=w';