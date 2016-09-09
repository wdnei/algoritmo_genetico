%configuracoes iniciais
tamCromossomo = 5;

taxaCross   = 80;
taxaMutacao = 1;

iteracaoAtual = 1;
iteracaoTotal = 100;

%PASSO1 - gerar populacao inicial
populacao=[10,20,34,89]';
[jPop,iPop]=size(populacao);

%PASSO 2 - avaliar cada individuo
probabilidadeSelecao=aptidao(populacao);


%PASSO 3 - fazer enquanto o criterio nao for satisfeito
while iteracaoAtual<iteracaoTotal
    %PASSO 3.1 - selecionar os mais aptos
    p=1;
    while p<=iPop
        %seleciona par
        pai1=selecao(populacao,probabilidadeSelecao);
        pai2=selecao(populacao,probabilidadeSelecao);
        
        %PASSO 3.2 - CROSSOVER
        nFilhos = 2;
        filhos(p:p+1,:)=crossover(pai1,pai2,nFilhos,tamCromossomo,taxaCross);
        
        %contar a cada dois
        p=p+2;
    end
    
    %PASSO 3.3 - MUTACAO
    filhos = mutacao(filhos, tamCromossomo, taxaMutacao);
    
    
    % A nova populacao eh igual aos filhos gerados
    populacao = filhos;
    
    % Incrementar o numero de iteracao ateh chegar ao total
    iteracaoAtual = iteracaoAtual + 1;
end

result = filhos;