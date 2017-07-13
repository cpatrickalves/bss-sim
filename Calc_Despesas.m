% CALCULOS REALIZADOS DE ACORDO COM AS PLANILHAS DO MTPS

%realiza as projecoes de PIB
% Calc_PIB; % OBS - nao alterei nada
% 
% %seleciona a tx do PIB a ser usada
% PIB_ = PIB(6,:);
% %Tx_PIB_ = Tx_PIB(6,:);
% 
% Tx_PIB_ = tx;
% str_titulo = cellstr('Despesas/PIB (%) - Tx PIB FAZENDA');

% Quantas parcelas serao pagas por ano
Num_Beneficios_Ano = 13;

% Aliquota do Beneficio de Auxilio Doenca
Aliquota_Aux_Doenca = ones(1,anos_projetados)*0.91;

%Numero medio de parcelas de auxilio doenca
Num_Medio_Aux_Doenca = 13;


%%%%%%%%%%%%%%%%%%%%%%%% DESPESAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% MASCULINO URBANO %%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculo dos gastos, segundo planilhas da previdencia
% Homens_Urbanos_Metodo_Fluxo.xls --> Apos_TC_R$_Totais_Anuais -> M35
%
%M35
%=L34 * (1+'Parametros.xls'#$Parametros_Gerais.N$38) * (1-'Parametros.xls'#$qx_Homens.L34) +
%	($TC_Entradas.M35 * (MINIMO('Parametros.xls'#$Parâmetros_Gerais.N$24 ; MAXIMO('Parametros.xls'#$Parametros_Gerais.N$22 ; $Media_Salario_Benef.M35 *
%   'Parametros.xls'#$FP_Homens.M35)))) * 'Parametros.xls'#$Parametros_Gerais.N$37
%
% = (despesas do ano&&idade anterior) * (1+(Taxa % Ano Reajuste de Benef�cios) * (1-(Probabilidade de morte na idade X e ano Y)) +
%	((PROJECAO DAS ENTRADAS DE HOMENS NO SETOR URBANO APOS_TC) *
%	(MINIMO((Teto de Beneficio); MAXIMO((SM Medio Anual) ; (MEDIA DOS SALARIOS DE HOMENS NA FT URBANA)*(Fator Previdenciario Homens))))) * (Numero de Beneficios Pagos por Ano)


%%%%%%%%% TC

Despesas_Apos_TC_M_U = zeros(81,anos_projetados);
Despesas_Apos_TC_M_U(:,1) = Desp_Apos_TC_M_U; % valores de 2010

for i=2:anos_projetados,
%   COM FP
    Despesas_Apos_TC_M_U(1,i) = Entradas_Apos_TC_M_U(1,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_M_U(1,i) .* Fator_Previdenciario_M(1,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_M_U(2:81,i) = Despesas_Apos_TC_M_U(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
        Entradas_Apos_TC_M_U(2:81,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_M_U(2:81,i) .* Fator_Previdenciario_M(2:81,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_M_U(81,i) = Despesas_Apos_TC_M_U(81,i) + Despesas_Apos_TC_M_U(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));

end

%%%%%%%%% ID

Despesas_Apos_ID_M_U = zeros(81,anos_projetados);
Despesas_Apos_ID_M_U(:,1) = Desp_Apos_ID_M_U; % valores de 2010

Tx_rep_Sal_Benef_Apos_ID = 0.418421; % fonte: Parametros.xls -> Parametros_Gerais -> linha 49

for i=2:anos_projetados,
    Despesas_Apos_ID_M_U(1,i) = Entradas_Apos_ID_M_U(1,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_ID_M_U(1,i) .* max(1, Fator_Previdenciario_Apos_Id_M(1,i)))).* Tx_rep_Sal_Benef_Apos_ID .* Num_Beneficios_Ano;

    Despesas_Apos_ID_M_U(2:81,i) = Despesas_Apos_ID_M_U(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
        Entradas_Apos_ID_M_U(2:81,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_ID_M_U(2:81,i) .* max(1, Fator_Previdenciario_Apos_Id_M(2:81,i)))) .* Tx_rep_Sal_Benef_Apos_ID .* Num_Beneficios_Ano;

    Despesas_Apos_ID_M_U(81,i) = Despesas_Apos_ID_M_U(81,i) + Despesas_Apos_ID_M_U(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));

end

%%%%%%%%% INV

Despesas_Apos_Inv_M_U = zeros(81,anos_projetados);
Despesas_Apos_Inv_M_U(:,1) = Desp_Apos_Inv_M_U;

Tx_rep_Sal_Benef_Apos_Inv = 0.636027; % fonte: Parametros.xls -> Parametros_Gerais -> linha 49

for i=2:anos_projetados,
     Despesas_Apos_Inv_M_U(1,i) = Entradas_Apos_Invalidez_M_U(1,i) .* max( SM_Medio_Anual(i) , VMB_Apos_Inv_M_U(1,i) .* Tx_rep_Sal_Benef_Apos_Inv) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_M_U(2:81,i) = Despesas_Apos_Inv_M_U(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
         Entradas_Apos_Invalidez_M_U(2:81,i) .* max( SM_Medio_Anual(i) , VMB_Apos_Inv_M_U(2:81,i) .* Tx_rep_Sal_Benef_Apos_Inv) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_M_U(81,i) = Despesas_Apos_Inv_M_U(81,i) + Despesas_Apos_Inv_M_U(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));

end

%%%%%%%%% AUX DOENCA
%Calculo dos gastos, segundo planilhas da previdencia
% Homens_Urbanos_Metodo_Fluxo.xls --> AuxD_R$_Totais_Anuais -> M35
%
%M35
% =Aux�lio_Doen�a!M25*(M�XIMO([Parametros.xls]Par�metros_Gerais!N$22;[Parametros.xls]Par�metros_Gerais!N$44 *
% M�dia_Sal�rio_Benef!M25))*[Parametros.xls]Par�metros_Gerais!N$37
%
% = (Estoque do AuxD) * MAXIMO((SM Medio Anual), (% Benef�cio de Aux�lio Doen�a) * (MEDIA DOS SALARIOS DE HOMENS NA FT URBANA))
% * (Numero de Beneficios Pagos por Ano)

Despesas_Aux_Doenca_M_U = zeros(81,anos_projetados);
Despesas_Aux_Doenca_M_U(:,1) = Desp_Aux_Doenca_M_U;

for i=2:anos_projetados,

     Despesas_Aux_Doenca_M_U(:,i) = Estoque_Auxilio_Doenca_M_U(:,i) .* ...
         max( SM_Medio_Anual(i) , VMB_AuxD_M_U(:,i).* Aliquota_Aux_Doenca(i)) * Num_Medio_Aux_Doenca;

end

%%%%%%%%%%%%%%%%%%%%%%%%%% FEMININO URBANO %%%%%%%%%%%%%%%%%%%%%%%%%%

% O calculo dos gastos e o mesmo do Masculino Urbano

%%%%%%%%% TC

Despesas_Apos_TC_F_U = zeros(81,anos_projetados);
Despesas_Apos_TC_F_U(:,1) = Desp_Apos_TC_F_U;

for i=2:anos_projetados,
%   COM FP
    Despesas_Apos_TC_F_U(1,i) = Entradas_Apos_TC_F_U(1,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_F_U(1,i) .* Fator_Previdenciario_F(1,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_F_U(2:81,i) = Despesas_Apos_TC_F_U(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(1:80,i-1)) + ...
        Entradas_Apos_TC_F_U(2:81,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_F_U(2:81,i) .* Fator_Previdenciario_F(2:81,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_F_U(81,i) = Despesas_Apos_TC_F_U(81,i) + Despesas_Apos_TC_F_U(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(81,i-1));

end

%%%%%%%%% ID

Despesas_Apos_ID_F_U = zeros(81,anos_projetados);
Despesas_Apos_ID_F_U(:,1) = Desp_Apos_ID_F_U;

Tx_rep_Sal_Benef_Apos_ID = 0.418421; % fonte: Parametros.xls -> Parametros_Gerais -> linha 49

for i=2:anos_projetados,
    Despesas_Apos_ID_F_U(1,i) = Entradas_Apos_ID_F_U(1,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_ID_F_U(1,i) .* max(1, Fator_Previdenciario_Apos_Id_F(1,i)))).* Tx_rep_Sal_Benef_Apos_ID .* Num_Beneficios_Ano;

    Despesas_Apos_ID_F_U(2:81,i) = Despesas_Apos_ID_F_U(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(1:80,i-1)) + ...
        Entradas_Apos_ID_F_U(2:81,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_ID_F_U(2:81,i) .* max(1, Fator_Previdenciario_Apos_Id_F(2:81,i)))) .* Tx_rep_Sal_Benef_Apos_ID .* Num_Beneficios_Ano;

   % O erro aumenta consideravelmente usando a formula abaixo
   % Despesas_Apos_ID_F_U(81,i) = Despesas_Apos_ID_F_U(81,i) + Despesas_Apos_ID_F_U(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(81,i-1));

end

%%%%%%%%% INV

Despesas_Apos_Inv_F_U = zeros(81,anos_projetados);
Despesas_Apos_Inv_F_U(:,1) = Desp_Apos_Inv_F_U;

Tx_rep_Sal_Benef_Apos_Inv = 0.636027; % fonte: Parametros.xls -> Par�metros_Gerais -> linha 49

for i=2:anos_projetados,
     Despesas_Apos_Inv_F_U(1,i) = Entradas_Apos_Invalidez_F_U(1,i) .* max( SM_Medio_Anual(i) , VMB_Apos_Inv_F_U(1,i) .* Tx_rep_Sal_Benef_Apos_Inv) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_F_U(2:81,i) = Despesas_Apos_Inv_F_U(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(1:80,i-1)) + ...
         Entradas_Apos_Invalidez_F_U(2:81,i) .* max( SM_Medio_Anual(i) , VMB_Apos_Inv_F_U(2:81,i) .* Tx_rep_Sal_Benef_Apos_Inv) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_F_U(81,i) = Despesas_Apos_Inv_F_U(81,i) + Despesas_Apos_Inv_F_U(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(81,i-1));

end


%%%%%%%%% AUX DOENCA

Despesas_Aux_Doenca_F_U = zeros(81,anos_projetados);
Despesas_Aux_Doenca_F_U(:,1) = Desp_Aux_Doenca_F_U;


for i=2:anos_projetados,

     Despesas_Aux_Doenca_F_U(:,i) = Estoque_Auxilio_Doenca_F_U(:,i) .* ...
         max( SM_Medio_Anual(i) , VMB_AuxD_F_U(:,i).* Aliquota_Aux_Doenca(i) ) * Num_Medio_Aux_Doenca;

end


%%%%%%%%%%%%%%%%%%%%%%%%%% MASCULINO RURAL %%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculo dos gastos, segundo planilhas da previdencia
% Homens_Rurais_Metodo_Fluxo.xls --> Apos_TC_R$_Totais_Anuais -> M50
%
%==L49 * (1+'[Parametros.xls]Par�metros_Gerais'!N$38) * (1-'[Parametros.xls]qx_Homens'!L49) +
%(1,3 * TC_Entradas!M50 * (M�NIMO('[Parametros.xls]Par�metros_Gerais'!N$24 ; M�XIMO('[Parametros.xls]Par�metros_Gerais'!N$22 ; M�dia_Sal�rio_Benef!M50 *
%'[Parametros.xls]FP_Homens'!M50)))) * '[Parametros.xls]Par�metros_Gerais'!N$37
%
% = (despesas do ano&&idade anterior) * (1+(Taxa % Ano Reajuste de Benef�cios) * (1-(Probabilidade de morte na idade X e ano Y)) +
%	(1,3 *(PROJECAO DAS ENTRADAS DE HOMENS NO SETOR URBANO APOS_TC) *
%	(MINIMO((Teto de Beneficio); MAXIMO((SM Medio Anual) ; (MEDIA DOS SALARIOS DE HOMENS NA FT URBANA)*(Fator Previdenciario Homens))))) * (Numero de Beneficios Pagos por Ano)


%%%%%%%%% TC

Despesas_Apos_TC_M_R = zeros(81,anos_projetados);
Despesas_Apos_TC_M_R(:,1) = Desp_Apos_TC_M_R;

for i=2:anos_projetados,
%   COM FP
    Despesas_Apos_TC_M_R(1,i) = Entradas_Apos_TC_M_R(1,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_M_R(1,i) .* Fator_Previdenciario_M(1,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_M_R(2:81,i) = Despesas_Apos_TC_M_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
        1.3*Entradas_Apos_TC_M_R(2:81,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_M_R(2:81,i) .* Fator_Previdenciario_M(2:81,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_M_R(81,i) = Despesas_Apos_TC_M_R(81,i) + Despesas_Apos_TC_M_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));

end

%%%%%%%%% ID
% Calculo dos gastos, segundo planilhas da previdencia
% Homens_Rurais_Metodo_Fluxo.xls --> Apos_Idade_R$_Totais_Anuais -> M65
%
% = Apos_Idade!M65*'[Parametros.xls]Par�metros_Gerais'!N$22*'[Parametros.xls]Par�metros_Gerais'!N$37
%
% = (Qtd de Apos_ID) * (Sal_Min_Medio_anual) * (Numero de Benef. pagos por ano)

Despesas_Apos_ID_M_R = zeros(81,anos_projetados);
Despesas_Apos_ID_M_R(:,1) = Desp_Apos_ID_M_R;
%Valor_Medio_Beneficio_Apos_ID_M_R = Valor_Medio_Beneficio_Apos_ID_M_R;

for i=2:anos_projetados,
    Despesas_Apos_ID_M_R(1,i) = Entradas_Apos_ID_M_R(1,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

    Despesas_Apos_ID_M_R(2:81,i) = Despesas_Apos_ID_M_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
        Entradas_Apos_ID_M_R(2:81,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

    Despesas_Apos_ID_M_R(81,i) = Despesas_Apos_ID_M_R(81,i) + Despesas_Apos_ID_M_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));

end

%%%%%%%%% INV
% Calculo dos gastos, segundo planilhas da previdencia
% Homens_Rurais_Metodo_Fluxo.xls --> Apos_Invalidez_R$_Totais_Anuais -> M36
%
% =Apos_Invalidez!M36 * [Parametros.xls]Par�metros_Gerais!N$22 * [Parametros.xls]Par�metros_Gerais!N$37
%
% = (Qtd de Apos_Inv) * (Sal_Min_Medio_anual) * (Numero de Benef. pagos por ano)

Despesas_Apos_Inv_M_R = zeros(81,anos_projetados);
Despesas_Apos_Inv_M_R(:,1) = Desp_Apos_Inv_M_R;
%Valor_Medio_Beneficio_Apos_Inv_M_R = Valor_Medio_Beneficio_Apos_TC_M_R;

for i=2:anos_projetados,
     Despesas_Apos_Inv_M_R(1,i) = Entradas_Apos_Invalidez_M_R(1,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_M_R(2:81,i) = Despesas_Apos_Inv_M_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
         Entradas_Apos_Invalidez_M_R(2:81,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_M_R(81,i) = Despesas_Apos_Inv_M_R(81,i) + Despesas_Apos_Inv_M_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));

%      Despesas_Apos_Inv_M_R(1,i) = Entradas_Apos_Invalidez_M_R(1,i) .* max( SM_Medio_Anual(i) , Valor_Medio_Beneficio_Apos_Inv_M_R(1,i)).* Num_Beneficios_Ano;
%
%      Despesas_Apos_Inv_M_R(2:81,i) = Despesas_Apos_Inv_M_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(1:80,i-1)) + ...
%          Entradas_Apos_Invalidez_M_R(2:81,i) .* max( SM_Medio_Anual(i) , Valor_Medio_Beneficio_Apos_Inv_M_R(2:81,i)).* Num_Beneficios_Ano;
%
%      Despesas_Apos_Inv_M_R(81,i) = Despesas_Apos_Inv_M_R(81,i) + Despesas_Apos_Inv_M_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_M(81,i-1));
end

%%%%%%%%% AUX DOENCA

Despesas_Aux_Doenca_M_R = zeros(81,anos_projetados);
Despesas_Aux_Doenca_M_R(:,1) = Desp_Aux_Doenca_M_R;

for i=2:anos_projetados,

     Despesas_Aux_Doenca_M_R(:,i) = Estoque_Auxilio_Doenca_M_R(:,i) .* ...
         SM_Medio_Anual(i) * Num_Medio_Aux_Doenca;

end

%%%%%%%%%%%%%%%%%%%%%%%%%% FEMININO RURAL %%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculo dos gastos, segundo planilhas da previdencia
% Mulheres_Rurais_Metodo_Fluxo.xls --> Apos_TC_R$_Totais_Anuais -> M50
%
%= L49 * (1+'[Parametros.xls]Par�metros_Gerais'!N$38) * (1-'[Parametros.xls]qx_Mulheres'!L49) +
%(TC_Entradas!M50 * (M�NIMO('[Parametros.xls]Par�metros_Gerais'!N$24;M�XIMO('[Parametros.xls]Par�metros_Gerais'!N$22;M�dia_Sal�rio_Benef!M50 *
%'[Parametros.xls]FP_Mulheres'!M50)))) * '[Parametros.xls]Par�metros_Gerais'!N$37
%
% = (despesas do ano&&idade anterior) * (1+(Taxa % Ano Reajuste de Benef�cios) * (1-(Probabilidade de morte na idade X e ano Y)) +
%	((PROJECAO DAS ENTRADAS DE MULHERES NO SETOR RURAL APOS_TC) *
%	(MINIMO((Teto de Beneficio); MAXIMO((SM Medio Anual) ; (MEDIA DOS SALARIOS DE MULHERES NA FT URBANA)*(Fator Previdenciario Mulheres))))) * (Numero de Beneficios Pagos por Ano)


%%%%%%%%% TC

Despesas_Apos_TC_F_R = zeros(81,anos_projetados);
Despesas_Apos_TC_F_R(:,1) = Desp_Apos_TC_F_R;

for i=2:anos_projetados,
%   COM FP
    Despesas_Apos_TC_F_R(1,i) = Entradas_Apos_TC_F_R(1,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_F_R(1,i) .* Fator_Previdenciario_F(1,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_F_R(2:81,i) = Despesas_Apos_TC_F_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(1:80,i-1)) + ...
        Entradas_Apos_TC_F_R(2:81,i) .* min( Teto_Beneficio(i) , max( SM_Medio_Anual(i) , VMB_Apos_TC_F_R(2:81,i) .* Fator_Previdenciario_F(2:81,i) )) .* Num_Beneficios_Ano;

    Despesas_Apos_TC_F_R(81,i) = Despesas_Apos_TC_F_R(81,i) + Despesas_Apos_TC_F_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(81,i-1));

end

%%%%%%%%% ID
% Calculo dos gastos, segundo planilhas da previdencia
% Mesmo calculo do M_R
% Homens_Rurais_Metodo_Fluxo.xls --> Apos_Idade_R$_Totais_Anuais -> M65
%
% = Apos_Idade!M65*'[Parametros.xls]Par�metros_Gerais'!N$22*'[Parametros.xls]Par�metros_Gerais'!N$37
%
% = (Qtd de Apos_ID) * (Sal_Min_Medio_anual) * (Numero de Benef. pagos por ano)

Despesas_Apos_ID_F_R = zeros(81,anos_projetados);
Despesas_Apos_ID_F_R(:,1) = Desp_Apos_ID_F_R;

for i=2:anos_projetados,
    Despesas_Apos_ID_F_R(1,i) = Entradas_Apos_ID_F_R(1,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

    Despesas_Apos_ID_F_R(2:81,i) = Despesas_Apos_ID_F_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(1:80,i-1)) + ...
        Entradas_Apos_ID_F_R(2:81,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

    Despesas_Apos_ID_F_R(81,i) = Despesas_Apos_ID_F_R(81,i) + Despesas_Apos_ID_F_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(81,i-1));

end

%%%%%%%%% INV
% Calculo dos gastos, segundo planilhas da previdencia
% Mesmo calculo do M_R
% Homens_Rurais_Metodo_Fluxo.xls --> Apos_Invalidez_R$_Totais_Anuais -> M36
%
% =Apos_Invalidez!M36 * [Parametros.xls]Par�metros_Gerais!N$22 * [Parametros.xls]Par�metros_Gerais!N$37
%
% = (Qtd de Apos_Inv) * (Sal_Min_Medio_anual) * (Numero de Benef. pagos por ano)

Despesas_Apos_Inv_F_R = zeros(81,anos_projetados);
Despesas_Apos_Inv_F_R(:,1) = Desp_Apos_Inv_F_R;

for i=2:anos_projetados,
     Despesas_Apos_Inv_F_R(1,i) = Entradas_Apos_Invalidez_F_R(1,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_F_R(2:81,i) = Despesas_Apos_Inv_F_R(1:80,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(1:80,i-1)) + ...
         Entradas_Apos_Invalidez_F_R(2:81,i) .* SM_Medio_Anual(i) .* Num_Beneficios_Ano;

     Despesas_Apos_Inv_F_R(81,i) = Despesas_Apos_Inv_F_R(81,i) + Despesas_Apos_Inv_F_R(81,i-1).*(1 + Reajuste_Benef(i)).*(1-Prob_Saida_F(81,i-1));
end

%%%%%%%%% AUX DOENCA

Despesas_Aux_Doenca_F_R = zeros(81,anos_projetados);
Despesas_Aux_Doenca_F_R(:,1) = Desp_Aux_Doenca_F_R;

for i=2:anos_projetados,

     Despesas_Aux_Doenca_F_R(:,i) = Estoque_Auxilio_Doenca_F_R(:,i) .* ...
         SM_Medio_Anual(i) * Num_Medio_Aux_Doenca;

end

%%%%%%%%%%% PENSAO
Despesas_Pensao_M_U = zeros(81,anos_projetados);
Despesas_Pensao_M_R = zeros(81,anos_projetados);
Despesas_Pensao_F_U = zeros(81,anos_projetados);
Despesas_Pensao_F_R = zeros(81,anos_projetados);

Despesas_Pensao_M_U(:,1) = Desp_Pens_M_U;
Despesas_Pensao_M_R(:,1) = Desp_Pens_M_R;
Despesas_Pensao_F_U(:,1) = Desp_Pens_F_U;
Despesas_Pensao_F_R(:,1) = Desp_Pens_F_R;

% MASCULINO_URBANO
for i=2:anos_projetados,

    % Para idades de 1 a 20 anos o valor e zero
     %Despesas_Pensao_M_U(1:21,i) = Entradas_Pensao_M_U(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Despesas_Pensao_M_U(22,i) = Prob_Ent_Pensao_F_U(22) * Prob_Saida_F(22,i) .* (Despesas_Apos_TC_F_U(22,i) + Despesas_Apos_ID_F_U(22,i) ...
     + Despesas_Apos_Inv_F_U(22,i)) + Despesas_Pensao_M_U(22,i-1);

     % de 22 a 80 anos
     Despesas_Pensao_M_U(23:81,i) = Despesas_Pensao_M_U(22:80,i-1) .* ( 1 - Prob_Saida_M(23:81,i)) + Prob_Ent_Pensao_F_U(23:81) ...
     .* Prob_Saida_F(23:81,i) .*(Despesas_Apos_TC_F_U(23:81,i) + Despesas_Apos_ID_F_U(23:81,i) + Despesas_Apos_Inv_F_U(23:81,i));

     % 81 anos
     Despesas_Pensao_M_U(81,i) = (Despesas_Pensao_M_U(81,i-1) + Despesas_Pensao_M_U(80,i-1)) .* ( 1 - Prob_Saida_M(81,i)) + ...
     Prob_Ent_Pensao_F_U(81) * Prob_Saida_F(81,i) .* (Despesas_Apos_TC_F_U(81,i) + Despesas_Apos_ID_F_U(81,i) + Despesas_Apos_Inv_F_U(81,i));

end


% MASCULINO_RURAL
for i=2:anos_projetados,

    % Para idades de 1 a 20 anos o valor e zero
     %Despesas_Pensao_M_R(1:21,i) = Entradas_Pensao_M_R(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Despesas_Pensao_M_R(22,i) = Prob_Ent_Pensao_F_R(22) * Prob_Saida_F(22,i) .* (Despesas_Apos_TC_F_R(22,i) + Despesas_Apos_ID_F_R(22,i) ...
     + Despesas_Apos_Inv_F_R(22,i)) + Despesas_Pensao_M_R(22,i-1);

     % de 22 a 80 anos
     Despesas_Pensao_M_R(23:81,i) = Despesas_Pensao_M_R(22:80,i-1) .* ( 1 - Prob_Saida_M(23:81,i)) + Prob_Ent_Pensao_F_R(23:81) ...
     .* Prob_Saida_F(23:81,i) .*(Despesas_Apos_TC_F_R(23:81,i) + Despesas_Apos_ID_F_R(23:81,i) + Despesas_Apos_Inv_F_R(23:81,i));

     % 81 anos
     % OBS: Nao entendi porque ele usa as probabilidades de morte e de gerar pensao
     % para a idade de 77 anos ao inves de 80, acredito que seja um erro - Trechos onde aparecem (81-3)
     Despesas_Pensao_M_R(81,i) = (Despesas_Pensao_M_R(81,i-1) + Despesas_Pensao_M_R(80,i-1)) .* ( 1 - Prob_Saida_M(81,i)) + ...
     Prob_Ent_Pensao_F_R(81-3) * Prob_Saida_F(81-3,i) .* (Despesas_Apos_TC_F_R(81,i) + Despesas_Apos_ID_F_R(81,i) + Despesas_Apos_Inv_F_R(81,i));


end


% FEMININO_URBANO
for i=2:anos_projetados,

     % Para idades de 1 a 20 anos o valor e zero
     %Despesas_Pensao_F_U(1:21,i) = Entradas_Pensao_F_U(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Despesas_Pensao_F_U(22,i) = Prob_Ent_Pensao_M_U(22) * Prob_Saida_M(22,i) .* (Despesas_Apos_TC_M_U(22,i) + Despesas_Apos_ID_M_U(22,i) ...
     + Despesas_Apos_Inv_M_U(22,i)) + Despesas_Pensao_F_U(22,i-1);

     % de 22 a 80 anos
     Despesas_Pensao_F_U(23:81,i) = Despesas_Pensao_F_U(22:80,i-1) .* ( 1 - Prob_Saida_F(23:81,i)) + Prob_Ent_Pensao_M_U(23:81) ...
     .* Prob_Saida_M(23:81,i) .*(Despesas_Apos_TC_M_U(23:81,i) + Despesas_Apos_ID_M_U(23:81,i) + Despesas_Apos_Inv_M_U(23:81,i));

     % 81 anos
     Despesas_Pensao_F_U(81,i) = (Despesas_Pensao_F_U(81,i-1) + Despesas_Pensao_F_U(80,i-1)) .* ( 1 - Prob_Saida_F(81,i)) + ...
     Prob_Ent_Pensao_M_U(81) * Prob_Saida_M(81,i) .* (Despesas_Apos_TC_M_U(81,i) + Despesas_Apos_ID_M_U(81,i) + Despesas_Apos_Inv_M_U(81,i));

end


% FEMININO_RURAL
for i=2:anos_projetados,

     % Para idades de 1 a 20 anos o valor e zero
     %Despesas_Pensao_F_U(1:21,i) = Entradas_Pensao_F_U(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Despesas_Pensao_F_R(22,i) = Prob_Ent_Pensao_M_R(22) * Prob_Saida_M(22,i) .* (Despesas_Apos_TC_M_R(22,i) + Despesas_Apos_ID_M_R(22,i) ...
     + Despesas_Apos_Inv_M_R(22,i)) + Despesas_Pensao_F_R(22,i-1);

     % de 22 a 80 anos
     % OBS: Nao entendi porque ele usa as probabilidades de morte e de gerar pensao
     % para a idade 3 anos no Futuro, ele faz a mesma coisa para as despesas das Apos.
     % Acredito que seja um erro - Trechos onde aparecem (23-3)
     % Tive que alterar o vetor de probabilidades para funcionar
     Despesas_Pensao_F_R(23:81-3,i) = Despesas_Pensao_F_R(22:80-3,i-1) .* ( 1 - Prob_Saida_F(23:81-3,i)) + Prob_Ent_Pensao_M_R(23+3:81) ...
     .* Prob_Saida_M(23+3:81,i) .*(Despesas_Apos_TC_M_R(23+3:81,i) + Despesas_Apos_ID_M_R(23+3:81,i) + Despesas_Apos_Inv_M_R(23+3:81,i));

     % Os valores de probabilidade e despesa para idade acima de 81 anos s�o zero.
     Despesas_Pensao_F_R(81-2:81,i) = Despesas_Pensao_F_R(80-2:80,i-1) .* ( 1 - Prob_Saida_F(81-2:81,i)) + 0 ;

     % 81 anos
     Despesas_Pensao_F_R(81,i) = (Despesas_Pensao_F_R(81,i-1) + Despesas_Pensao_F_R(80,i-1)) .* ( 1 - Prob_Saida_F(81,i)) + ...
     Prob_Ent_Pensao_M_R(81) * Prob_Saida_M(81,i) .* (Despesas_Apos_TC_M_R(81,i) + Despesas_Apos_ID_M_R(81,i) + Despesas_Apos_Inv_M_R(81,i));

end

