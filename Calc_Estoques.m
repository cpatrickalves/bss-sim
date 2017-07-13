% Calcula quantas pessoas estao recebendo beneficios ano X, quantas passaram a
% receber e quantas deixaram de receber neste mesmo ano.

%%%%%%%%%%%%%%%%%%% MASCULINO URBANO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Inicia variaveis de estoque
Estoque_Apos_TC_M_U = zeros(81,anos_projetados);
Estoque_Apos_ID_M_U = zeros(81,anos_projetados);
Estoque_Apos_Invalidez_M_U = zeros(81,anos_projetados);
Estoque_Auxilio_Doenca_M_U = zeros(81,anos_projetados);

% Coloca o estoque do ano inicial na matriz
% Valores de 2010
Estoque_Apos_TC_M_U(:,1) = Est_Apos_TC_M_U;
Estoque_Apos_ID_M_U(:,1) = Est_Apos_ID_M_U;
Estoque_Apos_Invalidez_M_U(:,1) = Est_Apos_Inv_M_U;
Estoque_Auxilio_Doenca_M_U(:,1) = Est_Aux_Doenca_M_U;

%inicia variaveis de fluxo de entrada
Entradas_Apos_TC_M_U = zeros(81,anos_projetados);
Entradas_Apos_ID_M_U = zeros(81,anos_projetados);
Entradas_Apos_Invalidez_M_U = zeros(81,anos_projetados);
Entradas_Auxilio_Doenca_M_U = zeros(81,anos_projetados);
Entradas_Pensao_M_U = zeros(81,anos_projetados);

%inicia variaveis de fluxo de saida
Saidas_Apos_TC_M_U = zeros(81,anos_projetados);
Saidas_Apos_ID_M_U = zeros(81,anos_projetados);
Saidas_Apos_Invalidez_M_U = zeros(81,anos_projetados);
Saidas_Auxilio_Doenca_M_U = zeros(81,anos_projetados);
Saidas_Pensao_M_U = zeros(81,anos_projetados);

%Calcula os estoques e os fluxos
for i=2:anos_projetados,

    % Calcula as entradas e saidas no beneficio especifico no ano "i".

    % Apos_TC
    Entradas_Apos_TC_M_U(:,i) = Empregados_M_U(:,i) .* Prob_Ent_Apos_TC_M_U;
    Saidas_Apos_TC_M_U(:,i) = Estoque_Apos_TC_M_U(:,i-1) .* Prob_Saida_M(:,i-1);

    Estoque_Apos_TC_M_U(1,i) = Entradas_Apos_TC_M_U(1,i);
    Estoque_Apos_TC_M_U(2:81,i) = Estoque_Apos_TC_M_U(1:80,i-1) - Saidas_Apos_TC_M_U(1:80,i) + Entradas_Apos_TC_M_U(2:81,i);
    Estoque_Apos_TC_M_U(81,i) = Estoque_Apos_TC_M_U(81,i) + Estoque_Apos_TC_M_U(81,i-1) - Saidas_Apos_TC_M_U(81,i);

    %Prob_Ent_Apos_TC_M_U = Prob_Ent_Apos_TC_M_U .* (1+Var_Prob_Ent_Apos_TC_M_U);

    % Apos_ID
    Entradas_Apos_ID_M_U(:,i) = Empregados_M_U(:,i) .* Prob_Ent_Apos_ID_M_U;
    Saidas_Apos_ID_M_U(:,i) = Estoque_Apos_ID_M_U(:,i-1) .* Prob_Saida_M(:,i-1);

    Estoque_Apos_ID_M_U(1,i) = Entradas_Apos_ID_M_U(1,i);
    Estoque_Apos_ID_M_U(2:81,i) = Estoque_Apos_ID_M_U(1:80,i-1) - Saidas_Apos_ID_M_U(1:80,i) + Entradas_Apos_ID_M_U(2:81,i);
    Estoque_Apos_ID_M_U(81,i) = Estoque_Apos_ID_M_U(81,i) + Estoque_Apos_ID_M_U(81,i-1) - Saidas_Apos_ID_M_U(81,i);

    % Apos_Inv
    Entradas_Apos_Invalidez_M_U(:,i) = Empregados_M_U(:,i) .* Prob_Ent_Apos_Invalidez_M_U;
    Saidas_Apos_Invalidez_M_U(:,i) = Estoque_Apos_Invalidez_M_U(:,i-1) .* Prob_Saida_M(:,i-1);

    Estoque_Apos_Invalidez_M_U(1,i) = Entradas_Apos_Invalidez_M_U(1,i);
    Estoque_Apos_Invalidez_M_U(2:81,i) = Estoque_Apos_Invalidez_M_U(1:80,i-1) - Saidas_Apos_Invalidez_M_U(1:80,i) + Entradas_Apos_Invalidez_M_U(2:81,i);
    Estoque_Apos_Invalidez_M_U(81,i) = Estoque_Apos_Invalidez_M_U(81,i) + Estoque_Apos_Invalidez_M_U(81,i-1) - Saidas_Apos_Invalidez_M_U(81,i);

    % Auxilio Doenca
    Estoque_Auxilio_Doenca_M_U(:,i) = Empregados_M_U(:,i) .* Prob_Ent_Auxilio_Doenca_M_U;

end

%%%%%%%%%%%%%%%%%%% FEMININO URBANO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Inicia variaveis de estoque
Estoque_Apos_TC_F_U = zeros(81,anos_projetados);
Estoque_Apos_ID_F_U = zeros(81,anos_projetados);
Estoque_Apos_Invalidez_F_U = zeros(81,anos_projetados);
Estoque_Auxilio_Doenca_F_U = zeros(81,anos_projetados);

% Coloca o estoque do ano inicial na matriz
% Valores de 2010
Estoque_Apos_TC_F_U(:,1) = Est_Apos_TC_F_U;
Estoque_Apos_ID_F_U(:,1) = Est_Apos_ID_F_U;
Estoque_Apos_Invalidez_F_U(:,1) = Est_Apos_Inv_F_U;
Estoque_Auxilio_Doenca_F_U(:,1) = Est_Aux_Doenca_F_U;

%inicia variaveis de fluxo de entrada
Entradas_Apos_TC_F_U = zeros(81,anos_projetados);
Entradas_Apos_ID_F_U = zeros(81,anos_projetados);
Entradas_Apos_Invalidez_F_U = zeros(81,anos_projetados);
Entradas_Auxilio_Doenca_F_U = zeros(81,anos_projetados);

%inicia variaveis de fluxo de saida
Saidas_Apos_TC_F_U = zeros(81,anos_projetados);
Saidas_Apos_ID_F_U = zeros(81,anos_projetados);
Saidas_Apos_Invalidez_F_U = zeros(81,anos_projetados);
Saidas_Auxilio_Doenca_F_U = zeros(81,anos_projetados);

%Calcula os estoques e os fluxos
for i=2:anos_projetados,

    % Calcula as entradas e saidas no beneficio especifico no ano "i".

    % Apos_TC
    Entradas_Apos_TC_F_U(:,i) = (Empregados_F_U(:,i)) .* Prob_Ent_Apos_TC_F_U;
    Saidas_Apos_TC_F_U(:,i) = Estoque_Apos_TC_F_U(:,i-1) .* Prob_Saida_F(:,i-1);

    Estoque_Apos_TC_F_U(1,i) = Entradas_Apos_TC_F_U(1,i);
    Estoque_Apos_TC_F_U(2:81,i) = Estoque_Apos_TC_F_U(1:80,i-1) - Saidas_Apos_TC_F_U(1:80,i) + Entradas_Apos_TC_F_U(2:81,i);
    Estoque_Apos_TC_F_U(81,i) = Estoque_Apos_TC_F_U(81,i) + Estoque_Apos_TC_F_U(81,i-1) - Saidas_Apos_TC_F_U(81,i);

    % Apos_ID
    Entradas_Apos_ID_F_U(:,i) = (Empregados_F_U(:,i)) .* Prob_Ent_Apos_ID_F_U;
    Saidas_Apos_ID_F_U(:,i) = Estoque_Apos_ID_F_U(:,i-1) .* Prob_Saida_F(:,i-1);

    Estoque_Apos_ID_F_U(1,i) = Entradas_Apos_ID_F_U(1,i);
    Estoque_Apos_ID_F_U(2:81,i) = Estoque_Apos_ID_F_U(1:80,i-1) - Saidas_Apos_ID_F_U(1:80,i) + Entradas_Apos_ID_F_U(2:81,i);
    Estoque_Apos_ID_F_U(81,i) = Estoque_Apos_ID_F_U(81,i) + Estoque_Apos_ID_F_U(81,i-1) - Saidas_Apos_ID_F_U(81,i);

    % Apos_Inv
    Entradas_Apos_Invalidez_F_U(:,i) = (Empregados_F_U(:,i)) .* Prob_Ent_Apos_Invalidez_F_U;
    Saidas_Apos_Invalidez_F_U(:,i) = Estoque_Apos_Invalidez_F_U(:,i-1) .* Prob_Saida_F(:,i-1);

    Estoque_Apos_Invalidez_F_U(1,i) = Entradas_Apos_Invalidez_F_U(1,i);
    Estoque_Apos_Invalidez_F_U(2:81,i) = Estoque_Apos_Invalidez_F_U(1:80,i-1) - Saidas_Apos_Invalidez_F_U(1:80,i) + Entradas_Apos_Invalidez_F_U(2:81,i);
    Estoque_Apos_Invalidez_F_U(81,i) = Estoque_Apos_Invalidez_F_U(81,i) + Estoque_Apos_Invalidez_F_U(81,i-1) - Saidas_Apos_Invalidez_F_U(81,i);

    % Auxilio Doenca
    Estoque_Auxilio_Doenca_F_U(:,i) = (Empregados_F_U(:,i)) .* Prob_Ent_Auxilio_Doenca_F_U;
end


%%%%%%%%%%%%%%%%%%% MASCULINO RURAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Inicia variaveis de estoque
Estoque_Apos_TC_M_R = zeros(81,anos_projetados);
Estoque_Apos_ID_M_R = zeros(81,anos_projetados);
Estoque_Apos_Invalidez_M_R = zeros(81,anos_projetados);
Estoque_Auxilio_Doenca_M_R = zeros(81,anos_projetados);

% Coloca o estoque do ano inicial na matriz
% Valores de 2010
Estoque_Apos_TC_M_R(:,1) = Est_Apos_TC_M_R;
Estoque_Apos_ID_M_R(:,1) = Est_Apos_ID_M_R;
Estoque_Apos_Invalidez_M_R(:,1) = Est_Apos_Inv_M_R;
Estoque_Auxilio_Doenca_M_R(:,1) = Est_Aux_Doenca_M_R;

%inicia variaveis de fluxo de entrada
Entradas_Apos_TC_M_R = zeros(81,anos_projetados);
Entradas_Apos_ID_M_R = zeros(81,anos_projetados);
Entradas_Apos_Invalidez_M_R = zeros(81,anos_projetados);
Entradas_Auxilio_Doenca_M_R = zeros(81,anos_projetados);

%inicia variaveis de fluxo de saida
Saidas_Apos_TC_M_R = zeros(81,anos_projetados);
Saidas_Apos_ID_M_R = zeros(81,anos_projetados);
Saidas_Apos_Invalidez_M_R = zeros(81,anos_projetados);
Saidas_Auxilio_Doenca_M_R = zeros(81,anos_projetados);


%Calcula os estoques e os fluxos
for i=2:anos_projetados,
    
    % Calcula as entradas e saidas no beneficio especifico no ano "i".

    % Apos_TC
    Entradas_Apos_TC_M_R(:,i) = Empregados_M_R(:,i) .* Prob_Ent_Apos_TC_M_R;
    Saidas_Apos_TC_M_R(:,i) = Estoque_Apos_TC_M_R(:,i-1) .* Prob_Saida_M(:,i-1);

    Estoque_Apos_TC_M_R(1,i) = Entradas_Apos_TC_M_R(1,i);
    Estoque_Apos_TC_M_R(2:81,i) = Estoque_Apos_TC_M_R(1:80,i-1) - Saidas_Apos_TC_M_R(1:80,i) + Entradas_Apos_TC_M_R(2:81,i);
    Estoque_Apos_TC_M_R(81,i) = Estoque_Apos_TC_M_R(81,i) + Estoque_Apos_TC_M_R(81,i-1) - Saidas_Apos_TC_M_R(81,i);

    % Apos_ID
    Entradas_Apos_ID_M_R(:,i) = Empregados_M_R(:,i) .* Prob_Ent_Apos_ID_M_R;
    Saidas_Apos_ID_M_R(:,i) = Estoque_Apos_ID_M_R(:,i-1) .* Prob_Saida_M(:,i-1);

    Estoque_Apos_ID_M_R(1,i) = Entradas_Apos_ID_M_R(1,i);
    Estoque_Apos_ID_M_R(2:81,i) = Estoque_Apos_ID_M_R(1:80,i-1) - Saidas_Apos_ID_M_R(1:80,i) + Entradas_Apos_ID_M_R(2:81,i);
    Estoque_Apos_ID_M_R(81,i) = Estoque_Apos_ID_M_R(81,i) + Estoque_Apos_ID_M_R(81,i-1) - Saidas_Apos_ID_M_R(81,i);

    % Apos_Inv
    Entradas_Apos_Invalidez_M_R(:,i) = Empregados_M_R(:,i) .* Prob_Ent_Apos_Invalidez_M_R;
    Saidas_Apos_Invalidez_M_R(:,i) = Estoque_Apos_Invalidez_M_R(:,i-1) .* Prob_Saida_M(:,i-1);

    Estoque_Apos_Invalidez_M_R(1,i) = Entradas_Apos_Invalidez_M_R(1,i);
    Estoque_Apos_Invalidez_M_R(2:81,i) = Estoque_Apos_Invalidez_M_R(1:80,i-1) - Saidas_Apos_Invalidez_M_R(1:80,i) + Entradas_Apos_Invalidez_M_R(2:81,i);
    Estoque_Apos_Invalidez_M_R(81,i) = Estoque_Apos_Invalidez_M_R(81,i) + Estoque_Apos_Invalidez_M_R(81,i-1) - Saidas_Apos_Invalidez_M_R(81,i);

    % Auxilio Doenca
    Estoque_Auxilio_Doenca_M_R(:,i) = Empregados_M_R(:,i) .* Prob_Ent_Auxilio_Doenca_M_R;

end

%%%%%%%%%%%%%%%%%%% FEMININO RURAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Inicia variaveis de estoque
Estoque_Apos_TC_F_R = zeros(81,anos_projetados);
Estoque_Apos_ID_F_R = zeros(81,anos_projetados);
Estoque_Apos_Invalidez_F_R = zeros(81,anos_projetados);
Estoque_Auxilio_Doenca_F_R = zeros(81,anos_projetados);

%coloca o estoque do ano inicial na matriz
Estoque_Apos_TC_F_R(:,1) = Est_Apos_TC_F_R;
Estoque_Apos_ID_F_R(:,1) = Est_Apos_ID_F_R;
Estoque_Apos_Invalidez_F_R(:,1) = Est_Apos_Inv_F_R;
Estoque_Auxilio_Doenca_F_R(:,1) = Est_Aux_Doenca_F_R;

%inicia variaveis de fluxo de entrada
Entradas_Apos_TC_F_R = zeros(81,anos_projetados);
Entradas_Apos_ID_F_R = zeros(81,anos_projetados);
Entradas_Apos_Invalidez_F_R = zeros(81,anos_projetados);
Entradas_Auxilio_Doenca_F_R = zeros(81,anos_projetados);

%inicia variaveis de fluxo de saida
Saidas_Apos_TC_F_R = zeros(81,anos_projetados);
Saidas_Apos_ID_F_R = zeros(81,anos_projetados);
Saidas_Apos_Invalidez_F_R = zeros(81,anos_projetados);
Saidas_Auxilio_Doenca_F_R = zeros(81,anos_projetados);

%Calcula os estoques e os fluxos
for i=2:anos_projetados,

    % Calcula as entradas e saidas no beneficio especifico no ano "i".

    % Apos_TC
    Entradas_Apos_TC_F_R(:,i) = (Empregados_F_R(:,i)) .* Prob_Ent_Apos_TC_F_R;
    Saidas_Apos_TC_F_R(:,i) = Estoque_Apos_TC_F_R(:,i-1) .* Prob_Saida_F(:,i-1);

    Estoque_Apos_TC_F_R(1,i) = Entradas_Apos_TC_F_R(1,i);
    Estoque_Apos_TC_F_R(2:81,i) = Estoque_Apos_TC_F_R(1:80,i-1) - Saidas_Apos_TC_F_R(1:80,i) + Entradas_Apos_TC_F_R(2:81,i);
    Estoque_Apos_TC_F_R(81,i) = Estoque_Apos_TC_F_R(81,i) + Estoque_Apos_TC_F_R(81,i-1) - Saidas_Apos_TC_F_R(81,i);

    % Apos_ID
    Entradas_Apos_ID_F_R(:,i) = (Empregados_F_R(:,i)) .* Prob_Ent_Apos_ID_F_R;
    Saidas_Apos_ID_F_R(:,i) = Estoque_Apos_ID_F_R(:,i-1) .* Prob_Saida_F(:,i-1);

    Estoque_Apos_ID_F_R(1,i) = Entradas_Apos_ID_F_R(1,i);
    Estoque_Apos_ID_F_R(2:81,i) = Estoque_Apos_ID_F_R(1:80,i-1) - Saidas_Apos_ID_F_R(1:80,i) + Entradas_Apos_ID_F_R(2:81,i);
    Estoque_Apos_ID_F_R(81,i) = Estoque_Apos_ID_F_R(81,i) + Estoque_Apos_ID_F_R(81,i-1) - Saidas_Apos_ID_F_R(81,i);

    % Apos_Inv
    Entradas_Apos_Invalidez_F_R(:,i) = (Empregados_F_R(:,i)) .* Prob_Ent_Apos_Invalidez_F_R;
    Saidas_Apos_Invalidez_F_R(:,i) = Estoque_Apos_Invalidez_F_R(:,i-1) .* Prob_Saida_F(:,i-1);

    Estoque_Apos_Invalidez_F_R(1,i) = Entradas_Apos_Invalidez_F_R(1,i);
    Estoque_Apos_Invalidez_F_R(2:81,i) = Estoque_Apos_Invalidez_F_R(1:80,i-1) - Saidas_Apos_Invalidez_F_R(1:80,i) + Entradas_Apos_Invalidez_F_R(2:81,i);
    Estoque_Apos_Invalidez_F_R(81,i) = Estoque_Apos_Invalidez_F_R(81,i) + Estoque_Apos_Invalidez_F_R(81,i-1) - Saidas_Apos_Invalidez_F_R(81,i);

    % Auxilio Doenca
    Estoque_Auxilio_Doenca_F_R(:,i) = (Empregados_F_R(:,i)) .* Prob_Ent_Auxilio_Doenca_F_R;
end


%%%%%%%%%%% PENSAO
Estoque_Pensao_M_U = zeros(81,anos_projetados);
Estoque_Pensao_M_R = zeros(81,anos_projetados);
Estoque_Pensao_F_U = zeros(81,anos_projetados);
Estoque_Pensao_F_R = zeros(81,anos_projetados);

Estoque_Pensao_M_U(:,1) = Est_Pens_M_U;
Estoque_Pensao_M_R(:,1) = Est_Pens_M_R;
Estoque_Pensao_F_U(:,1) = Est_Pens_F_U;
Estoque_Pensao_F_R(:,1) = Est_Pens_F_R;

% MASCULINO_URBANO
for i=2:anos_projetados,

     % Para idades de 1 a 20 anos o valor e zero
     %Estoque_Pensao_M_U(1:21,i) = Entradas_Pensao_M_U(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Estoque_Pensao_M_U(22,i) = Prob_Ent_Pensao_F_U(22) .*(Saidas_Apos_TC_F_U(22,i) + Saidas_Apos_ID_F_U(22,i) ...
     + Saidas_Apos_Invalidez_F_U(22,i)) + Estoque_Pensao_M_U(22,i-1);

     % de 22 a 80 anos
     Estoque_Pensao_M_U(23:81,i) = Estoque_Pensao_M_U(22:80,i-1) .* ( 1 - Prob_Saida_M(23:81,i)) + Prob_Ent_Pensao_F_U(23:81) ...
     .*(Saidas_Apos_TC_F_U(23:81,i) + Saidas_Apos_ID_F_U(23:81,i) + Saidas_Apos_Invalidez_F_U(23:81,i));

     % 81 anos
     Estoque_Pensao_M_U(81,i) = (Estoque_Pensao_M_U(81,i-1) + Estoque_Pensao_M_U(80,i-1)) .* ( 1 - Prob_Saida_M(81,i)) + ...
     Prob_Ent_Pensao_F_U(81) .* (Saidas_Apos_TC_F_U(81,i) + Saidas_Apos_ID_F_U(81,i) + Saidas_Apos_Invalidez_F_U(81,i));

end


% MASCULINO_RURAL
for i=2:anos_projetados,

     % Para idades de 1 a 20 anos o valor e zero
     %Estoque_Pensao_M_R(1:21,i) = Entradas_Pensao_M_R(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Estoque_Pensao_M_R(22,i) = Prob_Ent_Pensao_F_R(22) .*(Saidas_Apos_TC_F_R(22,i) + Saidas_Apos_ID_F_R(22,i) ...
     + Saidas_Apos_Invalidez_F_R(22,i)) + Estoque_Pensao_M_R(22,i-1);

     % de 22 a 80 anos
     Estoque_Pensao_M_R(23:81,i) = Estoque_Pensao_M_R(22:80,i-1) .* ( 1 - Prob_Saida_M(23:81,i)) + Prob_Ent_Pensao_F_R(23:81) ...
     .*(Saidas_Apos_TC_F_R(23:81,i) + Saidas_Apos_ID_F_R(23:81,i) + Saidas_Apos_Invalidez_F_R(23:81,i));

     % 81 anos
     Estoque_Pensao_M_R(81,i) = (Estoque_Pensao_M_R(81,i-1) + Estoque_Pensao_M_R(80,i-1)) .* ( 1 - Prob_Saida_M(81,i)) + ...
     Prob_Ent_Pensao_F_R(81) .* (Saidas_Apos_TC_F_R(81,i) + Saidas_Apos_ID_F_R(81,i) + Saidas_Apos_Invalidez_F_R(81,i));

end


% FEMININO_URBANO
for i=2:anos_projetados,

     % Para idades de 1 a 20 anos o valor e zero
     %Estoque_Pensao_F_U(1:21,i) = Entradas_Pensao_F_U(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Estoque_Pensao_F_U(22,i) = Prob_Ent_Pensao_M_U(22) .*(Saidas_Apos_TC_M_U(22,i) + Saidas_Apos_ID_M_U(22,i) ...
     + Saidas_Apos_Invalidez_M_U(22,i)) + Estoque_Pensao_F_U(22,i-1);

     % de 22 a 80 anos
     Estoque_Pensao_F_U(23:81,i) = Estoque_Pensao_F_U(22:80,i-1) .* ( 1 - Prob_Saida_F(23:81,i)) + Prob_Ent_Pensao_M_U(23:81) ...
     .*(Saidas_Apos_TC_M_U(23:81,i) + Saidas_Apos_ID_M_U(23:81,i) + Saidas_Apos_Invalidez_M_U(23:81,i));

     % 81 anos
     Estoque_Pensao_F_U(81,i) = (Estoque_Pensao_F_U(81,i-1) + Estoque_Pensao_F_U(80,i-1)) .* ( 1 - Prob_Saida_F(81,i)) + ...
     Prob_Ent_Pensao_M_U(81) .* (Saidas_Apos_TC_M_U(81,i) + Saidas_Apos_ID_M_U(81,i) + Saidas_Apos_Invalidez_M_U(81,i));

end


% FEMININO_RURAL
for i=2:anos_projetados,

     % Para idades de 1 a 20 anos o valor e zero
     %Estoque_Pensao_F_R(1:21,i) = Entradas_Pensao_F_R(1:21,i);

     % Para a idade de 21 anos o calculo e diferente
     Estoque_Pensao_F_R(22,i) = Prob_Ent_Pensao_M_R(22) .*(Saidas_Apos_TC_M_R(22,i) + Saidas_Apos_ID_M_R(22,i) ...
     + Saidas_Apos_Invalidez_M_R(22,i)) + Estoque_Pensao_F_R(22,i-1);

     % de 22 a 80 anos
     Estoque_Pensao_F_R(23:81,i) = Estoque_Pensao_F_R(22:80,i-1) .* ( 1 - Prob_Saida_F(23:81,i)) + Prob_Ent_Pensao_M_R(23:81) ...
     .*(Saidas_Apos_TC_M_R(23:81,i) + Saidas_Apos_ID_M_R(23:81,i) + Saidas_Apos_Invalidez_M_R(23:81,i));

     % 81 anos
     Estoque_Pensao_F_R(81,i) = (Estoque_Pensao_F_R(81,i-1) + Estoque_Pensao_F_R(80,i-1)) .* ( 1 - Prob_Saida_F(81,i)) + ...
     Prob_Ent_Pensao_M_R(81) .* (Saidas_Apos_TC_M_R(81,i) + Saidas_Apos_ID_M_R(81,i) + Saidas_Apos_Invalidez_M_R(81,i));

end

% % %%%%%%%%%%%%%%%%%%%%%%%% MEDIDAS TOTAIS
% %
% % %vetor com a população economicamente ativa
% % PEA_F = PEA_F_R + PEA_F_U;
% % PEA_M = PEA_M_R + PEA_M_U;
% % PEA_Total = PEA_F + PEA_M;
% %
% % %quantidade total de contribuintes
% % Contribuintes = Contribuintes_F + Contribuintes_M;
% % Contribuintes_Totais = sum(Contribuintes);
% %
% % %quantidade total de beneficiarios
% % Beneficiarios_Totais = sum(sum(Beneficiarios_F_R)) + sum(sum(Beneficiarios_M_R)) + sum(sum(Beneficiarios_F_U)) + sum(sum(Beneficiarios_M_U));
% %
% % %relação contribuintes/beneficiários
% % Relacao_Contribuintes_Beneficiarios = Contribuintes_totais/Beneficiarios_Totais;
% %
% % %gastos com beneficios
% % Gastos_F = sum(sum(Gastos_F_R)) + sum(sum(Gastos_F_U));
% % Gastos_M = sum(sum(Gastos_M_R)) + sum(sum(Gastos_M_U));
% % Gastos_Totais = Gastos_F + Gastos_M;
%
