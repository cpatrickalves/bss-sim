%%%%%%%%% CALCULA TODOS OS REAJUSTES 

%2000 a 2060 - INPC - 2016 a 2060 - PROJECAO DA FAZENDA
%INPC = [0.0527 0.0944 0.1474 0.103839 0.061332 0.050474 0.028134 0.051556 0.064814 0.041137 0.064652 0.060799 0.061978 0.055627 0.062283 0.112800 0.055774 0.046974 0.049974 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474 0.046474];

% DADOS DE ENTRADA
%Teto do INSS 2000 a 2016
%Teto_INSS = [1328.25 1430.00 1561.56 2400.00 2508.72 2668.15 2801.56 2894.28 3038.99 3218.90 3467.40 3691.74 3916.20 4159.00 4390.24 4663.75 5189.82];

%Reajuste do Teto do INSS 2001 a 2016
%Reajuste_Teto_INSS = (Teto_INSS(2:17) - Teto_INSS(1:16)) ./ Teto_INSS(1:16);

% 2000 a 2060 - SALARIO MINIMO ANUAL - 2011 a 2060 PROJECAO DA FAZENDA
%SM_Medio_Anual = [151.00 180.00 200.00 240.00 260.00 300.00 350.00 380.00 415.00 465.00 510.00 540.00 622.00 678.00 724.00 788.00 880.00 929.08 972.72 1061.87 1153.79 1254.41 1363.34 1479.30 1605.35 1740.66 1895.56 2052.96 2222.35 2400.29 2590.76 2791.56 3003.99 3231.52 3469.68 3723.96 3989.19 4271.36 4569.68 4884.39 5215.43 5567.77 5945.75 6344.84 6765.03 7209.81 7675.46 8164.68 8682.67 9226.85 9800.40 10405.84 11046.77 11719.09 12423.82 13161.35 13939.10 14757.17 15620.59 16531.06 17491.91];
%Reajuste_SM = [0.1103 (SM_Medio_Anual(2:61)-SM_Medio_Anual(1:60))./SM_Medio_Anual(1:60)];

% LDO 2014 Tab 5.1 
%Reajuste = [0 0 0 0 0 0 0 0 0 0 0 0 0 0.062 0.052 0.045 0.045 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035];
%Reajuste_SM = [0 0 0 0 0 0 0 0 0 0 0 0 0 0.09 0.0612 0.0816 0.092 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609 0.0609];

% LDO 2012 Tab 5.1 
Reajuste_Benef = [0 .0641 0.0521 0.0501 0.05 0.0547 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035];
Reajuste_SM = [0 0.0686 0.1309 0.0974 0.1025 0.1127 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035];
Reajuste_INPC = [0 0.0521 0.0501 0.05 0.0547 0.0448 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035 0.035];


%%%%%%%%%%%%%%%%%%% SALARIO MINIMO ANUAL %%%%%%%%%%%%%%%%%%% 
% Projeta os valores de SM de acordo com os reajustes da LDO

SM_Medio_Anual = zeros(1,anos_projetados); 
SM_Medio_Anual(1) = 510; % valor de 2010

for i = 2:anos_projetados
    SM_Medio_Anual(i) = round(SM_Medio_Anual(i-1) * (1 + Reajuste_SM(i))); 
end    

%%%%%%%%%%%%%%%%%%% VALOR MEDIO DO BENEFICIO %%%%%%%%%%%%%%%%%%% 
% VMB - valor medio do beneficio
% Projeta os valores de VMB de acordo com os reajustes da LDO

VMB_Apos_TC_M_U = zeros(81,anos_projetados);
VMB_Apos_ID_M_U = zeros(81,anos_projetados);
VMB_Apos_Inv_M_U = zeros(81,anos_projetados);
VMB_AuxD_M_U = zeros(81,anos_projetados);

VMB_Apos_TC_M_R = zeros(81,anos_projetados);
VMB_Apos_ID_M_R = zeros(81,anos_projetados);
VMB_Apos_Inv_M_R = zeros(81,anos_projetados);
VMB_AuxD_M_R = zeros(81,anos_projetados);

VMB_Apos_TC_F_U = zeros(81,anos_projetados);
VMB_Apos_ID_F_U = zeros(81,anos_projetados);
VMB_Apos_Inv_F_U = zeros(81,anos_projetados);
VMB_AuxD_F_U = zeros(81,anos_projetados);

VMB_Apos_TC_F_R = zeros(81,anos_projetados);
VMB_Apos_ID_F_R = zeros(81,anos_projetados);
VMB_Apos_Inv_F_R = zeros(81,anos_projetados);
VMB_AuxD_F_R = zeros(81,anos_projetados);

% Inicializa os valores com os valores da Base de dados (DATAPREV 2010)
VMB_Apos_TC_M_U(:,1) = Valor_Medio_Beneficio_Apos_TC_M_U; 
VMB_Apos_ID_M_U(:,1) = Valor_Medio_Beneficio_Apos_ID_M_U; 
VMB_Apos_Inv_M_U(:,1) = Valor_Medio_Beneficio_Apos_Inv_M_U; 
VMB_AuxD_M_U(:,1) = Valor_Medio_Beneficio_AuxD_M_U;

VMB_Apos_TC_M_R(:,1) = Valor_Medio_Beneficio_Apos_TC_M_R; 
VMB_Apos_ID_M_R(:,1) = Valor_Medio_Beneficio_Apos_ID_M_R; 
VMB_Apos_Inv_M_R(:,1) = Valor_Medio_Beneficio_Apos_Inv_M_R; 
VMB_AuxD_M_R(:,1) = Valor_Medio_Beneficio_AuxD_M_R;

VMB_Apos_TC_F_U(:,1) = Valor_Medio_Beneficio_Apos_TC_F_U; 
VMB_Apos_ID_F_U(:,1) = Valor_Medio_Beneficio_Apos_ID_F_U; 
VMB_Apos_Inv_F_U(:,1) = Valor_Medio_Beneficio_Apos_Inv_F_U; 
VMB_AuxD_F_U(:,1) = Valor_Medio_Beneficio_AuxD_F_U;

VMB_Apos_TC_F_R(:,1) = Valor_Medio_Beneficio_Apos_TC_F_R; 
VMB_Apos_ID_F_R(:,1) = Valor_Medio_Beneficio_Apos_ID_F_R; 
VMB_Apos_Inv_F_R(:,1) = Valor_Medio_Beneficio_Apos_Inv_F_R; 
VMB_AuxD_F_R(:,1) = Valor_Medio_Beneficio_AuxD_F_R;


% Reajuste dos beneficios a partir do ano de projecao
for i = 2:anos_projetados
        
    VMB_Apos_TC_M_U(:,i) = round(VMB_Apos_TC_M_U(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_ID_M_U(:,i) = round(VMB_Apos_ID_M_U(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_Inv_M_U(:,i) = round(VMB_Apos_Inv_M_U(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_AuxD_M_U(:,i) = round(VMB_AuxD_M_U(:,i-1).* (1+Reajuste_Benef(i)));       
    
    VMB_Apos_TC_M_R(:,i) = round(VMB_Apos_TC_M_R(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_ID_M_R(:,i) = round(VMB_Apos_ID_M_R(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_Inv_M_R(:,i) = round(VMB_Apos_Inv_M_R(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_AuxD_M_R(:,i) = round(VMB_AuxD_M_R(:,i-1).* (1+Reajuste_Benef(i)));       
    
    VMB_Apos_TC_F_U(:,i) = round(VMB_Apos_TC_F_U(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_ID_F_U(:,i) = round(VMB_Apos_ID_F_U(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_Inv_F_U(:,i) = round(VMB_Apos_Inv_F_U(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_AuxD_F_U(:,i) = round(VMB_AuxD_F_U(:,i-1).* (1+Reajuste_Benef(i)));       
    
    VMB_Apos_TC_F_R(:,i) = round(VMB_Apos_TC_F_R(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_ID_F_R(:,i) = round(VMB_Apos_ID_F_R(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_Apos_Inv_F_R(:,i) = round(VMB_Apos_Inv_F_R(:,i-1).* (1+Reajuste_Benef(i)));   
    VMB_AuxD_F_R(:,i) = round(VMB_AuxD_F_R(:,i-1).* (1+Reajuste_Benef(i)));       
        
end

%%%%%%%%%%%%%%%%%%% TETO DO BENEFICIO %%%%%%%%%%%%%%%%%%% 
% Projeta os valores de teto de acordo com os reajustes da LDO

Teto_Beneficio = zeros(1,anos_projetados); 
Teto_Beneficio(1) = 3467.4 ; % valor de 2010

for i = 2:anos_projetados
    Teto_Beneficio(i) = round(Teto_Beneficio(i-1) * (1 + Reajuste_Benef(i))); 
end    
