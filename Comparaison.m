%%%%%%%%%%%%%%%%%%%%%%%%% COMPARAISON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% WANG & ROCK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%% entrée et échantillon %%%%%%%%%%%%%%%%%%%%%%%%%
infox = audioinfo('reference_humain.mp3');
[X,Fs] = audioread('reference_humain.mp3');

infoy = audioinfo('entree_humain.mp3');
[Y,Fs] = audioread('entree_humain.mp3');


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%% AFFICHAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%1
subplot(3,1,1), 
plot (Xlong);
ylabel('Amplitude');
title('reference');

%%%2
subplot(3,1,2),
plot (Ylong);
ylabel('Amplitude');
title('signal entree');


%%%%%%%%%%%%%%%%%%%%%%%%%%% CORRELATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c,lags] = xcorr(Xlong(:,2),Ylong(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESSEMBLANCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
similaire = 0;

       result = find(c>100);
    if ~isempty(result)
        similaire=1; 
    end
    if similaire == 1
        fprintf('Cela est similaire');
    elseif similaire == 0
        fprintf('Ce nest pas similaire');
    end
    
%%%3
subplot(3,1,3),
plot(lags,c);
ylabel('Amplitude'); grid on
title('4sBruit+4sRe')