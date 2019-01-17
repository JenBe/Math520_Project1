% Jenny Be Hw 1 problem 1: LU factorization of nxn matrix
% Input: K = nxn band matrix, p = lower bandwidth, q = upper bandwidth
% Output: K overwritten where L is lower triangle with 1 in the main diagonal
%                             U is upper triangle with main diagonal

function [K] = bandLU(K,p,q)
n=size(K,2);
for m=1:(n-1)
    for i=(m+1):min(m+p,n)
        K(i,m)= K(i,m)/K(m,m);
    end
  
    for j=(m+1):min(m+q,n)
        for i=(m+1):min(m+p,n)
            K(i,j)=K(i,j)-K(i,m)*K(m,j);
        end
    end
end