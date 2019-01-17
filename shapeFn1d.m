%Jenny Be HW 6 Problem 1:
%shape function (linear/quadratic)
%Note: value = 0 if x is not in [x1,x2]
%inputs: i= ith shape function, x= input value of shape fn, x1/x2 = end pts of elements w/ w1<x2, p= order of shape fn
%output: y= shape function value at point x

function [y] = shapeFn1d(i,x,x1,x2,p)
%if x not in [x1,x2] then return 0
n=length(x);
y=zeros(n,1);

for j=1:n
    if x(j)<x1 || x(j)>x2
        y(j)=0;
    
%if x in [x1,x2] give y
    else 
%if shape function is LINEAR
        if p==1
        %case 1 where f(x1)=1 & f(x2)=0
            if i==1 
                m=x1-x2;
                y(j)=(x(j)-x2)./m;
            
        %case 2 where f(x1)=0 & f(x2)=1
            elseif i==2
                m=x2-x1;
                y(j)=(x(j)-x1)./m;
            
            else
                fprintf('i should be 1 or 2')
            end
        
 %if shape function is QUADRATIC
        elseif p==2
            %midpoint of x1 and x2
            mp=(x1+x2)./2;
        %case 1: 1 0 0
            if i==1
                y(j)=((x(j)-mp).*(x(j)-x2))./((x1-mp).*(x1-x2));
         
        %case 2: 0 1 0
            elseif i==2
                y(j)=((x(j)-x1).*(x(j)-x2))./((mp-x1).*(mp-x2));
          
        %case 3: 0 0 1
            elseif i==3
                y(j)=((x(j)-x1).*(x(j)-mp))./((x2-x1).*(x2-mp));
           
            else
                fprintf('i should be 1, 2, or 3')
            end
        
%if input for p not 1 or 2
        else 
            fprintf('p needs to be 1 or 2')
        end
    end
end
