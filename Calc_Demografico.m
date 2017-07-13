% Calcula de saida do sistema (prob. morte) por sexo
% Estima a quantidade de empregados por sexo e clientela

%Acumula quem tem mais de 80 anos
%Pop_M = zeros(81,61);
%Pop_M(1:80,:) = Base_Pop_M(1:80,:);
%Pop_M(81,:) = sum(Base_Pop_M(81:91,:));
Pop_M = Base_Pop_M(:,ano_inicio:ano_final);

%acumula quem tem mais de 80 anos
%Pop_F = zeros(81,61);
%Pop_F(1:80,:) = Base_Pop_F(1:80,:);
%Pop_F(81,:) = sum(Base_Pop_F(81:91,:));
Pop_F = Base_Pop_F(:,ano_inicio:ano_final);

%Calcula a probabilidade de saida do sistema baseado no tamanho da populacao (probabilidade de morte)
Prob_Saida_M = zeros(81,anos_projetados-1);
for i=1:anos_projetados-1,
    Prob_Saida_M(1:79,i) = 1 - Pop_M(2:80,i+1) ./ Pop_M(1:79,i);
    Prob_Saida_M(80,i) = Prob_Saida_M(79,i);
    %%%%%%%%%%nas planilhas esta assim:
    Prob_Saida_M(81,i) = 1 - Pop_M(81,i+1)./(Pop_M(81,i+1) + Pop_M(80,i).*(1-Prob_Saida_M(80,i))); 
    %%%%%%%%%%acredito que faz mais sentido assim:
    %Prob_Saida_M(81,i) = 1 - (Pop_M(81,i+1) - Pop_M(80,i)*(1-Prob_Saida_M(80,i)))./Pop_M(81,i); 
end

% Repete a Prob do ultimo ano como valor do antepenultimo
Prob_Saida_M = [Prob_Saida_M Prob_Saida_M(:,anos_projetados-1)]; 

Prob_Saida_F = zeros(81,anos_projetados-1);
for i=1:anos_projetados-1,
    Prob_Saida_F(1:79,i) = 1 - Pop_F(2:80,i+1) ./ Pop_F(1:79,i);
    Prob_Saida_F(80,i) = Prob_Saida_F(79,i);
    %%%%%%%%%%nas planilhas esta assim:
    Prob_Saida_F(81,i) = 1 - Pop_F(81,i+1)./(Pop_F(81,i+1) + Pop_F(80,i).*(1-Prob_Saida_F(80,i))); 
    %%%%%%%%%%acredito que faz mais sentido assim:
    %Prob_Saida_F(81,i) = 1 - (Pop_F(81,i+1) - Pop_F(80,i)*(1-Prob_Saida_F(80,i)))./Pop_F(81,i); 
end

% Repete a Prob do ultimo ano como valor do antepenultimo
Prob_Saida_F = [Prob_Saida_F Prob_Saida_F(:,anos_projetados-1)];

%%%%%%%%%%%%%%%%%%% MASCULINO URBANO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Aplica a taxa de urbanizacao
%Pop_M_U = Pop_M .* Base_Tx_Urbanizacao_M;

Pop_M_U = zeros(81,anos_projetados);
for i=1:anos_projetados,
    Pop_M_U(:,i) = Pop_M(:,i) * Base_Tx_Urbanizacao_M(i);
end

% Calcula a quantidade de empregados
Empregados_M_U = zeros(81,anos_projetados);
tx_desemp_M_U = Base_Tx_Desemprego_M_U(:,ano_inicio); 

for i=1:anos_projetados,
    Empregados_M_U(:,i) = Pop_M_U(:,i) .* Base_Tx_PFT_M_U .* (1-tx_desemp_M_U);
end

%%%%%%%%%%%%%%%%%%% MASCULINO RURAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%aplica a taxa de urbanizacao
%Pop_M_R = Pop_M .* (1-Base_Tx_Urbanizacao_M);

Pop_M_R = zeros(81,anos_projetados);

for i=1:anos_projetados,
    Pop_M_R(:,i) = Pop_M(:,i) * (1-Base_Tx_Urbanizacao_M(i));
end

% Calcula a quantidade de empregados
Empregados_M_R = zeros(81,anos_projetados);
tx_desemp_M_R = Base_Tx_Desemprego_M_R(:,ano_inicio); 

for i=1:anos_projetados,
    Empregados_M_R(:,i) = Pop_M_R(:,i) .* Base_Tx_PFT_M_R .* (1-tx_desemp_M_R);
end

%%%%%%%%%%%%%%%%%%% FEMININO URBANO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pop_F_U = zeros(81,anos_projetados);
for i=1:anos_projetados,
    Pop_F_U(:,i) = Pop_F(:,i) * Base_Tx_Urbanizacao_F(i);
end

% Calcula a quantidade de empregados
Empregados_F_U = zeros(81,anos_projetados);
tx_desemp_F_U = Base_Tx_Desemprego_F_U(:,ano_inicio); 

for i=1:anos_projetados,
    Empregados_F_U(:,i) = Pop_F_U(:,i) .* Base_Tx_PFT_F_U .* (1-tx_desemp_F_U);
end
    
%%%%%%%%%%%%%%%%%%% FEMININO RURAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pop_F_R = zeros(81,anos_projetados);

for i=1:anos_projetados,
    Pop_F_R(:,i) = Pop_F(:,i) * (1-Base_Tx_Urbanizacao_F(i));
end

% Calcula a quantidade de empregados
Empregados_F_R = zeros(81,anos_projetados);
tx_desemp_F_R = Base_Tx_Desemprego_F_R(:,ano_inicio); 

for i=1:anos_projetados,
    Empregados_F_R(:,i) = Pop_F_R(:,i) .* Base_Tx_PFT_F_R .* (1-tx_desemp_F_R);
end

% %%%%%%%%%%%%%%%%%%% MEDIDAS TOTAIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % vetor com grau de urbanização
% GU_F = sum(Pop_F_U) ./ sum(Pop_F);
% GU_M = sum(Pop_M_U) ./ sum(Pop_M);
%  
% % razão da dependência demográfica para a população idosa ( >60 anos)
% RDDI_F = sum (Pop_F(61:81,:) ) ./ sum (Pop_F(16:60,:) );
% RDDI_M = sum (Pop_M(61:81,:) ) ./ sum (Pop_M(16:60,:) );
%  
% % razão da dependência demográfica para a população jovem ( <15 anos)
% RDDJ_F = sum (Pop_F(1:16,:) ) ./ sum (Pop_F(16:60,:) );
% RDDJ_M = sum (Pop_M(1:16,:) ) ./ sum (Pop_M(16:60,:) );
% 
% %razão da dependência demográfica total
% RDDT_F = RDDI_F + RDDJ_F;
% RDDT_M = RDDI_M + RDDJ_M;
% 
