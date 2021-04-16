%%%%%%%%%%%%%%%%%%%%%%%%% COMPARAISON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% WANG & ROCK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% entr¨¦e et ¨¦chantillon %%%%%%%%%%%%%%%%%%%%%%%%%
infox = audioinfo('echantillon_4s.mp3');
[X,Fs] = audioread('echantillon_4s.mp3');

infox = audioinfo('6B+4Re.mp3');
[Y,Fs] = audioread('6B+4Re.mp3');


%%%%%%%%%%%%%%%%%%%% BLANC GAUSSIEN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  ENTREE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%sigma = 0.001; % choix de la valeur de la puissance du bruit
%%b1 = sigma*randn(51365,2);
%%b2 = sigma*randn(51362,2);
%%Y = [b1; Y ; b2];

%%%%%%%%%%%%%%%%%%%%%%%%%%  REFERENCE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% alpha = 1; % choix de la valeur de la puissance du bruit
% Ps = abs(alpha^2)*sum(X.^2)/length(X);
% duree_avant = 5;
% duree_apres = 5;
% sigma = 0.01; %% C'est Pb en effet
% x1 = sigma * randn(Fs*duree_avant,2);
% x2 = sigma * randn(Fs*duree_apres,2);
% RSB_dB = -20;
% sigma2 = 0;%Ps/(10^(RSB_dB/10));
% rp = alpha*X + sigma2*randn(length(X),2);
% Y = [x1; rp ; x2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ZERO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
t = (0:length(Xlong)-1)/Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%% AFFICHAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%1
t = (0:length(X)-1)/Fs;
subplot(3,1,1), 
plot (t,X);
ylabel('Amplitude');
title('reference');

%%%2
t = (0:length(Y)-1)/Fs;
subplot(3,1,2),
plot (t,Y);
ylabel('Amplitude');
title('signal entree');

%%%%%%%%%%%%%%%%%%%%%%%%%%% CORRELATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c,lags] = xcorr(X(:,2),Y(:,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESSEMBLANCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       result = find(c>20);
    if ~isempty(result)
        similaire=1; 
    elseif isempty(result)
        similaire=0;
    end
    if similaire == 1
        fprintf('Cela est similaire');
    elseif similaire == 0
        fprintf('Ce nest pas similaire');
    end

%%%3
%lag_sec = (0:length(c)-1)/Fs;
subplot(3,1,3),
plot(lags/Fs,c);
ylabel('Amplitude'); grid on
title('resultat')
