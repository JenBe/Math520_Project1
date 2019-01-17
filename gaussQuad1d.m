%Jenny Be Hw6 Problem 3:
% Using Gaussian quadrature function (in HW6 Problem 2) to evaluate the
% integrals - needs gaussQuadStd1d.m file
%Note: needs file gaussQuadStd1d.m to run
%Input: fn= function_handle, lowerLimit/upperLimit= integration limits,
%noOfIntegPt= either 2 or 3 for 2/3 Gaussian quadrature 
%Output: y= double number

function [y] = gaussQuad1d(fn,lowerLimit,upperLimit,noOfIntegPt)
a=lowerLimit; b=upperLimit;
if noOfIntegPt==2 || noOfIntegPt==3
%change of variables   
    nv=@(z) b+((b-a)./2).*(z-1);
    %new function with that change of variables
    cov= @(z) fn(nv(z));
    %Gaussian Quadrature for the integral
    y=((b-a)./2).*gaussQuadStd1d(cov,noOfIntegPt);
else
    fprintf('noOfIntegPt needs to be 2 or 3')
end 