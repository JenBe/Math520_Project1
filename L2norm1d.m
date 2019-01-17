%Jenny Be Hw 7 Problem 3
%find the L2 norm of a function
%note: need gaussQuad1d.m to run
%Input: f = function_handle, a,b = left and right endpoint of the domain,
%noOfEle = # of subintervals for calculating L2 norm using GQ w/3
%integration points
%Output: y= L2 norm of a one variable L2- function

function [y] = L2norm1d(f,a,b,noOfEle)
h=(b-a)./noOfEle; %creating stepsize
xh=[a:h:b]; % creating vector with equal stepsize for each nodes
sum=0;
f2=@(x) f(x)*f(x);

for i=1:noOfEle
    E=gaussQuad1d(f2,xh(i),xh(i+1),3); %integral for each element
    sum=sum+E; %adding the integrals
end
y=sqrt(sum);