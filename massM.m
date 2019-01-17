%Jenny Be Hw 7 Problem 2a
%constructs the global consistent mass matrix M
%Note: needs meij.m to run
%Input: xh = vector of nodes [x1,...,xn+1]; shapeFn= 1-linear shape
%function, 2- quadratic shape function, noOfIntegPt=# of integration points
%Output: M = sparse matrix for mass

function [M] = massM(xh, shapeFn, noOfIntegPt)
n = length(xh)-1;

%linear shape function
if shapeFn==1
    M=sparse(n,n); %makes matrix
    %get elements
    for e=1:n-1 
       M(e,e)=meij(e,2,2,xh,shapeFn,noOfIntegPt)+meij(e+1,1,1,xh,shapeFn,noOfIntegPt);
       M(e,e+1)=meij(e+1,1,2,xh,shapeFn,noOfIntegPt);
       M(e+1,e)=M(e,e+1);
    end
    M(n,n)=meij(n,2,2,xh,shapeFn,noOfIntegPt); %gets last element

%quadratic shape function
elseif shapeFn==2
    M=sparse(2*n,2*n); %make matrix
    %find elements for first two rows
    M(1,1)=meij(1,2,2,xh,shapeFn,noOfIntegPt);
    M(1,2)=meij(1,2,3,xh,shapeFn,noOfIntegPt);
    M(2,1)=M(1,2);
    M(2,2)=meij(1,3,3,xh,shapeFn,noOfIntegPt)+meij(2,1,1,xh,shapeFn,noOfIntegPt);
    M(2,3)=meij(2,1,2,xh,shapeFn,noOfIntegPt);
    M(2,4)=meij(2,1,3,xh,shapeFn,noOfIntegPt);
    
    %get elements in rows with 3 entries
    for e=3:2:2*n-1 
        for i=1:3
        M(e,e-2+i)=meij(((e-1)/2)+1, 2,i,xh,shapeFn,noOfIntegPt);
        end
    end
    
    %gets elements in rows with 5 entries
    for j=4:2:(2*n-2)
        M(j,j-2)=M(j-2,j);
        M(j,j-1)=M(j-1,j);
        M(j,j)=meij(j/2,3,3,xh,shapeFn,noOfIntegPt)+meij((j/2)+1,1,1,xh,shapeFn,noOfIntegPt);
        M(j,j+1)=meij((j/2)+1,1,2,xh,shapeFn,noOfIntegPt);
        M(j,j+2)=meij((j/2)+1,1,3,xh,shapeFn,noOfIntegPt);
    end
    %gets elements for row n
    for k=1:3
        M(2*n,e-2+k)=meij(((e-1)/2)+1, 3,k,xh,shapeFn,noOfIntegPt);
    end
else
    fprintf('shapeFn should be 1 or 2')
end 
