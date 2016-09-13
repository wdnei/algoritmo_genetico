% =========================================================================
% @desc Algoritmo genetico para encontrar melhor caminho no problema do
% caxeiro viajante
%
%Autor: Wdnei Ribeiro da Paixao
%Disciplina: Inteligencia Artificial
% =========================================================================
function [melhorCaminho custoCaminho]=caxeiro()

clear all;
clc;

caminhos=[0 2 9 3 6;...
          2 0 4 3 8;...
          9 4 0 7 3;...
          3 3 7 0 3;...
          6 8 3 3 0];

%variaveis de gerenciamento

tamPopulacao=input('Digite o numero de populacoes: ');
maxGeracao=input('Digite o numero maximo de geracoes: ');
taxaCombinacao=input('Digite a taxa de combinação(crossover): ');
taxaMutacao=input('Digite a taxa de mutação: ');
comElitismo=input('Com elitismo 1-Sim 0-Não: ');

numCidades=length(caminhos);
geracaoAtual=1;
corteMin=2;
corteMax=numCidades-1;



%gerar populacao inicial

populacao=[];
for i=1:tamPopulacao
    populacao(i,:)=randperm(5,5);
end


disp('Populacao inicial');
disp(populacao);


%vetor de aptidao
f_aptidao=ones(1,numCidades);


%inicio do loop com calculo de aptidao,cruzamento e  mutacao
while(geracaoAtual<maxGeracao)
    f_aptidao=zeros(1,numCidades);
    
    [f_aptidao pop_distancia_total]=aptidao(populacao,caminhos);
    %vetor selecao
    selecao=[];
    total_aptidao = sum(f_aptidao);
    
    inicio=1;
    %----ELITISMO
    if(comElitismo)
        [maior_aptidao index_maior_aptidao]=max(f_aptidao);
        selecao(1,:)=populacao(index_maior_aptidao,:);
        %marcar o inicio 
        inicio=2;
    end
    
           
    %------ROLETA---------
    %ordenar pela aptidao
    [ord f_aptidao_index_ordem]=sort(f_aptidao,'ascend');
    
    for p = inicio: tamPopulacao
        %escolher o numero aleatorio da jogada
        aleatorio = rand;
        
        setor = 0;
        %disp('D');
        for k = 1 : tamPopulacao
            %calcular o valor do setor
            setor = setor + f_aptidao(k)/total_aptidao;
            %disp([f_aptidao(f_aptidao_index_ordem(k)) total_aptidao f_aptidao(f_aptidao_index_ordem(k))/total_aptidao setor aleatorio]);
            %verificar o setor escolhido
            if(setor >= aleatorio)
                
                selecao(p,:) = populacao(k,:);
                break;
            end
        end
    end    
    
    % -- CROSSOVER    
    populacaoNova=[];
    for p = 1:2: tamPopulacao - 1
        pai1 = selecao(p,:);
        pai2 = selecao(p+1,:);
        aleatorio=rand*100;
        filho1=pai1;
        filho2=pai2;
        if(aleatorio<taxaCombinacao)
            %combinar
            
            corte2=pai2(corteMin:corteMax);
            corte1=pai1(corteMin:corteMax);
            filho1=[ pai1(1:corteMin-1) corte2 pai1(corteMax+1:end)];
            filho2=[ pai2(1:corteMin-1) corte1 pai2(corteMax+1:end)];
            
            %remover repeticao - troca os pontos mapeado pelo mapeado
            %original do pai
            for cc=1:numCidades
                if(cc<corteMin || cc>corteMax)
                    
                    if(sum(filho1==filho1(cc))>1)
                        k=1;
                        
                        while(sum(filho1==corte1(k))>=1)                            
                            k=k+1;
                        end
                        filho1(cc)=corte1(k);
                        
                    end
                    if(sum(filho2==filho2(cc))>1)
                        k=1;

                        while(sum(filho2==corte2(k))>=1)                            
                            k=k+1;
                        end
                        filho2(cc)=corte2(k);
                        
                    end
                end                
            end
                      
        end        
        populacaoNova(p,:)=filho1;
        populacaoNova(p+1,:)=filho2;
        
    end
    
    %---------MUTACAO-- será a troca de pares ou permutacao
    
    
   
    for p = inicio: tamPopulacao
        filho = populacaoNova(p,:);
        for c=1:numCidades
            aleatorio=rand*100;
            if(aleatorio<taxaMutacao)
                %mutar                
                permAleatorio=int8(1+(rand(1,1))*(numCidades-1));
                v1=filho(c);
                v2=filho(permAleatorio);
                filho(c)=v2;
                filho(permAleatorio)=v1;
            end
        end
        populacaoNova(p,:)=filho(1,:);       
        
    end
    
    populacao=populacaoNova;
    
    
    
    geracaoAtual=geracaoAtual+1;
end
disp('Finalizou');
[f_aptidao distancia_total]=aptidao(populacao,caminhos);
[maior_aptidao index_maior_aptidao]=max(f_aptidao);
disp('Maior aptidao:');
disp(maior_aptidao);
disp('Caminho maior aptidao:');
melhorCaminho=populacao(index_maior_aptidao,:);
disp(melhorCaminho);
disp('Distancia Total:');
custoCaminho=distancia_total(index_maior_aptidao);
disp(custoCaminho);





%recuperar maior aptidao


end


function [f_aptidao,pop_distancia_total]=aptidao(populacao,caminhos)
%calcular aptidao
    f_aptidao=[];
    [tam larg]=size(populacao);
    for i=1: tam
        distancias=[];
        for c = 1 : larg - 1
            cidade1 = populacao(i,c);
            cidade2 = populacao(i,c+1);
            if(cidade1 ~= cidade2)
                distancias(c) = caminhos(cidade1,cidade2);
            end
        end
        distanciaTotal= sum(distancias);
        pop_distancia_total(i) = distanciaTotal;
        
        %quanto maior a distancia menor sera a aptidao
        %quando '0' a aptidao eh jogada para infinito
        f_aptidao(i) = 1.0 / (pop_distancia_total(i) + 1e-10);
        
    end
end