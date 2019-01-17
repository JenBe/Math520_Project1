%Jenny Be Homework 7 Problem 1
%Input: a/c/f = function_handle in IBVP, p0 =  # that indicates the
%Dirichlet BC of solution u of the BVP at x=0, e = e-th element, i= i-th
%entry of F, xh= vector of nodes [x1,...,xn+1], shapeFn = 1 - linear
%shapefunction/ 2- quadratic shapefunction, noOfIntegPt= # of integration
%points
%Output: y = F(i) of the e-th element

function [y] = fei(a, c, f, p0, e, i, xh, shapeFn, noOfIntegPt)
%get points
s=xh(e);
t=xh(e+1);

%get shape function and shape function derivatives
sfi=@(x) shapeFn1d(i,x,s,t,shapeFn);
sfdi=@(x) shapeFnDer1d(i,x,s,t,shapeFn);

sf1=@(x) shapeFn1d(1,x,xh(1),xh(2),shapeFn);
sfd1=@(x) shapeFnDer1d(1,x,xh(1),xh(2),shapeFn);

%get function for integral
fn= @(x) f(x).*sfi(x)- a(x).*p0.*sfd1(x).*sfdi(x) - c(x).*p0.*sf1(x).*sfi(x);

y=gaussQuad1d(fn,s,t,noOfIntegPt);
