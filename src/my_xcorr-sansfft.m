%%%%%%%%%%%%%%%%%%%%%%%%% COMPARAISON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% WANG & ROCK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% entrée et échantillon %%%%%%%%%%%%%%%%%%%%%%%%%
infox = audioinfo('echantillon_12s.mp3');
[y,Fs] = audioread('echantillon_12s.mp3');

infox = audioinfo('echantillon_12s.mp3');
[x,Fs] = audioread('echantillon_12s.mp3');

%%%%%%%%%%%%%%%%%%%%%%%%%%%% XCORR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lref=length(y);
lentree=length(x);

N= 50000;
Rxy=zeros(2*N+1,2);
for l= -N:5000:N
if(l>0)
    x=[zeros(l,2);x]
    if length(x) > length(y) 
    ylong = [y;zeros(length(x)-length(y),2)];
    xlong = x;
elseif length(x) < length(y)
    xlong = [x;zeros(length(y)-length(x),2)];
    ylong = y;
elseif length(x) == length(y)
    ylong = y;
    xlong = x;
    end
elseif(l<0)
    ylong=[zeros(-l,2);y];
    xlong=[x;zeros(length(ylong)-length(x),2)];
elseif(l==0)
    xlong=[x;zeros(length(y)-length(x),2)];
    ylong=y;
end

Rxy(l+N+1,:) = sum(xlong.*ylong);
end

[c,lags] = xcorr(x(:,2),y(:,2));
%%%%plot%%%%
%%1
t = (0:length(y)-1)/Fs;
subplot(3,1,1),
plot (t,y);
ylabel('Amplitude');
title('reference');

%%2
t = (0:length(x)-1)/Fs;
subplot(3,1,2),
plot (t,x);
ylabel('Amplitude');
title('signal entree');

%%3
subplot(3,1,3),
plot((0:length(Rxy)-1)/Fs,Rxy);
ylabel('Amplitude'); 
title('resultat')
hold on


plot(lags/Fs,c);
hold off

