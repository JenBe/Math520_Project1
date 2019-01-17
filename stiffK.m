%Jenny Be Hw 7 Problem 2b
%Function to construct the stiffness matrix K
%Note: needs file keij.m to run
%Input: a/c = function handle in IBVP, xh = vector of nodes [x1,...,xn+1],
%shapeFn= 1-linear shape function, 2-quadratic shape function,
%noOfIntegPt= # of integration points
%Output: K = stiffness matrix K

function [K] = stiffK(a, c, xh, shapeFn, noOfIntegPt)
n = length(xh)-1;
%if shape function is linear
if shapeFn==1
    K=sparse(n,n);%make matrix
    for i=1:n-1
        K(i,i)=keij(a,c,i,2,2,xh,shapeFn,noOfIntegPt)+keij(a,c,i+1,1,1,xh,shapeFn,noOfIntegPt);
        K(i,i+1)=keij(a,c,i+1,1,2,xh,shapeFn,noOfIntegPt);
        K(i+1,i)=K(i,i+1);
    end
    K(n,n)=keij(a,c,n,2,2,xh,shapeFn,noOfIntegPt);

%if shape function is quadratic
elseif shapeFn==2
    K=sparse(2*n,2*n);
    %find elements for first two rows
    K(1,1)=keij(a,c,1,2,2,xh,shapeFn,noOfIntegPt);
    K(1,2)=keij(a,c,1,2,3,xh,shapeFn,noOfIntegPt);
    K(2,1)=K(1,2);
    K(2,2)=keij(a,c,1,3,3,xh,shapeFn,noOfIntegPt)+keij(a,c,2,1,1,xh,shapeFn,noOfIntegPt);
    K(2,3)=keij(a,c,2,1,2,xh,shapeFn,noOfIntegPt);
    K(2,4)=keij(a,c,2,1,3,xh,shapeFn,noOfIntegPt);
    
    %get elements in rows with 3 entries
    for e=3:2:2*n-1 
        for i=1:3
        K(e,e-2+i)=keij(a,c,((e-1)/2)+1, 2,i,xh,shapeFn,noOfIntegPt);
        end
    end
    
    %gets elements in rows with 5 entries
    for j=4:2:(2*n-2)
        K(j,j-2)=K(j-2,j);
        K(j,j-1)=K(j-1,j);
        K(j,j)=keij(a,c,j/2,3,3,xh,shapeFn,noOfIntegPt)+keij(a,c,(j/2)+1,1,1,xh,shapeFn,noOfIntegPt);
        K(j,j+1)=keij(a,c,(j/2)+1,1,2,xh,shapeFn,noOfIntegPt);
        K(j,j+2)=keij(a,c,(j/2)+1,1,3,xh,shapeFn,noOfIntegPt);
    end
    %gets elements for row n
    for k=1:3
        K(2*n,e-2+k)=keij(a,c,((e-1)/2)+1, 3,k,xh,shapeFn,noOfIntegPt);
    end
else 
    fprintf('shapeFn needs to be 1 or 2')
end