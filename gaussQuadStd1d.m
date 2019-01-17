%Jenny Be Hw 6 Problem 2
%Gaussian quadrature with 2 or 3 integration pts
%Input: g = function_handle; noOfIntegPt = num of integ points
%used
%OutPut: y = double number for the value of the integral

function [y] = gaussQuadStd1d(g,noOfIntegPt)
%2 point Gaussian Quadrature
if noOfIntegPt== 2
    y= g((sqrt(3))^(-1)) + g(-(sqrt(3))^(-1));
    
%3 point Gaussian Quadrature
elseif noOfIntegPt==3
    y=(5/9).*(g(-(sqrt(3/5))))+(8/9).*g(0)+(5/9).*(g(sqrt(3/5)));
    
%4 point Gaussian Quadrature
elseif noOfIntegPt==4
    w1=(18-sqrt(30))./36; w2=(18+sqrt(30))./36;
    c1=sqrt((3+2.*sqrt(6/5))./7); c2=-sqrt((3-2.*sqrt(6/5))./7);
    y=w1.*g(c1)+w2.*g(c2)+w2.*g(-c2)+w1.*g(-c1);

%5 point Gaussian Quadrature
elseif noOfIntegPt==5
    w1=(322-13.*sqrt(70))./900; w2=(322+13*sqrt(70))./900; w3=128/225;
    c1=(1/3)*sqrt(5+2*sqrt(10/7)); c2=(1/3)*sqrt(5-2*sqrt(10/7)); 
    y=w1.*g(w1)+w2.*g(c2)+(128/225).*g(0)+w2.*g(-c2)+w1.*g(-c1);
else
    fprintf('noOfIntegPt needs to be 2 or 3')
end