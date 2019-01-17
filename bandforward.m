% Jenny Be Hw 2 problem 2: forward substitution for Lz=f
% Input: L = nxn lower triangular matrix, f = column vector, p = lower bandwidth
% Output: z = column vector 

function [z] = bandforward(L,f,p)
z(1)=f(1)/L(1,1); %z(1) doesnt need sum to find
n=length(f);
for i= 2:n
    s=0; %sum= 0 for each iteration i
   for j=max(i-p,1):(i-1)
       s= s+ L(i,j)*z(j); %creates new sum
   end
    z(i)= (f(i)-s)/L(i,i); 
end
z=z';