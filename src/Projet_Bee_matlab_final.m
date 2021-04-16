%%%%%%%%%%%%%%%%%%%%%%%%% COMPARAISON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% WANG & ROCK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% entr¨¦e et ¨¦chantillon 
infox = audioinfo('echantillon_12s.mp3');
[x,Fs] = audioread('echantillon_12s.mp3');

infox = audioinfo('6B+4Re.mp3');
[y,Fs] = audioread('6B+4Re.mp3');

%% ZERO
if length(x)<length(y)
    x = [x;zeros(length(y)-length(x),2)];
else
    y = [y;zeros(length(x)-length(y),2)];
end

N = length(x);
%% Le resultat de xcorr 
[c,lags] = xcorr(x(:,2),y(:,2));

%% Utilise fourrier pour r¨¦duisez la charge de calcule
c_fft = ifft(fft(x,2*N).*conj(fft(y,2*N)));

%% correlation 
Nx = length(x);
Ny = length(y);
N = max(Nx,Ny);
my_c = zeros(2*N+1,2);
for ell = -1000:1000
    if Nx < Ny
        x_zp = [x;zeros(N-Nx,2)];
        if ell > 0
            xme = [zeros(ell,2);x_zp(1:N-ell,2)];
        else
            xme = [x_zp(-ell+1:N,2);zeros(-ell,2)];
        end
        my_c(N+ell+1:2) = sum(xme.*y);
    else
        y_zp = [y;zeros(N-Ny,2)];
        if ell > 0
            yme = [zeros(ell,2);y_zp(1:N-ell,:)];
        else
            yme = [y_zp(-ell+1:N,:);zeros(-ell,2)];
        end
        my_c(N+ell+1,:) = sum(x.*yme);
    end
    
end

%% plot 
figure;
subplot(3,1,1)
plot(x)
subplot(3,1,2)
plot(y)
subplot(3,1,3)
plot(lags,c,(1:length(c_fft)),c_fft,(-N:N),my_c)

