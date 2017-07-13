%%%%%%%%%%%%%%%%%%%%% RECEITAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OBS - Falta implementar o calculo para o Rural
% OBS - Falta adicionar a densidade de contribuicao

Teto_Contribuicao = 3467.4; % valor de 2010

Receitas_Carteira_Assinada_M = zeros(81,anos_projetados);
Receitas_Carteira_Assinada_F = zeros(81,anos_projetados);
 
%Aliquota = 0.31;
%Remuneracao_Media_M = Remuneracao_Media_M * (1+Reajuste_SM(i));     
%Remuneracao_Media_F = Remuneracao_Media_F * (1+Reajuste_SM(i)); 
   
for i=1:anos_projetados,    

    for k=1:81
         
        if Remuneracao_Media_M(k)/13 < 1556.94
            Aliquota = .08;
        elseif Remuneracao_Media_M(k)/13 < 2594.92
            Aliquota = .09;
        else
            Aliquota = .11;
        end
                
        %Receitas_Carteira_Assinada_M(k,i) = Empregados_M_U(k,i) .*  (Aliquota + .2) .* Remuneracao_Media_M(k);
        Receitas_Carteira_Assinada_M(k,i) = Empregados_M_U(k,i) .*  (Aliquota .* min(Remuneracao_Media_M(k), Teto_Contribuicao) + 0.2 .* Remuneracao_Media_M(k));
        
        if Remuneracao_Media_F(k)/13 < 1556.94
            Aliquota = .08;
        elseif Remuneracao_Media_F(k)/13 < 2594.92
            Aliquota = .09;
        else
            Aliquota = .11;
        end
                
        %Receitas_Carteira_Assinada_F(k,i) = Empregados_F_U(k,i) .*  (Aliquota + .2) .* Remuneracao_Media_F(k);
        Receitas_Carteira_Assinada_F(k,i) = Empregados_F_U(k,i) .*  (Aliquota .* min(Remuneracao_Media_F(k), Teto_Contribuicao) + 0.2 .* Remuneracao_Media_F(k));
     end
end

rj = 1;

for i=2:anos_projetados,    
    
    %rj = rj * (1+Reajuste_SM(i));
    rj = rj * (1+Reajuste_INPC(i));
    %rj = rj * (1+Tx_PIB_(i));
    
    Receitas_Carteira_Assinada_M(:,i) = Receitas_Carteira_Assinada_M(:,i) .* rj .* (1 + produtividade)^i;
    Receitas_Carteira_Assinada_F(:,i) = Receitas_Carteira_Assinada_F(:,i) .* rj .* (1 + produtividade)^i;
end                                                                               
