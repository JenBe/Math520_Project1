%Jenny Be HW 7 Problem 1
%Calculate M(i,j) for the e-th element
%Note: need files shapeFn1d.m and gaussQuad1d.m to run
%Input: e-th element, ij= index, xh= vector that contains the nodes
%[x1,x2,...xn], shapeFn = number that represents the degree of shape
%functions to be used (1= linear,  2= quadratic), noOfIntegPt = number that
%indicates the number of integration points used in the Gaussian quadrature
%Output: value of M(i,j)of the  e-th element

function [y] = meij( e, i, j, xh, shapeFn, noOfIntegPt)
%set limits of integrations
a=xh(e);
b=xh(e+1);

%get shape functions
sfi=@(x) shapeFn1d(i,x,a,b,shapeFn);
sfj=@(x) shapeFn1d(j,x,a,b,shapeFn);

%function for the integral
fn=@(x) sfi(x).*sfj(x);

%M(i,j) of e-th element = integral of a*b from xe to xe+1
y=gaussQuad1d(fn,a,b,noOfIntegPt);