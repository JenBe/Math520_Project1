%Jenny Be Hw 7 Problem 2c
%Function to construct the load vector F
%note: need fei.m, shapeFn1d.m to run
%Input: a,c,f= function_handles for IBVP, p0 = # that indicates the Dirichlet BC for
%the solution u of the BVP at x=0, QL= # that represents the value of
%a(du/dn) at x=L, xh = vector that contains the nodes [x1,...,xn+1],
%shapeFn = 1-linear shapefunction/2-quadratic shapefunction, noOfIntegPt =
%#  of integration points used in Gaussian Quadrature
%Output: F = load vector

function [F] = loadF(a, c, f, p0, QL, xh, shapeFn, noOfIntegPt)
n=length(xh)-1;

%linear shape function
if shapeFn==1
    F=zeros(n,1); %make vector
    for e=1:n-1
        s=xh(e); t=xh(e+1); u=xh(e+2);
        F(e,1)=fei(a,c,f,p0,e,2,xh,1,noOfIntegPt)+fei(a,c,f,p0,e+1,1,xh,1,noOfIntegPt)+QL*shapeFn1d(2,t,s,t,1)-QL*shapeFn1d(1,t,t,u,1);
    end
    %gets last element
    F(n,1)=fei(a,c,f,p0,n,2,xh,1,noOfIntegPt)+QL*shapeFn1d(2,xh(n+1),xh(n),xh(n+1),1)-QL*shapeFn1d(2,xh(n),xh(n),xh(n+1),1);
    
%quadratic shape function
elseif shapeFn==2
    F=zeros(2*n,1); %make vector
    %get elements l2(e)
    for i=1:2:(2*n-1)
        e=(i+1)/2;
        s=xh(e); t=xh(e+1);
        F(i,1)=fei(a,c,f,p0,e,2,xh,2,noOfIntegPt)+QL*shapeFn1d(2,t,s,t,2)-QL*shapeFn1d(2,s,s,t,2);
    end
    %get elements l3(e)+l1(e+1)
    for j=2:2:(2*n-2)
        e=j/2;
        s=xh(e); t=xh(e+1); u=xh(e+2);
        F(j,1)=fei(a,c,f,p0,e,3,xh,2,noOfIntegPt)+QL*shapeFn1d(3,t,s,t,2)-QL*shapeFn1d(3,s,s,t,2)+fei(a,c,f,p0,e+1,1,xh,2,noOfIntegPt)+QL*shapeFn1d(1,u,t,u,2)-QL*shapeFn1d(1,t,t,u,2);
    end
    %gets last element
    F(2*n)=fei(a,c,f,p0,n,3,xh,2,noOfIntegPt)+QL*shapeFn1d(3,xh(n+1),xh(n),xh(n+1),2)-QL*shapeFn1d(3,xh(n),xh(n),xh(n+1),2);
else
    fprintf('shapeFn needs to be 1 or 2')
end