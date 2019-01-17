%Jenny Be Project 1
%Find approximated solution to IBVP
%Needed files: massM.m, stiffK.m, loadF.m, bandLU.m, bandforward.m,
%bandbackward.m
%Input: a, c, f =type function handle a(x), c(x), f(x, t) in BVP, p0 =
%number (represents p0 in BC), QL = function handle (represents the BC
%QL(t) at x = L), u0 = function handle (represents IC function u0(x)), 
%L = # that indicates the right end point of the domain (0, L),
%T = # for ending time,dt is a number that represents the time step size, 
%noOfEle=# of elements (subintervals) the user wants to discretize the domain into, 
%shapeFn =# that represents the degree of shape functions to be used
%Output:a cell array that stores the approximated solutions of the exact solution u at every computed time step


function [uh] = myFE1dibvp(a, c, f, p0, QL, u0, L, T, dt, noOfEle, shapeFn)
%make nodes
noip=3;
stepsize= L/noOfEle;
s=noOfEle*shapeFn;
xh=[0:stepsize:L]';
xh1=[0:(L/s):L]';

%make w
ih=length(xh1)-1;
wn= zeros(s,1);
for i= 1:ih
    wn(i)=u0(xh1(i+1));
end
W(:,1)=wn;
uh{1,1}=approxSol(wn,p0,xh,shapeFn);

%time vector
t=[0:dt:T]';
it=length(t)-1;

%make matrices;
M=massM(xh,shapeFn,noip);
K=stiffK(a,c,xh,shapeFn,noip);
dtK=(dt/2).*K;

A=(M+dtK);
[p,q]=bandwidth(A);
   
%form the L and U matrices
A=bandLU(A,p,q);
L= eye(s)+tril(A,-1);
U=triu(A);

%load vector F
for i=1:it
    f1  = @(x) f(x,t(i));
    Fn=loadF(a, c, f1, p0, QL(t(i)), xh, shapeFn, noip);
    
    f2  = @(x) f(x,t(i+1));
    Fn1=loadF(a, c, f2, p0, QL(t(i+1)), xh, shapeFn, noip);
    
    %get b
    b = (M - dtK) * W(:,i) + (dt/2)*(Fn+Fn1);

    %solve for w(n+1)
    z= bandforward(L,b,q);
    x= bandbackward(U,z,p);
    W(:,i+1)= x;
    uh{i+1,1}=approxSol(x,p0,xh,shapeFn);
end
