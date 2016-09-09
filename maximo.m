% =========================================================================
% @desc Algoritmo genetico para encontrar um maximo de uma funcao
%
%
% floor(N * rand(4,1))+1 = rand de 1 até N
% =========================================================================
function result=maximo()

    clear all;
    clc;

    % =====================================================================
    % Configuracoes iniciais
    tamCromossomo = 8;

    taxaCross   = 85;
    taxaMutacao = 1;

    iteracaoAtual = 1;
    iteracaoTotal = 100;
    
    binario2real=@(x)0+bin2dec(x)*(3/(2^tamCromossomo-1));
    
    funcaoProblema=@(x)sin(10*binario2real(x))*sin(binario2real(x));
    
    funcaoProblema2=@(x)sin(10*x)*sin(x);
    

    % PASSO 1 - GERAR A POPULACAO INICIAL
    % =====================================================================
    % Inicializar populacao e transformar em binario (cromossomo com 5 bits)

    populacao = dec2bin(ceil(0 + (2^tamCromossomo).*rand(20,1)),tamCromossomo); %gerar populacao aleatoria binaria
    %cromossomos = dec2bin(populacao,tamCromossomo);
    [iPopulacao jPopulacao] = size(populacao);

    % PASSO 2 - AVALIAR CADA INDIVIDUO DA POPULACAO
    % =====================================================================
    % Avaliar populacao

    probSelecao = aptidao(populacao,funcaoProblema);
    

    % PASSO 3 - ENQUANTO O CRITERIO DE PARADA NAO FOR SATISFEITO FAZER
    % =====================================================================
    while iteracaoAtual < iteracaoTotal

        % PASSO 3.1 - SELECIONAR OS INDIVIDUOS MAIS APTOS
        % =================================================================

        % Gerar o numero de filhos igual a populacao anterior
        k = 1;
        while k <= iPopulacao
            % Selecionar o casal
            
            pai1 = selecao(populacao,probSelecao);
            pai2 = selecao(populacao,probSelecao);

            % PASSO 3.1 - CROSSOVER
            % =============================================================
            nFilhos = 2;
            
            filhos(k:k+1,:) = crossover(pai1, pai2, nFilhos, tamCromossomo, taxaCross);

            % Contar dois, pois cada casal tem dois filhos
            k = k+2;
        end

        % PASSO 3.1 - MUTACAO
        % =================================================================

        filhos = mutacao(filhos, tamCromossomo, taxaMutacao);

        % FIM DE PASSO 3.1
        % =================================================================
        
        % ELITISMO
        % =================================================================
        if(0)
        elitePopulacao  = max(populacao);
        eliteFilhos     = max(filhos);
        if elitePopulacao > eliteFilhos
            [nMenor, iMenor] = min(filhos);
            filhos(iMenor,1) = elitePopulacao;
        end
        end
        
        % FIM DE ELITISMO
        % =================================================================
        
        % A nova populacao eh igual aos filhos gerados
        populacao = filhos;

        % Incrementar o numero de iteracao ateh chegar ao total
        iteracaoAtual = iteracaoAtual + 1;
        
    end
    
    result = filhos;
    
    result=binario2real(result);
    
   
    
end
