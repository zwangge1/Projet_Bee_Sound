%lire les deux fichiers
info = audioinfo('echantillon.mp3')
[X,Fsx] = audioread('echantillon.mp3');
info = audioinfo('AudioCutter_echantillon.mp3')
[Y,Fsy] = audioread('AudioCutter_echantillon.mp3');

X=X(1:100000);
%ajouter 0
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

%%Partie du Spearman
  
if length(Xlong) ~= length(Ylong)  
    error('///faut///');  
    return;  
end  
  
N = length(Xlong); %length  
Xrank = zeros(1 , N); %rand du X  
Yrank = zeros(1 , N); %rand du Y 
  
%calcule_Xrank
for i = 1 : N  
    cont1 = 1; %coissant?
    cont2 = -1; %decoissant? 
    for j = 1 : N  
        if Xlong(i) < Xlong(j)  
            cont1 = cont1 + 1;  
        elseif Xlong(i) == Xlong(j)  
            cont2 = cont2 + 1;  
        end  
    end  
    Xrank(i) = cont1 + mean([0 : cont2]);  
end  
  
%calcule_Yrank 
for i = 1 : N  
    cont1 = 1; %coissant?  
    cont2 = -1; %decoissant? 
    for j = 1 : N  
        if Ylong(i) < Ylong(j)  
            cont1 = cont1 + 1;  
        elseif Ylong(i) == Ylong(j)  
            cont2 = cont2 + 1;  
        end  
    end  
    Yrank(i) = cont1 + mean([0 : cont2]);  
end  

%%spearman_calculer par d  
fenzi = 6 * sum((Xrank - Yrank).^2);  
fenmu = N * (N^2 - 1);  
coeff = 1 - fenzi / fenmu;  

return ;


  
%end of mySpearman  