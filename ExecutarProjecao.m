% Busca reproduzir as projecoes descritas na LDO de 2010
% Periodo das Projecoes: 2012-2031

clear all;

% A LDO de 2012 foi escrita em 2011 e usou (provavelmente) dados de 2010
ano_inicio = 11; % 2010  
ano_final = 32;  % 2031 
anos_projetados = ano_final - ano_inicio + 1;

% Nao altera o estoque, somente a receita
% LDO descreve 1.6 % a.a
produtividade = 0.016;

%adiciona o path com as bases
path(path,'./Bases');

%carrega as bases DEMOGRAFICAS
Base_Populacao_IDADES_IBGE_2008;    % OK com a LDO 2010/2011/2012

Base_Tx_Urbanizacao_LDO_2012;       % OK com a LDO 2012
%Base_Tx_Urbanizacao_MTPS;           % MTPS

% Dados de Mercado de Trabalho da PNAD
Base_Tx_PFT_LDO_2010;               % PNAD 2005 - OBS - Parcialmente igual a LDO 2010/2011/2012
%Base_Tx_PFT_LDO_2014;              % PNAD 2009 - OBS - igual a LDO 2014/2015/2016

Base_Tx_Desemprego_MTPS;            % A LDO nao descreve dados (obtive da Planilha do MTPS)

% Realiza os calculos DEMOGRAFICOS
Calc_Demografico;     % Utiliza a taxa de Urbanização da LDO (Fixa ao longo dos anos)

%Carrega e calcula as bases previdenciarias
Base_Estoque_Previdenciario_2010;           % Dataprev
Base_Despesa_Previdenciaria_2010;           % Dataprev
Base_Probabilidades_Previdenciarias_2010;   % Valores retirados das planilhas do MTPS
Base_Remuneracao_Media_2010;                % Dataprev(nao possui dados rurais)
Base_Valor_Medio_Beneficio_2010;            % Dataprev
Base_Fator_Previdenciario_MTPS;     

if(Ano_Despesas ~= Ano_Estoque),
    error('******Ano do estoque inicial diferente do ano das despesas iniciais******');
end

%faz os calculos de estoques previdenciarios
Calc_Estoques;

% %realiza as projeï¿½ï¿½es de PIB
%Calc_PIB;

%seleciona a tx do PIB a ser usada
%PIB_ = PIB(6,:);
%Tx_PIB_ = Tx_PIB(6,:);
%str_titulo = cellstr('Despsas/PIB (%) - Tx PIB FAZENDA');

%faz os calculos das despesas e receitas do RGPS
Calc_Reajustes;
Calc_Despesas;
Calc_Receitas;

%%%%%%%%%%%%%%%%%%%% TESTES

% Calcula o total de Despesas e Receitas

Despesas_Totais = zeros(anos_projetados,1);

for i=1:anos_projetados
    Despesas_Totais(i) = round(sum(Despesas_Apos_ID_F_U(:,i) + Despesas_Apos_TC_F_U(:,i)...
        + Despesas_Apos_Inv_F_U(:,i) + Despesas_Aux_Doenca_F_U(:,i)...
        + Despesas_Pensao_F_U(:,i) + Despesas_Apos_ID_F_R(:,i)...
        + Despesas_Apos_TC_F_R(:,i) + Despesas_Apos_Inv_F_R(:,i)...
        + Despesas_Aux_Doenca_F_R(:,i) + Despesas_Pensao_F_R(:,i)...
        + Despesas_Apos_ID_M_U(:,i) + Despesas_Apos_TC_M_U(:,i)...
        + Despesas_Apos_Inv_M_U(:,i) + Despesas_Aux_Doenca_M_U(:,i)...
        + Despesas_Pensao_M_U(:,i) + Despesas_Apos_ID_M_R(:,i)...
        + Despesas_Apos_TC_M_R(:,i) + Despesas_Apos_Inv_M_R(:,i)...
        + Despesas_Aux_Doenca_M_R(:,i) + Despesas_Pensao_M_R(:,i)));
end

Receitas_Totais = zeros(anos_projetados,1);

for i=1:anos_projetados
    Receitas_Totais(i) = round(sum(Receitas_Carteira_Assinada_M(:,i)...
        + Receitas_Carteira_Assinada_F(:,i)));
end

Despesas_LDO_2012 = [
    0
280036
313068
346534
384580
430210
458840
489210
521452
555695
592049
630619
671374
714396
759745
807402
857653
909926
964735
1022153
1082276
1145232
];

Receitas_LDO_2012 = [
    0
236634
261583
288009
316533
347790
370496
394234
419462
445920
474008
503801
535255
567758
601830
637516
675008
714110
754642
796844
840717
886643
];


% Coloca na unidade de bilhoes
Despesas_LDO_2012 = Despesas_LDO_2012 * 10^6;
Receitas_LDO_2012 = Receitas_LDO_2012 * 10^6;

%Receitas_Totais = Receitas_Totais * 2.1;

% Calcula o erro em %
Erro_Despesas = (Despesas_LDO_2012 - Despesas_Totais) ./ Despesas_LDO_2012 * 100;
Erro_Receitas = (Receitas_LDO_2012 - Receitas_Totais) ./ Receitas_LDO_2012 * 100;

Erro_Despesas
Erro_Receitas


Empregados_Totais = zeros(anos_projetados,1);

for i=1:anos_projetados
    Empregados_Totais(i) = sum(Empregados_F_U(:,i) +  Empregados_M_U(:,i)...
        +  Empregados_F_R(:,i) +  Empregados_M_R(:,i));
end

%Empreg_PIA = Empregados_Totais ./ sum (Pop_F(16:60,:) + Pop_F(16:60,:));



 