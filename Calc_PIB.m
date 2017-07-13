%fonte: IBGE
%http://www.ibge.gov.br/home/estatistica/economia/contasregionais/2010/default_xls_2002_2010_zip.shtm
%Tabela 01
PIB_2010 = 3770084.87158 * 1e6;

Ano_PIB = 2010;

n_Tx_PIB = 6;

Tx_PIB = zeros(n_Tx_PIB,61);

PIB = zeros(n_Tx_PIB, 61);

%variaveis para auxiliar no plot 

str_PIB = ['';'';'';'';'';''];
legenda_PIB = cellstr(str_PIB);
str_cor_PIB = ['';'';'';'';'';''];
cor_PIB = cellstr(str_cor_PIB);

%%% Para j = n_Tx_PIB = 1 ;
j = 1;

Tx_PIB(j) = 0.5/100;

legenda_PIB(j) = cellstr('0.5%');
cor_PIB(j) = cellstr('b');

PIB(j,11) = PIB_2010;
for i=12:61
    PIB(j,i) = PIB(j,i-1)*(1+Tx_PIB(j));
end

%%% Para j = n_Tx_PIB = 2 ;
j = 2;

Tx_PIB(j) = 1.0/100;

legenda_PIB(j) = cellstr('1.0%');
cor_PIB(j) = cellstr('r');

PIB(j,11) = PIB_2010;
for i=12:61
    PIB(j,i) = PIB(j,i-1)*(1+Tx_PIB(j));
end

%%% Para j = n_Tx_PIB = 3 ;
j = 3;

Tx_PIB(j) = 1.5/100;

legenda_PIB(j) = cellstr('1.5%');
cor_PIB(j) = cellstr('g');

PIB(j,11) = PIB_2010;
for i=12:61
    PIB(j,i) = PIB(j,i-1)*(1+Tx_PIB(j));
end

%%% Para j = n_Tx_PIB = 4 ;
j = 4;

Tx_PIB(j) = 2.0/100;

legenda_PIB(j) = cellstr('2.0%');
cor_PIB(j) = cellstr('y');

PIB(j,11) = PIB_2010;
for i=12:61
    PIB(j,i) = PIB(j,i-1)*(1+Tx_PIB(j));
end

%%% Para j = n_Tx_PIB = 5 ;
j = 5;

Tx_PIB(j) = 2.5/100;

legenda_PIB(j) = cellstr('2.5%');
cor_PIB(j) = cellstr('m');

PIB(j,11) = PIB_2010;
for i=12:61
    PIB(j,i) = PIB(j,i-1)*(1+Tx_PIB(j));
end

%%% Para j = n_Tx_PIB = 6 ;
j = 6;

Tx_PIB(j) = 0/0;

legenda_PIB(j) = cellstr('Tx FAZENDA');
cor_PIB(j) = cellstr('c');

PIB(j,11) = PIB_2010;
tx = zeros(1,61);
tx(12:61) = [3.9/100 1.8/100 2.7/100 0.1/100 -2.8/100 -1.0/100 4.0/100 3.8/100 3.9/100 3.9/100 3.7/100 3.7/100 3.6/100 4.1/100 3.5/100 3.4/100 3.2/100 3.1/100 3.0/100 2.8/100 2.8/100 2.6/100 2.6/100 2.4/100 2.3/100 2.2/100 2.1/100 2.0/100 2.0/100 2.0/100 2.0/100 1.9/100 1.8/100 1.7/100 1.6/100 1.6/100 1.5/100 1.5/100 1.5/100 1.4/100 1.4/100 1.3/100 1.2/100 1.2/100 1.2/100 1.2/100 1.1/100 1.1/100 1.1/100 1.1/100];

PIB(j,11) = PIB_2010;
for i=12:61
    PIB(j,i) = PIB(j,i-1)*(1+tx(i));
end

