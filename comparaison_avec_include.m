%%%%%%%%%%%%%%%%%%%%%%%%% COMPARAISON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% WANG & ROCK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% entrée et échantillon %%%%%%%%%%%%%%%%%%%%%%%%%
infox = audioinfo('reference_humain.mp3');
[X,Fs] = audioread('reference_humain.mp3');

infoy = audioinfo('entree_humain.mp3');
[Y,Fs] = audioread('entree_humain.mp3');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ZERO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Xlong,Ylong] = myzero(X,Y);
t = (0:length(Xlong)-1)/Fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% AFFICHAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%1
subplot(3,1,1), 
plot (t,Xlong);
ylabel('Amplitude');
title('reference');

%%%2
subplot(3,1,2),
plot (t,Ylong);
ylabel('Amplitude');
title('signal entree');

%%%%%%%%%%%%%%%%%%%%%%%%%%% CORRELATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c,lags] = xcorr(Xlong(:,2),Ylong(:,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESSEMBLANCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       similaire = myjudge(c);
    if similaire == 1
        fprintf('Cela est similaire');
    elseif similaire == 0
        fprintf('Ce nest pas similaire');
    end
    
%%%3
lag_sec = (0:length(c)-1)/Fs;
subplot(3,1,3),
plot(lag_sec,c);
ylabel('Amplitude'); grid on
title('deux types de reference')