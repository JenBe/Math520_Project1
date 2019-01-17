%Jenny Be HW 7 Problem 1
%Calculate K(i,j) for the e-th element
%Note: need files shapeFn1d.m, shapeFnDer1d.m, gaussQuad1d.m to run
%Input: a/c = function_handles in IBVP, e = e-th element, ij = ij entry of
%Ke, xh= vector of nodes [x1,..,xn+1], shapeFn = 1-linear shape
%function/2-quadratic shape function, noOfIntegPt= # of integration points
%Output:  y= k(i,j) for e-th element

function [y] = keij(a, c, e, i, j, xh, shapeFn, noOfIntegPt)
%set limits of integrations
s=xh(e); t=xh(e+1);

%get shape functions and shape function derivatives
sfi=@(x) shapeFn1d(i,x,s,t,shapeFn);
sfdi=@(x) shapeFnDer1d(i,x,s,t,shapeFn);
sfj=@(x) shapeFn1d(j,x,s,t,shapeFn);
sfdj=@(x) shapeFnDer1d(j,x,s,t,shapeFn);

fn=@(x) a(x).*sfdi(x).*sfdj(x)+c(x).*sfi(x).*sfj(x);

%Keij = integral of a*(SFi)x*(SFj)x + c*(SFi)*(SFj)
y=gaussQuad1d(fn,s,t,noOfIntegPt);