function [Xlong , Ylong] = myzero(X,Y)
if length(X) > length(Y) 
    a=fix((length(X) - length(Y))/2);
    Ylong = [zeros(a,2);Y;zeros(a,2)];
    Xlong = X;
elseif length(X) < length(Y)
    a=fix((length(Y) - length(X))/2);
    Xlong = [zeros(a,2);X;zeros(a,2)];
    Ylong = Y;
elseif length(X) == length(Y)
    Ylong = Y;
    Xlong = X;
end