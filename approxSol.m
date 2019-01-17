% This function takes the solution of the values of the nodes and gives the
% approximated solution on the interval [0,L]
% [uh] = approxSol(w, u0, xh, shapeFn)
% where w is the values of the nodes excluding the node value at x=0, 
% p0 is the Dirichlet BC at x = 0, 
% xh = [x_1,x_2,...,x_{n+1}] is the list of endpoints of all elements, 
% shapeFn indicates the choice of linear (use 1) or quadratic (use 2) shape functions 
% Last updated: Chung-min Lee Mar 25, 2017

function [uh] = approxSol(w, p0, xh, shapeFn)
w = [p0;w];

if (shapeFn == 1) % if linear shape functions are used
    uh = @(x) linearApprox(x,w,xh);
else    % if quadratic shape functions are used
    uh = @(x) quadraticApprox(x,w,xh);
end


%%-------
% assemble linear shape functions on the whole domain

function y = linearApprox(x,v,xh)

y = zeros(size(x));
h = xh(2)-xh(1); % mesh size

% determine which subinterval x belongs to 
ind = floor(x/h);
x1 = ind*h; 
x2 = x1+h;
ind = ind+1;

% the right end point x=L
indLastPt = (ind == length(v));
y(indLastPt) = v(end);

indNotLastPt = find(ind < length(v));
y(indNotLastPt) = v(ind(indNotLastPt))'.*shapeFn1d(1,x(indNotLastPt),x1(indNotLastPt),x2(indNotLastPt),1)...
    + v(ind(indNotLastPt)+1)'.*shapeFn1d(2,x(indNotLastPt),x1(indNotLastPt),x2(indNotLastPt),1);
    

    
   
%%--------
% assemble quadratic shape functions on the whole domain

function y = quadraticApprox(x,v,xh)

y = zeros(size(x));

h = xh(2)-xh(1); % mesh size

% determine which subinterval x belongs to 
ind = floor(x/h);
x1 = ind*h  ; 
x2 = x1+h;
ind = ind+1;

% the right end point x=L
indLastPt = (ind == (length(v)+1)/2);
y(indLastPt) = v(end);


indNotLastPt = find(ind < (length(v)+1)/2);
y(indNotLastPt) = v(2*ind(indNotLastPt)-1)'.*shapeFn1d(1,x(indNotLastPt),x1(indNotLastPt),x2(indNotLastPt),2)...
    + v(2*ind(indNotLastPt))'.*shapeFn1d(2,x(indNotLastPt),x1(indNotLastPt),x2(indNotLastPt),2)...
    + v(2*ind(indNotLastPt)+1)'.*shapeFn1d(3,x(indNotLastPt),x1(indNotLastPt),x2(indNotLastPt),2);

